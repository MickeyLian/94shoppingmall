<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<br>
	<%--分页显示的开始 --%>
    	<div style="text-align:center">
    		共${page.totalPageNum}页/第${page.currentPageNum}页 
    		
    		<!-- <a href="/store_v5/ProductServlet?method=findProductsByCidWithPage&cid=1&num=1">首页</a> -->
    		
    		<a href="${pageContext.request.contextPath}/${page.url}&curPage=1">首页</a>
    		<a href="${pageContext.request.contextPath}/${page.url}&curPage=${page.prePageNum}">上一页</a>
    		<%--显示的页码，使用forEach遍历显示的页面 --%>
    		<c:forEach begin="${page.startPage}" end="${page.endPage}" var="pagenum">
    			<a href="${pageContext.request.contextPath}/${page.url}&curPage=${pagenum}">${pagenum}</a>
    		</c:forEach>
    		
    		<a href="${pageContext.request.contextPath}/${page.url}&curPage=${page.nextPageNum}">下一页</a>
    		<a href="${pageContext.request.contextPath}/${page.url}&curPage=${page.totalPageNum}">末页</a>
    		<input type="text" id="pagenum" name="pagenum" size="1" class=""/>
    		<input type="button" value="go" onclick="jump()" class="btn btn-primary" />
    		<script type="text/javascript">
    			function jump(){
    				var totalpage = ${page.totalPageNum};
    				var pagenum = document.getElementById("pagenum").value;
    				//判断输入的是一个数字
    				var reg =/^[1-9][0-9]{0,1}$/;
    				if(!reg.test(pagenum)){
    					//不是一个有效数字
    					alert("请输入符合规定的数字");
    					return ;
    				}
    				//判断输入的数字不能大于总页数
    				if(parseInt(pagenum)>parseInt(totalpage)){
    					//超过了总页数
    					alert("不能大于总页数");
    					return;
    				}
    				//转向分页显示的Servlet
    				window.location.href="${pageContext.request.contextPath}/${page.url}&curPage="+pagenum;
    			}
    		</script>
    		<script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>
    	</div>
    <br>
    	<%--分页显示的结束--%>
