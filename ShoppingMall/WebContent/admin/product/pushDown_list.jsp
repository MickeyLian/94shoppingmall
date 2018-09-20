<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<HTML>
	<HEAD>
		<meta http-equiv="Content-Language" content="zh-cn">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link href="${pageContext.request.contextPath}/css/Style1.css" rel="stylesheet" type="text/css" />
		<script language="javascript" src="${pageContext.request.contextPath}/js/public.js"></script>
		<script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js" type="text/javascript"></script>
	</HEAD>
	<body>
		<br>
		<form id="Form1" name="Form1" action="${pageContext.request.contextPath}/user/list.jsp" method="post">
			<table cellSpacing="1" cellPadding="0" width="100%" align="center" bgColor="#f5fafe" border="0">
				<TBODY>
					<tr>
						<td class="ta_01" align="center" bgColor="#afd1f3">
							<strong>商品列表</strong>
						</TD>
					</tr>
					
					<tr>
						<td class="ta_01" align="center" bgColor="#f5fafe">
							<table cellspacing="0" cellpadding="1" rules="all"
								bordercolor="gray" border="1" id="DataGrid1"
								style="BORDER-RIGHT: gray 1px solid; BORDER-TOP: gray 1px solid; BORDER-LEFT: gray 1px solid; WIDTH: 100%; WORD-BREAK: break-all; BORDER-BOTTOM: gray 1px solid; BORDER-COLLAPSE: collapse; BACKGROUND-COLOR: #f5fafe; WORD-WRAP: break-word">
								<tr
									style="FONT-WEIGHT: bold; FONT-SIZE: 12pt; HEIGHT: 25px; BACKGROUND-COLOR: #afd1f3">

									<td align="center" width="18%">
										序号
									</td>
									<td align="center" width="17%">
										商品图片
									</td>
									<td align="center" width="17%">
										商品名称
									</td>
									<td align="center" width="17%">
										商品价格
									</td>
									<td align="center" width="17%">
										是否热门
									</td>
									<td width="7%" align="center">
										上架
									</td>
								</tr>
								<c:forEach items="${page.list }" var="p" varStatus="status">
										<tr onmouseover="this.style.backgroundColor = 'white'"
											onmouseout="this.style.backgroundColor = '#F5FAFE';">
											<td style="CURSOR: hand; HEIGHT: 22px" align="center"
												width="18%">
												${status.count }
											</td>
											<td style="CURSOR: hand; HEIGHT: 22px" align="center"
												width="17%">
												<img width="40" height="45" src="${ pageContext.request.contextPath }/${p.pimage}">
											</td>
											<td style="CURSOR: hand; HEIGHT: 22px" align="center"
												width="17%">
												${p.pname }
											</td>
											<td style="CURSOR: hand; HEIGHT: 22px" align="center"
												width="17%">
												${p.shopPrice }
											</td>
											<td style="CURSOR: hand; HEIGHT: 22px" align="center"
												width="17%">
												${p.isHot }【是(1)/否(0)】
											</td>
											<td align="center" style="HEIGHT: 22px">
												<a href="${pageContext.request.contextPath}/upProduct?pid=${p.pid}&curPage=1" class="upProduct">
													<img src="${pageContext.request.contextPath}/img/admin/i_edit.gif" border="0" style="CURSOR: hand">
												</a>
											</td>
									
										</tr>
										</c:forEach>
							</table>
						</td>
					</tr>
					
				</TBODY>
			</table>
			<br>
	<%--分页显示的开始 --%>
    	<div style="text-align:center">
    		共${page.totalPageNum}页/第${page.currentPageNum}页 总记录数${page.totalRecords }条
    		
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
		</form>
	</body>
	<script type="text/javascript">
		$(function() {
			$(".upProduct").click(function() {
				if (confirm("确认上架该商品吗？")) {
					return true;
				}else{
					return false;
				}
			});
		});
	</script>
</HTML>

