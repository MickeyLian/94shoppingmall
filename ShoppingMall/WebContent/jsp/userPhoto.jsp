<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>会员头像</title>
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

	<script type="text/javascript">
		var img = document.getElementById('img'); 
		
		function bigger(){  img.style.width = '1920px';  img.style.height = '1080px'; } 

		function smaller(){  img.style.width = '192px';  img.style.height = '108px'; }
	</script>
	<body>
		<div class="container-fluid">

			<%@ include file="/jsp/header.jsp"%>

				<div class="container"
			style="width:100%;background:url('${pageContext.request.contextPath}/img/regist_bg.jpg');">
			<div class="row">
	
				<div class="col-md-2"></div>
	
				<div class="col-md-8"
					style="background: #fff; padding: 40px 80px; margin: 30px; border: 7px solid #ccc;">
					<font>更换会员头像</font>
					<br><br>
					<form class="form-horizontal" style="margin-top: 5px;"
						action="${pageContext.request.contextPath}/modifyUserPhoto"
						method="post" enctype="multipart/form-data">
						<input type="hidden" name="uid" value="${loginUser.uid }"/>
						<div class="form-group">
							<label for="date" class="col-sm-2 control-label">用户头像</label>
							<div class="col-sm-6">
							<img alt="" id="img" onmouseover="bigger()" onmouseout="smaller()" 
							   src="${pageContext.request.contextPath}/${loginUser.photo }" 
							   style="height: 108px;width: 192px;" >
							<br><br>
							<input type="file" name="photo" class="form-control" />
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