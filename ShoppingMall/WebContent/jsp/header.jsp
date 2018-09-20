<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>

	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>关于我们</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" type="text/css" />
		<script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>
		<!-- 引入自定义css文件 style.css -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css"/>
	</head>

	<body>
			<!--
            	描述：菜单栏
            -->
			<div class="container-fluid" >
				<div class="col-md-4" >
					<img src="${pageContext.request.contextPath}/img/logo5.png" style="height: 57px;width: 198px"/>
				</div>
				<div class="col-md-5">
					<img src="${pageContext.request.contextPath}/img/header.png" />
				</div>
				<div class="col-md-3" style="padding-top:20px">
					<ol class="list-inline">
					  <c:if test="${empty loginUser}">
						<li><a href="${pageContext.request.contextPath}/login"><div style="color: red">亲，请登录</div></a></li>
						<li><a href="${pageContext.request.contextPath}/register">免费注册</a></li>
						
					  </c:if>
					  <c:if test="${not empty loginUser}">
						<li>欢迎 ${loginUser.username }</li>						
						<li><a href="${pageContext.request.contextPath}/logout">退出</a></li>
						<li><a href="${pageContext.request.contextPath}/jsp/cart.jsp">购物车</a></li>
						<li><a href="${pageContext.request.contextPath}/findMyOrderWithPage?curPage=1">我的订单</a></li>
					  </c:if>
					</ol>
				</div>
			</div>
			<!--
            	描述：导航条
            -->
			<div class="container-fluid">
				<nav class="navbar navbar-inverse">
					<div class="container-fluid">
						<!-- Brand and toggle get grouped for better mobile display -->
						<div class="navbar-header">
							<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
								<span class="sr-only">Toggle navigation</span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
							</button>
							<a class="navbar-brand" href="${pageContext.request.contextPath}/">首页</a>
						</div>

						<!-- Collect the nav links, forms, and other content for toggling -->
						<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
							<ul class="nav navbar-nav" id="cates">
									<%-- <c:forEach items="${categories }" var="cate">
										<li><a href="#">${cate.cname }</a></li>
									</c:forEach>   --%>
							</ul>
							<form action="${pageContext.request.contextPath}/findProductByKey?curPage=1" method="post"  class="navbar-form navbar-right" role="search">
								<div class="form-group">
									<input type="text" class="form-control" placeholder="Search" id="keyword" name="key">
								</div>
								<button type="submit" class="btn btn-default">Submit</button>
							</form>

						</div>
						<!-- /.navbar-collapse -->
					</div>
					<!-- /.container-fluid -->
				</nav>
			</div>
	</body>
<script type="text/javascript">
	$(function() {
		//向服务端CategoryController的getAllCategorys发送ajax请求，服务端经过处理，将所有分类信息以JSON格式返回
		var url="http://localhost:8080/ShoppingMall/getAllCategorys";
		$.get(url,function(data){
			//console.log(data);
			//获取到服务端相应的数据
			$.each(data,function(i,obj){
				//console.log(obj);
				var li="<li><a href='${pageContext.request.contextPath}/selectBycidWithPage?curPage=1&cid="+obj.cid+"'>"+obj.cname+"</a></li>";
				$("#cates").append(li);
			});
		},"json");
		
	});
	
</script>
</html>