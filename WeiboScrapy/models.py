from django.db import models
# timezone 用于处理时间相关事务。
from django.utils import timezone
from django.urls import reverse

class weibo(models.Model):
    # 微博表 id,wuid,wid,weibo_link,content,img_urls,location,publish_time,publish_tool,like_num,forward_num,comment_num,

    # 文章标题。
    # models.CharField 为字符串字段，用于保存较短的字符串，比如标题
    # CharField 有一个必填参数 max_length，它规定字符的最大长度
    # 博主id
    wuid = models.CharField(max_length=16)

    # 博主昵称
    wnickname = models.CharField(max_length=128)

    # 微博id
    wid = models.CharField(max_length=16)

    # 微博链接
    weibo_link = models.CharField(max_length=128)

    # 微博正文。
    # 保存大量文本使用 TextField
    content = models.TextField()

    # 微博里的所有图片链接
    location = models.TextField()

    # 发布时间
    publish_time = models.DateTimeField(blank=True, null=True)

    # 发布工具
    publish_tool = models.CharField(max_length=16)

    # 点赞量
    like_num = models.PositiveIntegerField(default=0)

    # 浏览量
    forward_num = models.PositiveIntegerField(default=0)

    # 评论量
    comment_num = models.PositiveIntegerField(default=0)

    # 爬取记录创建时间。
    # DateTimeField 为一个日期字段
    # 参数 default=timezone.now 指定其在创建数据时将默认写入当前的时间
    created = models.DateTimeField(default=timezone.now)

    # 爬取记录更新时间。
    # 参数 auto_now=True 指定每次数据更新时自动写入当前时间
    updated = models.DateTimeField(auto_now=True)

    # 内部类 class Meta 用于给 model 定义元数据
    # 元数据：不是一个字段的任何数据
    class Meta:
        # ordering 指定模型返回的数据的排列顺序
        # '-created' 表明数据应该以倒序排列
        ordering = ('-created',)

    # 函数 __str__ 定义当调用对象的 str() 方法时的返回值内容
    # 它最常见的就是在Django管理后台中做为对象的显示值。因此应该总是为 __str__ 返回一个友好易读的字符串
    def __str__(self):
        # 将文章标题返回
        return self.wuid