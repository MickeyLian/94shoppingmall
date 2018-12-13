<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台管理系统</title>
<style>
body {
	SCROLLBAR-ARROW-COLOR: #ffffff;
	SCROLLBAR-BASE-COLOR: #dee3f7;
}
</style>
</head>

<frameset rows="103,*,43" frameborder=0 border="0" framespacing="0">
	<!-- top.jsp -->
	<frame src="${pageContext.request.contextPath}/admin/top.jsp"
		name="topFrame" scrolling="NO" noresize>
	<!-- 中间的 -->
	<frameset cols="159,*" frameborder="0" border="0" framespacing="0">
		<!-- 左边的，和右边的 -->
		<frame src="${pageContext.request.contextPath}/admin/left.jsp"
			name="leftFrame" noresize scrolling="YES">
		<frame src="${pageContext.request.contextPath}/admin/welcome.jsp"
			name="mainFrame">
	</frameset>
	<!--bottom.jsp  -->
	<frame src="${pageContext.request.contextPath}/admin/bottom.jsp"
		name="bottomFrame" scrolling="NO" noresize>
</frameset>
</html>
