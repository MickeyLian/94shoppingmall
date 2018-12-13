<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>会员登录</title>
		<link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icon/favicon.ico">
		<link rel="Bookmark" href="${pageContext.request.contextPath}/img/icon/favicon.ico">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/bootstrap.min.css"
	type="text/css" />
<script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js"
	type="text/javascript"></script>
	<script src="${pageContext.request.contextPath}/js/jquery.cookie.js"
	type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"
	type="text/javascript"></script>
<!-- 引入自定义css文件 style.css -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" type="text/css" />
<script type="text/javascript">
	function change() {
		location.reload();
	}
</script>
<style>

body {
	margin-top: 20px;
	margin: 0 auto;
}

.carousel-inner .item img {
	width: 100%;
	height: 300px;
}

.container .row div {
	/* position:relative;
	 float:left; */
	
}

font {
	color: #666;
	font-size: 22px;
	font-weight: normal;
	padding-right: 17px;
}
</style>
</head>
<body>


	<!--
            	描述：菜单栏
            -->
	<div class="container-fluid">
		<div class="col-md-4">
			<img src="${pageContext.request.contextPath}/img/logo5.png"
				style="height: 57px; width: 198px" />
		</div>
		<div class="col-md-5">
			<img src="${pageContext.request.contextPath}/img/header.png" />
		</div>
		<div class="col-md-3" style="padding-top: 20px">
			<ol class="list-inline">
				<li><a href="${pageContext.request.contextPath}/login"><div style="color: red">亲，请登录</div></a></li>
				<li><a href="${pageContext.request.contextPath}/register">免费注册</a></li>
				<li><a href="${pageContext.request.contextPath}/">返回首页</a></li>
				<%-- <li><a href="${pageContext.request.contextPath}/jsp/cart.jsp">购物车</a></li>
						<li><a href="${pageContext.request.contextPath}/jsp/order_list.jsp">我的订单</a></li> --%>
			</ol>
		</div>
	</div>



	<div class="container"
		style="width:100%;height:500px;background:#FF2C4C url('${pageContext.request.contextPath}/img/loginbg.jpg') no-repeat;">
		<div class="row">
			<div class="col-md-7">
				<!--<img src="image/login.jpg" width="500" height="330" alt="会员登录" title="会员登录">-->
			</div>

			<div class="col-md-5">
				<div
					style="width: 440px; border: 1px solid #E7E7E7; padding: 20px 0 20px 30px; border-radius: 5px; margin-top: 60px; background: #fff;">
					<font>会员登录</font>USER LOGIN
					<br/>
					<div style="color: red">${msg }</div>
					<form class="form-horizontal"
						action="${pageContext.request.contextPath}/userLogin"
						method="post">

						<div class="form-group">
							<label for="username" class="col-sm-2 control-label">用户名</label>
							<div class="col-sm-6">
								<input type="text" name="username" class="form-control"
									id="username" placeholder="请输入用户名">
							</div>
						</div>
						<div class="form-group">
							<label for="password" class="col-sm-2 control-label">密码</label>
							<div class="col-sm-6">
								<input type="password" name="password" class="form-control"
									id="password" placeholder="请输入密码">
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">验证码</label>
							<div class="col-sm-3">
								<input type="text" class="form-control" id="inputPassword3" name="code" style="width: 109px"
									placeholder="请输入验证码">
							</div>
							<div class="col-sm-3">
								<a href="javaScript:change()"><img src="${pageContext.request.contextPath}/checkImg" alt="验证码" id="checkImg" /></a>
							</div>

						</div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<div class="checkbox">
									<label for="autoLogin"> <input type="checkbox" name="autoLogin" id="autoLogin"> 自动登录</label>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<label for="rememberMe"> <input type="checkbox" name="rememberMe" id="rememberMe"> 记住用户名 </label>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<input type="submit" width="100" value="登录" name="submit"  
									style="background: url('${pageContext.request.contextPath}/img/login.gif') no-repeat scroll 0 0 rgba(0, 0, 0, 0);
    height:35px;width:100px;color:white;">
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<div class="container-fluid">

		<div style="text-align: center; margin-top: 5px;">
			<ul class="list-inline">
				<li><a href="${pageContext.request.contextPath}/jsp/info.jsp">关于我们</a></li>
				<li><a>联系我们</a></li>
				<li><a>招贤纳士</a></li>
				<li><a>法律声明</a></li>
				<li><a>友情链接</a></li>
				<li><a>支付方式</a></li>
				<li><a>配送方式</a></li>
				<li><a>服务声明</a></li>
				<li><a>广告声明</a></li>
			</ul>
		</div>
		<div style="text-align: center; margin-top: 5px; margin-bottom: 20px;">
			Copyright &copy; 2018-2028 94购商城 版权所有</div>
	</div>

</body>
<script type="text/javascript">
	

</script>
</html>