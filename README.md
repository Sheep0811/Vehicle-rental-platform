# 车辆租赁平台 后端管理系统
## 技术栈
后端使用Java+SpringBoot 使用Maven创建项目

前端使用Vue框架 UI框架使用ElementUI

数据库使用MySQL（8.0.29）

缓存使用redis

ORM框架使用MyBatis


## 介绍
面向商家的后台管理页面，可以对门店进行管理，对车辆进行管理以及对订单、合同等进行管理和维护。

## 部署
### 后端
开启MySQL，使用数据库文件创建数据库

在application.properties中修改数据库用户名与密码

开启redis，默认端口号6379

编译项目

### 前端
下载node.js

在client文件夹下

``` npm install ```

``` npm run dev ```

浏览器8080端口即可访问

默认用户名与密码：admin admin

