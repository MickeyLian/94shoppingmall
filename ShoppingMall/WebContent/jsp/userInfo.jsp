<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>个人信息</title>
		<link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icon/favicon.ico">
		<link rel="Bookmark" href="${pageContext.request.contextPath}/img/icon/favicon.ico">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" type="text/css" />
		<script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>
		<!-- 引入自定义css文件 style.css -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css"/>
		<style type="text/css">
			font {
				color: #3164af;
				font-size: 18px;
				font-weight: normal;
				padding: 0 10px;
			}
		</style>
	</head>

	<body>
		<div class="container-fluid">

			<%@ include file="/jsp/header.jsp"%>

				<div class="container"
			style="width:100%;background:url('${pageContext.request.contextPath}/img/regist_bg.jpg');">
			<div class="row">
	
				<div class="col-md-2"></div>
	
				<div class="col-md-8"
					style="background: #fff; padding: 40px 80px; margin: 30px; border: 7px solid #ccc;">
					<font>会员个人信息</font>
					<form class="form-horizontal" style="margin-top: 5px;"
						action="${pageContext.request.contextPath}/modifyUser"
						method="post">
						<input type="hidden" name="uid" value="${loginUser.uid }"/>
						<div class="form-group">
							<label for="username" class="col-sm-2 control-label">用户名</label>
							<div class="col-sm-6">
								<input type="text" name="username" class="form-control"
									id="username" value="${loginUser.username }">
							</div>
						</div>
						
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">Email</label>
							<div class="col-sm-6">
								<input type="email" name="email" class="form-control"
									id="inputEmail3" value="${loginUser.email }">
							</div>
						</div>
						<div class="form-group">
							<label for="usercaption" class="col-sm-2 control-label">姓名</label>
							<div class="col-sm-6">
								<input type="text" name="name" class="form-control"
									id="usercaption" value="${loginUser.name }">
							</div>
						</div>
						<div class="form-group opt">
							<label for="inlineRadio1" class="col-sm-2 control-label">性别</label>
							<div class="col-sm-6">
								<label class="radio-inline">
								 <input type="radio" name="sex" id="inlineRadio1" value="男"
								   <c:if test="${loginUser.sex=='男' }"> checked="checked"</c:if>  />
									男
								</label> <label class="radio-inline"> 
								<input type="radio" name="sex" id="inlineRadio2" value="女"  
									<c:if test="${loginUser.sex=='女' }"> checked="checked"</c:if>  />
									女
								</label>
							</div>
						</div>
						
						<div class="form-group">
							<label for="date" class="col-sm-2 control-label">出生日期</label>
							<div class="col-sm-6">
								<input type="text" class="form-control" name="birthday" 
								value='<fmt:formatDate value="${loginUser.birthday }" pattern="yyyy-MM-dd" />' />
								<%-- <input type="date" name="birthday" class="form-control" value="${loginUser.birthday }"> --%>
							</div>
						</div>
						<div class="form-group">
							<label for="date" class="col-sm-2 control-label">电话</label>
							<div class="col-sm-6">
								<input type="text" name="telephone" class="form-control" value="${loginUser.telephone }">
							</div>
						</div>

	
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<input type="submit" width="100" value="保存" name="submit"
									style="background: url('${pageContext.request.contextPath}/img/register.gif') no-repeat scroll 0 0 rgba(0, 0, 0, 0);
					    height:35px;width:100px;color:white;" />
							</div>
						</div>
					</form>
				</div>

				<div class="col-md-2"></div>

				</div>
			</div>
		</div>

		<%@ include file="/jsp/footer.jsp"%>

	</body>

</html>