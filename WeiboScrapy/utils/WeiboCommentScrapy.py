# -*- coding: utf-8 -*-

import requests

from my_blog import settings
import traceback

requests.packages.urllib3.disable_warnings()
from lxml import etree
from datetime import datetime, timedelta
from threading import Thread
import csv
from math import ceil
import os
import re
from time import sleep
from random import randint

import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'my_blog.settings')
django.setup()
from WeiboScrapy.models import weibo, weibo_comments

headers = {
    'user-agent': 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36',
    # 'Cookie': '''换成你自己的 cookie'''
    'Cookie': settings.COOKIE
}


class WeiboCommentScrapy(Thread):

    def __init__(self, wid):
        global headers
        Thread.__init__(self)
        self.headers = headers
        self.result_headers = [
            '评论者主页',
            '评论者昵称',
            '评论者性别',
            '评论者所在地',
            '评论者微博数',
            '评论者关注数',
            '评论者粉丝数',
            '评论内容',
            '评论获赞数',
            '评论发布时间',
        ]
        if not os.path.exists('comment'):
            os.mkdir('comment')
        self.wid = wid
        self.start()

    def parse_time(self, publish_time):
        publish_time = publish_time.split('来自')[0]
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
        return publish_time

    def getPublisherInfo(self, url):
        res = requests.get(url=url, headers=self.headers, verify=False)
        html = etree.HTML(res.text.encode('utf-8'))
        head = html.xpath("//div[@class='ut']/span[1]")[0]
        head = head.xpath('string(.)')[:-3].strip()
        keyIndex = head.index("/")
        nickName = head[0:keyIndex - 2]
        sex = head[keyIndex - 1:keyIndex]
        location = head[keyIndex + 1:]

        footer = html.xpath("//div[@class='tip2']")[0]
        weiboNum = footer.xpath("./span[1]/text()")[0]
        weiboNum = weiboNum[3:-1]
        followingNum = footer.xpath("./a[1]/text()")[0]
        followingNum = followingNum[3:-1]
        followsNum = footer.xpath("./a[2]/text()")[0]
        followsNum = followsNum[3:-1]
        print(nickName, sex, location, weiboNum, followingNum, followsNum)
        return nickName, sex, location, weiboNum, followingNum, followsNum

    def get_one_comment_struct(self, comment):
        # xpath 中下标从 1 开始
        userURL = "https://weibo.cn/{}".format(comment.xpath(".//a[1]/@href")[0])

        content = comment.xpath(".//span[@class='ctt']/text()")
        # '回复' 或者只 @ 人
        if '回复' in content or len(content) == 0:
            test = comment.xpath(".//span[@class='ctt']")
            content = test[0].xpath('string(.)').strip()

            # 以表情包开头造成的 content == 0,文字没有被子标签包裹
            if len(content) == 0:
                content = comment.xpath('string(.)').strip()
                content = content[content.index(':') + 1:]
        else:
            content = content[0]

        praisedNum = comment.xpath(".//span[@class='cc'][1]/a/text()")[0]
        praisedNum = praisedNum[2:praisedNum.rindex(']')]

        publish_time = comment.xpath(".//span[@class='ct']/text()")[0]

        publish_time = self.parse_time(publish_time)
        nickName, sex, location, weiboNum, followingNum, followsNum = self.getPublisherInfo(url=userURL)

        return [userURL, nickName, sex, location, weiboNum, followingNum, followsNum, content, praisedNum, publish_time]

    def write_to_csv(self, result, isHeader=False):
        with open('comment/' + self.wid + '.csv', 'a', encoding='utf-8-sig', newline='') as f:
            writer = csv.writer(f)
            if isHeader == True:
                writer.writerows([self.result_headers])
            writer.writerows(result)
        print('已成功将{}条评论写入{}中'.format(len(result), 'comment/' + self.wid + '.csv'))

    def write_to_db(self, result, item):
        """将爬取的信息写入数据库"""
        try:
            for w in result:
                v = list(w)
                # 查看记录是否存在
                try:
                    wbcRecord = weibo_comments.objects.get(wid=v[0])
                    # 有记录,更新
                    wbcRecord.wid = item.wid
                    wbcRecord.c_home_page = v[0]
                    wbcRecord.c_nickname = v[1]
                    wbcRecord.c_sex = v[2]
                    wbcRecord.c_place = v[3]
                    wbcRecord.weibo_num = v[4]
                    wbcRecord.follow_num = v[5]
                    wbcRecord.fans_num = v[6]
                    wbcRecord.c_content = v[7]
                    wbcRecord.c_like_num = v[8]
                    wbcRecord.c_publish_time = v[9]
                    wbcRecord.save()
                except:
                    # 无记录，新增
                    obj_weiboc = weibo_comments()
                    obj_weiboc.wid = item.wid
                    obj_weiboc.c_home_page = v[0]
                    obj_weiboc.c_nickname = v[1]
                    obj_weiboc.c_sex = v[2]
                    obj_weiboc.c_place = v[3]
                    obj_weiboc.weibo_num = v[4]
                    obj_weiboc.follow_num = v[5]
                    obj_weiboc.fans_num = v[6]
                    obj_weiboc.c_content = v[7]
                    obj_weiboc.c_like_num = v[8]
                    obj_weiboc.c_publish_time = v[9][:15]
                    obj_weiboc.save()

            print('已成功将{}条评论写入数据库中'.format(len(result)))
        except Exception as e:
            print('Error: ', e)
            traceback.print_exc()

    def run(self):
        res = requests.get('https://weibo.cn/comment/{}'.format(self.wid), headers=self.headers, verify=False)
        commentNum = re.findall("评论\[.*?\]", res.text)[0]
        commentNum = int(commentNum[3:len(commentNum) - 1])
        print(commentNum)
        pageNum = ceil(commentNum / 10)
        print(pageNum)
        for page in range(pageNum):

            result = []

            res = requests.get('https://weibo.cn/comment/{}?page={}'.format(self.wid, page + 1), headers=self.headers,
                               verify=False)

            html = etree.HTML(res.text.encode('utf-8'))

            comments = html.xpath("/html/body/div[starts-with(@id,'C')]")

            print('第{}/{}页'.format(page + 1, pageNum))

            for i in range(len(comments)):
                result.append(self.get_one_comment_struct(comments[i]))

            if page == 0:
                self.write_to_csv(result, isHeader=True)
                self.write_to_db(result, self)
            else:
                self.write_to_csv(result, isHeader=False)
                self.write_to_db(result, self)

            sleep(randint(1, 5))


if __name__ == "__main__":
    # WeiboCommentScrapy(wid='IaYZIu0Ko')

    # WeiboCommentScrapy(wid='K2xidc8vq')
    # WeiboCommentScrapy(wid='M9mif82X1')
    WeiboCommentScrapy(wid='MaoJSo6vp')
