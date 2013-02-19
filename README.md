Libr
====

tw-libr

Build Status
====
[![Build Status](https://travis-ci.org/wahyd4/Libr.png?branch=master)](https://travis-ci.org/wahyd4/Libr)
[![Code Climate](https://codeclimate.com/github/wahyd4/Libr.png)](https://codeclimate.com/github/wahyd4/Libr)
#### Export System variable

        export CLIENT_ID=***
        export CLIENT_SECRET=***
        export REDIRECT_URI=***


        export QQ_CLIENT_ID=***
        export QQ_CLIENT_SECRET=***
        export QQ_REDIRECT_URI=***

#### 更新日志
 * 2013.2.17 添加个人信息编辑，设置昵称、电子邮箱、所在城市
 * 2013.2.17 添加API KEY 为后期在微信上借书、查询等做准备
 * 2013.2.17 为图书列表添加分页功能
 * 2013.2.18 添加基本API：图书信息、用户信息、图书列表
 * 2013.2.18 添加Auth key 功能，用户可以生成自己的key
 * 2013.2.19 用户可以删除自己的key

#### JSON API使用指南

        * GET /api/userinfo/:user_id 用户用户的相关信息
        * GET /api/bookinfo/:isbn  需要传入书籍的13位ISBN号，获取书籍的相关信息，拥有书籍的用户，和当前可借的用户信息
        * GET /api/books  以列表形式获取图书信息，每页10条信息，如要获取第二页信息地址则为 /api/books/?page=2,依次类推
        * POST /api/auth 客户端使用auth key,进行验证登录，验证成功后，可以使用该key,进行所有需要认证的操作。必填参数key,auth在用户中心，点击小锁图片即可进入KEY管理页面。(KEY不区分大小写)


#### Road map:
* 移动客户端的支持，用户可以在手机上查找图书，通过扫描二维码添加图书。
* 用户长时间借书未归还，自动提醒（邮件、微信？）
* 微信查书？
* 用户私有书架，用户可以选择不对外公开展示自己的书籍，只供自己查看。
* 为用户添加 组织、地址标签，方便借书与分享书时，选择最优方案。
* 用户可以创建书单，书单为一系列书的集合。如：java程序员必读的10本书。
* 用户可以选择开始读某一书单。并可以看到自己读这一书单的进度，以及需要向那些人借书，以及看到有多少其他人已经读了这个书单等等统计。用户读完书单，可以发布感想。如果扯远来：有书单，也就可以有 各种进度、统计、勋章、虚拟奖励等等。
* 各种深入的数据统计。如：某用户平均借书周期、哪段时间看书较多等等......
* ....... 等你们来补充


#### License
        The MIT License (MIT)
