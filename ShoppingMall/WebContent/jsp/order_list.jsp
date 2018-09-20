<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!doctype html>
<html>

	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>会员登录</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" type="text/css" />
		<script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>
		<!-- 引入自定义css文件 style.css -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css"/>

		<style>
			body {
				margin-top: 20px;
				margin: 0 auto;
			}
			
			.carousel-inner .item img {
				width: 100%;
				height: 300px;
			}
		</style>
		<script type="text/javascript">
			$(function() {
				$(".cancelOrder").click(function() {
					if (confirm("亲，确认取消订单吗？")) {
						return true;
					}else{
						return false;
					}
				});
			});
		</script>
	</head>
	<body>
			<%@ include file="/jsp/header.jsp" %>

		<div class="container">
			<div class="row">

				<div style="margin:0 auto; margin-top:10px;width:950px;">
					<strong>我的订单</strong>
					<table class="table table-bordered">
					<c:forEach items="${page.list}" var="o">	
						<tbody>
							<tr class="success">
								<th colspan="5">
									订单编号:${o.oid}
									总金额:¥${o.total}元
									<c:if test="${o.state==1}">
										<a href="${pageContext.request.contextPath}/findOrderByOid?oid=${o.oid}">去付款</a>
									</c:if>	 
									<c:if test="${o.state==2}">未发货</c:if>
									<c:if test="${o.state==3}">
										<a href="">签收</a>
									</c:if>	 
									<c:if test="${o.state==4}">结束</c:if>
									<a href="${pageContext.request.contextPath}/deleteOrderByoid?oid=${o.oid}&curPage=1" class="cancelOrder">取消订单</a>	 
								</th>
							</tr>
							<tr class="warning">
								<th>图片</th>
								<th>商品</th>
								<th>价格</th>
								<th>数量</th>
								<th>小计</th>
							</tr>
						<c:forEach items="${o.list}" var="item">	
							<tr class="active">
								<td width="60" width="40%">
									<input type="hidden" name="id" value="22">
									<img src="${pageContext.request.contextPath}/${item.product.pimage}" width="70" height="60">
								</td>
								<td width="30%">
									<a target="_blank">${item.product.pname}</a>
								</td>
								<td width="20%">
									￥${item.product.shopPrice}
								</td>
								<td width="10%">
									${item.quantity}
								</td>
								<td width="15%">
									<span class="subtotal">￥${item.total}</span>
								</td>
							</tr>
						  </c:forEach>
						</tbody>
					  </c:forEach>	
					</table>
					<br>
	<%--分页显示的开始 --%>
    	<div style="text-align:center">
    		共${page.totalPageNum}页/第${page.currentPageNum}页
    		
    		<!-- <a href="/store_v5/ProductServlet?method=findProductsByCidWithPage&cid=1&num=1">首页</a> -->
    		
    		<a href="${pageContext.request.contextPath}/${page.url}?curPage=1">首页</a>
    		<a href="${pageContext.request.contextPath}/${page.url}?curPage=${page.prePageNum}">上一页</a>
    		<%--显示的页码，使用forEach遍历显示的页面 --%>
    		<c:forEach begin="${page.startPage}" end="${page.endPage}" var="pagenum">
    			<a href="${pageContext.request.contextPath}/${page.url}?curPage=${pagenum}">${pagenum}</a>
    		</c:forEach>
    		
    		<a href="${pageContext.request.contextPath}/${page.url}?curPage=${page.nextPageNum}">下一页</a>
    		<a href="${pageContext.request.contextPath}/${page.url}?curPage=${page.totalPageNum}">末页</a>
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
    				window.location.href="${pageContext.request.contextPath}/${page.url}?curPage="+pagenum;
    			}
    		</script>
    		<script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>
    	</div>
    <br>
				</div>
			</div>
			
		</div>

		<%@ include file="/jsp/footer.jsp" %>
	</body>

</html>