# -*- coding: utf-8 -*-
import csv
import os
import random
import re
import sys
import traceback
from collections import OrderedDict
from datetime import datetime, timedelta
from time import sleep
import requests

from my_blog import settings

requests.packages.urllib3.disable_warnings()
from lxml import etree
import json

import django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'my_blog.settings')
django.setup()
from WeiboScrapy.models import weibo

User_Agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:66.0) Gecko/20100101 Firefox/66.0'
# Cookie = '换成你自己的 cookie, 可以参考：https://www.bilibili.com/video/BV1934y127ZM'
Cookie = settings.COOKIE

class WeiboUserScrapy():

    def __init__(self, user_id, filter=0):
        global headers
        self.headers = {
            'Cookie': Cookie,
            'User_Agent': User_Agent
        }

        if filter != 0 and filter != 1:
            sys.exit('filter值应为0或1,请重新输入')

        self.user_id = str(user_id)  # 用户id,即需要我们输入的数字,如昵称为"Dear-迪丽热巴"的id为1669879400
        self.filter = filter  # 取值范围为0、1,程序默认值为0,代表要爬取用户的全部微博,1代表只爬取用户的原创微博
        self.nickname = ''  # 用户昵称,如“Dear-迪丽热巴”
        self.weibo_num = 0  # 用户全部微博数
        self.got_num = 0  # 爬取到的微博数
        self.following = 0  # 用户关注数
        self.followers = 0  # 用户粉丝数
        self.weibo = []  # 存储爬取到的所有微博信息
        if not os.path.exists('user'):
            os.mkdir('user')
        self.run()

    def deal_html(self, url):
        """处理html"""
        try:
            html = requests.get(url, headers=self.headers, verify=False).content
            selector = etree.HTML(html)
            return selector
        except Exception as e:
            print('Error: ', e)
            traceback.print_exc()

    def deal_garbled(self, info):
        """处理乱码"""
        try:
            info = (info.xpath('string(.)').replace(u'\u200b', '').encode(
                sys.stdout.encoding, 'ignore').decode(sys.stdout.encoding))
            return info
        except Exception as e:
            print('Error: ', e)
            traceback.print_exc()

    def get_nickname(self):
        """获取用户昵称"""
        try:
            url = 'https://weibo.cn/{}/info'.format(self.user_id)
            selector = self.deal_html(url)
            nickname = selector.xpath('//title/text()')[0]
            self.nickname = nickname[:-3]
            if self.nickname == '登录 - 新' or self.nickname == '新浪':
                sys.exit('cookie错误或已过期')
            print('用户昵称: ' + self.nickname)
        except Exception as e:
            print('Error: ', e)
            traceback.print_exc()

    def get_user_info(self, selector):
        """获取用户昵称、微博数、关注数、粉丝数"""
        try:
            self.get_nickname()  # 获取用户昵称
            user_info = selector.xpath("//div[@class='tip2']/*/text()")

            self.weibo_num = (user_info[0][3:-1])
            print('微博数: ' + str(self.weibo_num))

            self.following = (user_info[1][3:-1])
            print('关注数: ' + str(self.following))

            self.followers = (user_info[2][3:-1])
            print('粉丝数: ' + str(self.followers))
            print('*' * 100)
        except Exception as e:
            print('Error: ', e)
            traceback.print_exc()

    def get_page_num(self, selector):
        """获取微博总页数"""
        try:
            if selector.xpath("//input[@name='mp']") == []:
                page_num = 1
            else:
                page_num = (int)(
                    selector.xpath("//input[@name='mp']")[0].attrib['value'])
            return page_num
        except Exception as e:
            print('Error: ', e)
            traceback.print_exc()

    def get_long_weibo(self, weibo_link):
        """获取长原创微博"""
        try:
            selector = self.deal_html(weibo_link)
            info = selector.xpath("//div[@class='c']")[1]
            wb_content = self.deal_garbled(info)
            wb_time = info.xpath("//span[@class='ct']/text()")[0]
            weibo_content = wb_content[wb_content.find(':') +
                                       1:wb_content.rfind(wb_time)]
            return weibo_content
        except Exception as e:
            print('Error: ', e)
            traceback.print_exc()

    def get_original_weibo(self, info, weibo_id):
        """获取原创微博"""
        try:
            weibo_content = self.deal_garbled(info)
            weibo_content = weibo_content[:weibo_content.rfind('赞')]
            a_text = info.xpath('div//a/text()')
            if '全文' in a_text:
                weibo_link = 'https://weibo.cn/comment/' + weibo_id
                wb_content = self.get_long_weibo(weibo_link)
                if wb_content:
                    weibo_content = wb_content
            return weibo_content
        except Exception as e:
            print('Error: ', e)
            traceback.print_exc()

    def get_long_retweet(self, weibo_link):
        """获取长转发微博"""
        try:
            wb_content = self.get_long_weibo(weibo_link)
            weibo_content = wb_content[:wb_content.rfind('原文转发')]
            return weibo_content
        except Exception as e:
            print('Error: ', e)
            traceback.print_exc()

    def get_retweet(self, info, weibo_id):
        """获取转发微博"""
        try:
            original_user = info.xpath("div/span[@class='cmt']/a/text()")
            if not original_user:
                wb_content = '转发微博已被删除'
                return wb_content
            else:
                original_user = original_user[0]
            wb_content = self.deal_garbled(info)
            wb_content = wb_content[wb_content.find(':') +
                                    1:wb_content.rfind('赞')]
            wb_content = wb_content[:wb_content.rfind('赞')]
            a_text = info.xpath('div//a/text()')
            if '全文' in a_text:
                weibo_link = 'https://weibo.cn/comment/' + weibo_id
                weibo_content = self.get_long_retweet(weibo_link)
                if weibo_content:
                    wb_content = weibo_content
            retweet_reason = self.deal_garbled(info.xpath('div')[-1])
            retweet_reason = retweet_reason[:retweet_reason.rindex('赞')]
            wb_content = (retweet_reason + '\n' + '原始用户: ' + original_user +
                          '\n' + '转发内容: ' + wb_content)
            return wb_content
        except Exception as e:
            print('Error: ', e)
            traceback.print_exc()

    def is_original(self, info):
        """判断微博是否为原创微博"""
        is_original = info.xpath("div/span[@class='cmt']")
        if len(is_original) > 3:
            return False
        else:
            return True

    def get_weibo_content(self, info, is_original):
        """获取微博内容"""
        try:
            weibo_id = info.xpath('@id')[0][2:]
            if is_original:
                weibo_content = self.get_original_weibo(info, weibo_id)
            else:
                weibo_content = self.get_retweet(info, weibo_id)
            print(weibo_content)
            return weibo_content
        except Exception as e:
            print('Error: ', e)
            traceback.print_exc()

    def get_publish_place(self, info):
        """获取微博发布位置"""
        try:
            div_first = info.xpath('div')[0]
            a_list = div_first.xpath('a')
            publish_place = '无'
            for a in a_list:
                if ('place.weibo.com' in a.xpath('@href')[0]
                        and a.xpath('text()')[0] == '显示地图'):
                    weibo_a = div_first.xpath("span[@class='ctt']/a")
                    if len(weibo_a) >= 1:
                        publish_place = weibo_a[-1]
                        if ('视频' == div_first.xpath(
                                "span[@class='ctt']/a/text()")[-1][-2:]):
                            if len(weibo_a) >= 2:
                                publish_place = weibo_a[-2]
                            else:
                                publish_place = u'无'
                        publish_place = self.deal_garbled(publish_place)
                        break
            print('微博发布位置: ' + publish_place)
            return publish_place
        except Exception as e:
            print('Error: ', e)
            traceback.print_exc()

    def get_publish_time(self, info):
        """获取微博发布时间"""
        try:
            str_time = info.xpath("div/span[@class='ct']")
            str_time = self.deal_garbled(str_time[0])
            publish_time = str_time.split('来自')[0]
            if '刚刚' in publish_time:
                publish_time = datetime.now().strftime('%Y-%m-%d %H:%M')
            elif '分钟' in publish_time:
                minute = publish_time[:publish_time.find('分钟')]
                minute = timedelta(minutes=int(minute))
                publish_time = (datetime.now() -
                                minute).strftime('%Y-%m-%d %H:%M')
            elif '今天' in publish_time:
                today = datetime.now().strftime('%Y-%m-%d')
                time = publish_time[3:]
                publish_time = today + ' ' + time
            elif '月' in publish_time:
                year = datetime.now().strftime('%Y')
                month = publish_time[0:2]
                day = publish_time[3:5]
                time = publish_time[7:12]
                publish_time = year + '-' + month + '-' + day + ' ' + time
            else:
                publish_time = publish_time[:16]
            print('微博发布时间: ' + publish_time)
            return publish_time
        except Exception as e:
            print('Error: ', e)
            traceback.print_exc()

    def get_publish_tool(self, info):
        """获取微博发布工具"""
        try:
            str_time = info.xpath("div/span[@class='ct']")
            str_time = self.deal_garbled(str_time[0])
            if len(str_time.split('来自')) > 1:
                publish_tool = str_time.split('来自')[1]
            else:
                publish_tool = '无'
            print('微博发布工具: ' + publish_tool)
            return publish_tool
        except Exception as e:
            print('Error: ', e)
            traceback.print_exc()

    def get_weibo_footer(self, info):
        """获取微博点赞数、转发数、评论数"""
        try:
            footer = {}
            pattern = r'\d+'
            str_footer = info.xpath('div')[-1]
            str_footer = self.deal_garbled(str_footer)
            str_footer = str_footer[str_footer.rfind('赞'):]
            weibo_footer = re.findall(pattern, str_footer, re.M)

            up_num = int(weibo_footer[0])
            print('点赞数: ' + str(up_num))
            footer['up_num'] = up_num

            retweet_num = int(weibo_footer[1])
            print('转发数: ' + str(retweet_num))
            footer['retweet_num'] = retweet_num

            comment_num = int(weibo_footer[2])
            print('评论数: ' + str(comment_num))
            footer['comment_num'] = comment_num
            return footer
        except Exception as e:
            print('Error: ', e)
            traceback.print_exc()

    def extract_picture_urls(self, info, weibo_id):
        print('开始提取图片 URL')
        """提取微博原始图片url"""
        try:
            a_list = info.xpath('./div/a/@href')
            # first_pic = 'https://weibo.cn/mblog/pic/' + weibo_id + '?rl=0'
            all_pic = 'https://weibo.cn/mblog/picAll/' + weibo_id + '?rl=1'
            # print('alist', a_list, all_pic)
            # lll = info.xpath('./div[2]/a[1]/@href')
            # if lll==:#first_pic in a_list:
            if all_pic in a_list:
                selector = self.deal_html(all_pic)
                preview_picture_list = selector.xpath('//img/@src')
                picture_list = [
                    p.replace('/thumb180/', '/large/')
                    for p in preview_picture_list
                ]
                picture_urls = ' '.join(picture_list)
                print(picture_urls)
            else:
                picture_urls = '无'
                if info.xpath('.//img/@src'):
                    preview_picture = info.xpath('.//img/@src')[-1]
                    picture_urls = preview_picture.replace(
                        '/wap180/', '/large/')
                else:
                    print(traceback.format_exc())
                    # sys.exit(
                    #     "爬虫微博可能被设置成了'不显示图片'，请前往"
                    #     "'https://weibo.cn/account/customize/pic'，修改为'显示'"
                    # )
            return picture_urls
        except Exception as e:
            print('Error: ', e)
            traceback.print_exc()

    # def extract_picture_urls(self, info, weibo_id):
    #     """提取微博原始图片url"""
    #     try:
    #         a_list = info.xpath('div/a/@href')
    #         first_pic = 'https://weibo.cn/mblog/pic/' + weibo_id + '?rl=0'
    #         all_pic = 'https://weibo.cn/mblog/picAll/' + weibo_id + '?rl=1'
    #         if first_pic in a_list:
    #             if all_pic in a_list:
    #                 selector = self.deal_html(all_pic)
    #                 preview_picture_list = selector.xpath('//img/@src')
    #                 picture_list = [
    #                     p.replace('/thumb180/', '/large/')
    #                     for p in preview_picture_list
    #                 ]
    #                 picture_urls = ','.join(picture_list)
    #             else:
    #                 if info.xpath('.//img/@src'):
    #                     preview_picture = info.xpath('.//img/@src')[-1]
    #                     picture_urls = preview_picture.replace(
    #                         '/wap180/', '/large/')
    #                 else:
    #                     sys.exit(
    #                         "爬虫微博可能被设置成了'不显示图片'，请前往"
    #                         "'https://weibo.cn/account/customize/pic'，修改为'显示'"
    #                     )
    #         else:
    #             picture_urls = '无'
    #         return picture_urls
    #     except Exception as e:
    #         print('Error: ', e)
    #         traceback.print_exc()

    def get_picture_urls(self, info, is_original):
        """获取微博原始图片url"""
        try:
            weibo_id = info.xpath('@id')[0][2:]
            picture_urls = {}
            if is_original:
                original_pictures = self.extract_picture_urls(info, weibo_id)
                picture_urls['original_pictures'] = original_pictures
                if not self.filter:
                    picture_urls['retweet_pictures'] = '无'
            else:
                retweet_url = info.xpath("div/a[@class='cc']/@href")[0]
                retweet_id = retweet_url.split('/')[-1].split('?')[0]
                retweet_pictures = self.extract_picture_urls(info, retweet_id)
                picture_urls['retweet_pictures'] = retweet_pictures
                a_list = info.xpath('div[last()]/a/@href')
                original_picture = '无'
                for a in a_list:
                    if a.endswith(('.gif', '.jpeg', '.jpg', '.png')):
                        original_picture = a
                        break
                picture_urls['original_pictures'] = original_picture
            return picture_urls
        except Exception as e:
            print('Error: ', e)
            traceback.print_exc()

    def get_one_weibo(self, info):
        """获取一条微博的全部信息"""
        try:
            weibo = OrderedDict()
            is_original = self.is_original(info)
            if (not self.filter) or is_original:
                weibo['id'] = info.xpath('@id')[0][2:]
                weibo['link'] = 'https://weibo.cn/comment/{}?uid={}&rl=0#cmtfrm'.format(weibo['id'], self.user_id)
                weibo['content'] = self.get_weibo_content(info,
                                                          is_original)  # 微博内容
                picture_urls = self.get_picture_urls(info, is_original)
                weibo['original_pictures'] = picture_urls[
                    'original_pictures']  # 原创图片url
                if not self.filter:
                    weibo['retweet_pictures'] = picture_urls[
                        'retweet_pictures']  # 转发图片url
                    weibo['original'] = is_original  # 是否原创微博
                weibo['publish_place'] = self.get_publish_place(info)  # 微博发布位置
                weibo['publish_time'] = self.get_publish_time(info)  # 微博发布时间
                weibo['publish_tool'] = self.get_publish_tool(info)  # 微博发布工具
                footer = self.get_weibo_footer(info)
                weibo['up_num'] = footer['up_num']  # 微博点赞数
                weibo['retweet_num'] = footer['retweet_num']  # 转发数
                weibo['comment_num'] = footer['comment_num']  # 评论数
            else:
                weibo = None
            return weibo
        except Exception as e:
            print('Error: ', e)
            traceback.print_exc()

    def get_one_page(self, page):
        """获取第page页的全部微博"""
        try:
            url = f'https://weibo.cn/u/{self.user_id}?page={page}'
            selector = self.deal_html(url)
            info = selector.xpath("//div[@class='c']")
            is_exist = info[0].xpath("div/span[@class='ctt']")
            if is_exist:
                for i in range(0, len(info) - 2):
                    weibo = self.get_one_weibo(info[i])
                    if weibo:
                        self.weibo.append(weibo)
                        self.got_num += 1
                        print('-' * 100)
        except Exception as e:
            print('Error: ', e)
            traceback.print_exc()

    def write_csv(self, wrote_num):
        """将爬取的信息写入csv文件"""
        try:
            result_headers = [
                'wid',
                'weibo_link',
                'content',
                'img_urls',
                'location',
                'publish_time',
                'publish_tool',
                'like_num',
                'forward_num',
                'comment_num',
            ]
            if not self.filter:
                result_headers.insert(4, 'origin_img_urls')
                result_headers.insert(5, 'is_origin')
            result_data = [w.values() for w in self.weibo][wrote_num:]

            # with open('./user/{}_{}_{}博_{}粉_{}关注.csv'.format_excc(self.user_id,self.nickname,self.weibo_num, self.followers,self.following),'a',encoding='utf-8-sig',newline='') as f:
            with open('./user/{}_{}.csv'.format(self.user_id, self.nickname), 'a', encoding='utf-8-sig',
                      newline='') as f:
                writer = csv.writer(f)
                if wrote_num == 0:
                    writer.writerows([result_headers])
                writer.writerows(result_data)
            print(u'%d条微博写入csv文件完毕:' % self.got_num)
        except Exception as e:
            print('Error: ', e)
            traceback.print_exc()

    def write_db(self, wrote_num, item):
        """将爬取的信息写入数据库"""
        try:
            result_data = [w.values() for w in self.weibo][wrote_num:]
            # for w in self.weibo:
            #     v = w.values()
            for w in result_data:
                v = list(w)
                # 查看记录是否存在
                try:
                    wbRecord = weibo.objects.get(wid=v[0])
                    # 有记录,更新
                    wbRecord.wuid = item.user_id
                    wbRecord.wnickname = item.nickname
                    # wbRecord.wid = v[0]
                    wbRecord.weibo_link = v[1]
                    wbRecord.content = v[2]
                    wbRecord.img_urls = v[3]
                    wbRecord.location = v[4]
                    # 微博时间格式是 '2022-10-14 14:44 ' 即分+空格
                    wbRecord.publish_time = v[5].rstrip()
                    wbRecord.publish_tool = v[6]
                    wbRecord.like_num = v[7]
                    wbRecord.forward_num = v[8]
                    wbRecord.comment_num = v[9]
                    # wid, weibo_link, content, img_urls, location, publish_time, publish_tool, like_num, forward_num, comment_num
                    wbRecord.save()
                except:
                    # 无记录，新增
                    obj_weibo = weibo()
                    obj_weibo.wuid = item.user_id
                    obj_weibo.wnickname = item.nickname
                    obj_weibo.wid = v[0]
                    obj_weibo.weibo_link = v[1]
                    obj_weibo.content = v[2]
                    obj_weibo.img_urls = v[3]
                    obj_weibo.location = v[4]
                    # 微博时间格式是 '2022-10-14 14:44 ' 即分+空格
                    obj_weibo.publish_time = v[5].rstrip()
                    obj_weibo.publish_tool = v[6]
                    obj_weibo.like_num = v[7]
                    obj_weibo.forward_num = v[8]
                    obj_weibo.comment_num = v[9]
                    # wid, weibo_link, content, img_urls, location, publish_time, publish_tool, like_num, forward_num, comment_num
                    obj_weibo.save()

            print(u'%d条微博写入数据库完毕:' % self.got_num)
        except Exception as e:
            print('Error: ', e)
            traceback.print_exc()

    def write_file(self, wrote_num, item):
        """写文件"""
        if self.got_num > wrote_num:
            self.write_csv(wrote_num)
            # 写数据库
            self.write_db(wrote_num, item)

    def get_weibo_info(self):
        """获取微博信息"""
        try:
            url = f'https://weibo.cn/u/{self.user_id}'
            selector = self.deal_html(url)
            self.get_user_info(selector)  # 获取用户昵称、微博数、关注数、粉丝数
            page_num = self.get_page_num(selector)  # 获取微博总页数
            wrote_num = 0
            page1 = 0
            user_page_config = 'user_page.json'
            if not os.path.exists('user_page.json'):
                page = 1
                with open(user_page_config, 'w', encoding='utf-8-sig') as f:
                    f.write(json.dumps({f'{self.user_id}': page}, indent=2))
            else:
                with open(user_page_config, 'r', encoding='utf-8-sig') as f:
                    raw_json = json.loads(f.read())
                    if self.user_id in raw_json.keys():
                        page = raw_json[self.user_id]
                    else:
                        page = 0

            random_pages = random.randint(1, 5)
            for page in range(page, page_num + 1):
                self.get_one_page(page)  # 获取第page页的全部微博

                with open(user_page_config, 'r', encoding='utf-8-sig') as f:
                    old_data = json.loads(f.read())
                    old_data[f'{self.user_id}'] = page

                with open(user_page_config, 'w', encoding='utf-8-sig') as f:
                    f.write(json.dumps(old_data, indent=2))

                if page % 3 == 0:  # 每爬3页写入一次文件
                    self.write_file(wrote_num, self)
                    wrote_num = self.got_num

                # 通过加入随机等待避免被限制。爬虫速度过快容易被系统限制(一段时间后限
                # 制会自动解除)，加入随机等待模拟人的操作，可降低被系统限制的风险。默
                # 认是每爬取1到5页随机等待6到10秒，如果仍然被限，可适当增加sleep时间
                if page - page1 == random_pages and page < page_num:
                    sleep(random.randint(6, 10))
                    page1 = page
                    random_pages = random.randint(1, 5)
            self.write_file(wrote_num, self)  # 将剩余不足3页的微博写入文件
            if not self.filter:
                print('共爬取' + str(self.got_num) + '条微博')
            else:
                print('共爬取' + str(self.got_num) + '条原创微博')
        except Exception as e:
            print('Error: ', e)
            traceback.print_exc()

    def run(self):
        """运行爬虫"""
        try:
            self.get_weibo_info()
            print('信息抓取完毕')
            print('*' * 100)

        except Exception as e:
            print('Error: ', e)
            print(traceback.format_exc())


if __name__ == '__main__':
    # WeiboUserScrapy(user_id=2541980464, filter=0)
    # 0 所有微博；1原创微博
    # WeiboUserScrapy(user_id=1669879400, filter=1)
    WeiboUserScrapy(user_id=2180399745, filter=1)