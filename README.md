## 项目名称：94购商城（自命名）
## 开发环境：Eclipse + Tomcat 9 + MySQL
## 项目架构：MySql + Spring + SpringMVC + Mybatis
## 项目描述：94购商城是一个基于B2C的商城网站，基于SSM框架；
## 主要功能模块：
### 后台管理模块：实现了商品的增删改查，及分页查询商品；
* 后台登录页面
![后台登录](https://github.com/MickeyLian/94shoppingmall/blob/master/module_pic/admin_login.png)
* 后台首页(页面很丑，别介意啊！哈哈)
![后台首页](https://github.com/MickeyLian/94shoppingmall/blob/master/module_pic/admin_index.png)
* 后台商品分类
![后台商品分类](https://github.com/MickeyLian/94shoppingmall/blob/master/module_pic/admin%20category.png)
* 后台商品管理
![后台商品管理](https://github.com/MickeyLian/94shoppingmall/blob/master/module_pic/admin_product.png)
* 后台下架商品管理
![后台下架商品管理](https://github.com/MickeyLian/94shoppingmall/blob/master/module_pic/admin_downProduct.png)
* 后台订单管理（分为未付款订单、已付款订单、已发货订单、已完成订单）
![后台订单管理](https://github.com/MickeyLian/94shoppingmall/blob/master/module_pic/admin%20order.png)
### 用户模块：用户可进行注册，登录，以及注册后需通过邮箱激活，方可登录， 登录后需要填写验证码才能登录成功（点击验证码可刷新）；
* 用户注册功能（注册后需要激活，激活才能登录）
![用户注册](https://github.com/MickeyLian/94shoppingmall/blob/master/module_pic/register.png)
![注册成功，请激活](https://github.com/MickeyLian/94shoppingmall/blob/master/module_pic/register_active.png)
* 注册后会发来邮件，激活
![激活](https://github.com/MickeyLian/94shoppingmall/blob/master/module_pic/email_active.png)
* 点击上面图片的链接后会跳转到登录页面，并提示激活成功
![激活成功](https://github.com/MickeyLian/94shoppingmall/blob/master/module_pic/active_success.png)
* 如果用户未激活就登录，会提示‘用户未激活’  
![未激活](https://github.com/MickeyLian/94shoppingmall/blob/master/module_pic/unactive.png)
* 登录模块（登录需要验证验证码 才能登录）
![登录](https://github.com/MickeyLian/94shoppingmall/blob/master/module_pic/login.png)
* 登录之后可查看自己的个人信息，并修改
  * 修改用户信息
  ![修改用户信息](https://github.com/MickeyLian/94shoppingmall/blob/master/module_pic/modify_userinfo.png)
  * 修改密码
  ![修改密码](https://github.com/MickeyLian/94shoppingmall/blob/master/module_pic/modify_password.png)
  * 更换头像
  ![更换头像](https://github.com/MickeyLian/94shoppingmall/blob/master/module_pic/change_headerPic.png)
### 首页展示，商品分类（页面加载完毕之后，向服务器发送ajax请求，将分类信息以JSON格式的数据返回，客户端渠道返回的所有分类）；还可进行关键字搜索商品，返回对应页面（数据库模糊查询关键字，分页显示对应的商品列表）
* 首页，包含最热商品和最新商品
![首页](https://github.com/MickeyLian/94shoppingmall/blob/master/module_pic/login_index.png)
![最热商品](https://github.com/MickeyLian/94shoppingmall/blob/master/module_pic/hot_products.png)
![最新商品](https://github.com/MickeyLian/94shoppingmall/blob/master/module_pic/new_products.png)
### 商品列表，分页显示
![商品列表](https://github.com/MickeyLian/94shoppingmall/blob/master/module_pic/product_list.png)
### 商品详情（商品详细信息，及用户评论——可对商品进行评价）
* 商品详细信息
![商品详情](https://github.com/MickeyLian/94shoppingmall/blob/master/module_pic/product_info.png)
* 商品评论
![商品评论](https://github.com/MickeyLian/94shoppingmall/blob/master/module_pic/product_comment.png)
### 购物车模块: 提供了购物车的增删改查操作，可加入订单；
* 购物车页面
![购物车页面](https://github.com/MickeyLian/94shoppingmall/blob/master/module_pic/cart.png)
### 订单模块：使用了SpringMVC的拦截器，若用户未登录则跳转至登录页面，成功则返回订单页面；可进行支付功能，调用了易宝支付的支付接口；
* 订单页面
![我的订单](https://github.com/MickeyLian/94shoppingmall/blob/master/module_pic/my_orders.png)
* 点击‘去付款’，到提交订单页面
![提交订单](https://github.com/MickeyLian/94shoppingmall/blob/master/module_pic/submit_order.png)
![提交订单](https://github.com/MickeyLian/94shoppingmall/blob/master/module_pic/submit_order_pay.png)
* 提交订单后，可进行支付(支付金额用了0.01元)
![支付](https://github.com/MickeyLian/94shoppingmall/blob/master/module_pic/order_pay.png)
### 拦截器配置
```java
<!-- 配置拦截器 -->
<mvc:interceptors>
      <mvc:interceptor>
            <mvc:mapping path="/addCartItemToCart"/>
            <mvc:mapping path="/findMyOrderWithPage"/>
            <mvc:mapping path="/userinfo"/>
            <mvc:mapping path="/modifyPasswordjsp"/>
            <mvc:mapping path="/modifyUserPhotojsp"/>
            <mvc:mapping path="/addComment"/>
            <mvc:mapping path="/addReply"/>
            <bean class="com.ljn.mall.intercepter.LoginIntercepter"></bean>
      </mvc:interceptor>
</mvc:interceptors>
```
从上面的路径可见：触发拦截器有‘加入购物车’、‘我的订单’、‘用户信息’、‘修改密码’、‘修改头像’、‘评论’、‘回复’等，有些路径是防止在路径上直接访问

若点击到以上相关路径，就会跳转到登录页面，并提示‘亲，您还没有登录，请先登录！’ 
![登录拦截](https://github.com/MickeyLian/94shoppingmall/blob/master/module_pic/login_interception.png)

 
