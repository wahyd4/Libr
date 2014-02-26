Libr
====

基于图书与阅读的社交应用。

Website:
====
[http://libr.herokuapp.com/](http://libr.herokuapp.com/)

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
        export export BAIDU_MAP_KEY= ***

#### 移动平台客户端

* [Android][3]
* [IOS][4]

#### 更新日志
 * 2013.2.17 添加个人信息编辑，设置昵称、电子邮箱、所在城市
 * 2013.2.17 添加API KEY 为后期在微信上借书、查询等做准备
 * 2013.2.17 为图书列表添加分页功能
 * 2013.2.18 添加基本API：图书信息、用户信息、图书列表
 * 2013.2.18 添加Auth key 功能，用户可以生成自己的key
 * 2013.2.19 用户可以删除自己的key
 * 2013.2.21 添加图书搜索API
 * 2013.2.26 添加归还已经借阅图书的API
 * 2013.2.27 修改借书逻辑，由之前的系统自动查找合适人选，变为借书者自行选择合适的拥有书者。修改bookinfo API增加返回所有当前可借的实例信息
 * 2013.2.28 添加私有书籍选项，用户在添加书籍是可以设置书籍为私有书籍，私有书籍他人不可见，仅用户自己可见
 * 2013.3.11 添加用户书籍API
 * 2013.4.15 添加历史记录
 * 2013.4.16 开始添加微信公共账号feature
 * 2013.4.17 通过添加go_serv 微信公共账号，输入1 即可获取书籍信息。please give a try.
 * 2014.1.16 升级到Rails4，并为Libr 2做准备
 * 2014.1.17 开始Libr2, 引入Devise,重新加入用户注册等功能，原有功能基本以不能再使用了。
 * 2014.1.19 添加基于token的客户端API 授权，验证。方便在移动断进行调用。
 * 2014.1.23 取消通过API调用时的CROS 验证。
 * 2014.1.26 添加百度地图API，根据经纬度返回目前所在地址
 * 2014.2.7  添加用于客户端上传常用地址的API
 * 2014.2.9  添加显示用户所有上传的地址API
 * 2014.2.10 添加删除用户位置的API
 * 2014.2.12 更新添加图书API,获取更多的图书信息
 * 2014.2.13 显示用户的图书
 * 2014.2.17 修复通过网页添加图书的BUG
 * 2014.2.18 添加通过ISBN查询书籍详细信息的API
 * 2014.2.20 修复通过API 扫描ISBN 创建图书的问题
 * 2014.2.23 添加API获取更新书籍, 禁止用户创建重复的书籍
 * 2014.2.24 为图书添加可排序的ID字段
 * 2014.2.26 添加为用户推荐附近流行书API

#### JSON API使用指南（下面的API已不再准确，请暂时不要使用）

        * GET /api/userinfo/:user_id 用户用户的相关信息
        * GET /api/bookinfo/:isbn  需要传入书籍的13位ISBN号，获取书籍的相关信息，拥有书籍的用户，和当前所有可借的用户信息
        * GET /api/books  以列表形式获取图书信息，每页10条信息，如要获取第二页信息地址则为 /api/books/?page=2,依次类推
        * GET /api/users/:user_id/books 以列表的形式获取某个用户的图书信息，使用方式和/api/books 类似
        * GET /api/book/search/:keyword 图书搜索，最多返回20条相关记录
        * POST /api/auth 客户端使用auth key,进行验证登录，验证成功后，可以使用该key,进行所有需要认证的操作。
          必填参数key,auth在用户中心，点击小锁图片即可进入KEY管理页面。(KEY不区分大小写)
        * POST '/api/books/add', 添加图书，必须填入图书的ISBN(isbn),和Auth key(key),Is public是否公开，
          可选参数为true,false(is_public)。括号为传递参数的实际名称
        * POST '/api/book/return' 归还已经借阅的图书，必需参数Auth key(key),Book binstance id(instance_id )
        * POST '/api/books/borrow' 借阅图书，必需参数Auth key(key),Book binstance id(instance_id )

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

[1]:https://github.com/hoverruan
[2]:https://github.com/xiaoboa
[3]:https://github.com/hoverruan/libr-android
[4]:https://github.com/xiaoboa/Libr-client


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/wahyd4/libr/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

