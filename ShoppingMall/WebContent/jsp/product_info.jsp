<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>商品详情信息</title>
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icon/favicon.ico">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" type="text/css" />
	<script src="${pageContext.request.contextPath}/js/jquery-1.12.0.min.js" type="text/javascript"></script>
	<script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="${pageContext.request.contextPath}/layui/layui.js" type="text/javascript"></script>
	<link href="${pageContext.request.contextPath}/layui/css/layui.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/comment.css" type="text/css"/>

	<style>
		body {
			margin-top: 20px;
			margin: 0 auto;
		}
		
		.carousel-inner .item img {
			width: 100%;
			height: 300px;
		}
		.hide{
			display: none
		}
	</style>
</head>

<body>
	<%@ include file="/jsp/header.jsp"%>
	<div class="container">
		<div class="row">
			<div style="border: 1px solid #e4e4e4;width:930px;margin-bottom:10px;margin:0 auto;padding:10px;margin-bottom:10px;">
				<a href="${pageContext.request.contextPath}/">首页&nbsp;&nbsp;&gt;</a>
				<a>${product.pname }</a>
			</div>
			<div style="margin:0 auto;width:950px;">
				<form id="myForm" action="${pageContext.request.contextPath}/addCartItemToCart" method="post">
				<div class="col-md-6">
					<img style="opacity: 1;width:400px;height:350px;" title="" class="medium" src="${pageContext.request.contextPath}/${product.pimage}">
				</div>
				<div class="col-md-6">
					<div><strong>${product.pname }</strong></div>
					<div style="border-bottom: 1px dotted #dddddd;width:350px;margin:10px 0 10px 0;">
						<div>编号：${product.pid }</div>
					</div>
					<div style="margin:10px 0 10px 0;">商城价: <strong style="color:#ef0101;">￥：${product.shopPrice }元/份</strong> 市场价： <del>￥：${product.marketPrice }元/份</del>
					</div>
					<div style="margin:10px 0 10px 0;">促销: <a target="_blank" title="限时抢购 (2014-07-30 ~ 2015-01-01)" style="background-color: #f07373;">限时抢购</a> </div>
					<div style="padding:20px;border:1px solid #e7dbb1;width:330px;margin:20px 0 10px 0;;background-color: #fffee6;">
						<div style="margin:10px 0 20px 0;">${product.pname }</div>
						<div style="border-bottom: 1px solid #faeac7;margin-top:20px;padding-left: 10px;">购买数量:
						
							<input id="quantity" name="quantity" value="1" maxlength="4" size="10" type="text"> </div>
							<input type="hidden" name="pid" value="${product.pid }"/>
							
						<div style="margin:20px 0 10px 0;;text-align: center;">
							<%--加入到购物车 --%>
							<!-- 取消链接的默认行为 -->
							<a href="javascript:void(0)">
								<input id="btnId" type="submit" style="background: url('${pageContext.request.contextPath}/img/product.gif') no-repeat scroll 0 -600px rgba(0, 0, 0, 0);height:36px;width:130px;" value="加入购物车">
							</a> &nbsp;<a href="javascript:;">收藏商品</a>
						</div>
					</div>
				</div>
				</form>
			</div>
			<div class="clear"></div>
			
			<div style="width:950px;margin:40px auto;">
				
				<div style="background-color:#d3d3d3;width:900px;">
					<table class="table table-bordered">
						<tbody>
							<tr class="active">
								<th><strong>商品介绍</strong></th>
							</tr>
							<tr class="warning">
								<td>${product.pdesc }</td>
							</tr>
						</tbody>
					</table>
				</div>


				<div style="background-color:#d3d3d3;width:900px;">
					<table class="table table-bordered">
						<tbody>
							<tr class="active">
								<th><strong>商品评论</strong></th>
							</tr>
							<tr class="warning">
								<td>
								<div class="container" style="width: 883px">
									<div class="commentbox">
									   <form action="${pageContext.request.contextPath}/addComment">
										<textarea id="content" name="content" class="mytextarea" style="width: 760px;height: 45px;resize: none;" placeholder="发表商品评论..." onkeyup="keyUP(this)"></textarea>
										<input type="hidden" name="commentor" value="${loginUser.username}">
										<input type="hidden" name="pid" value="${product.pid }">
										<button id="comment" type="submit" class="plBtn" style="border: 0">评论</button>
									   </form>
									</div>
									<!--回复区域 begin-->
									<div>
										<!-- 先遍历留言信息（一条留言信息，下面的全是回复信息） -->
										<c:forEach items="${comments }" var="comment">
											<!-- 如果留言信息是在本chan下的才显示 -->
											<c:if test="${comment.pid eq product.pid }">
											     <div class="comment-show-con clearfix">
											         <div class="comment-show-con-img pull-left"><img src="${pageContext.request.contextPath}/${comment.commentHeader }" style="width: 45px;height: 45px;border-radius: 50%;" alt="头像"></div>
											         <div class="comment-show-con-list pull-left clearfix">
											             <div class="pl-text clearfix">
											                 <a href="#" class="comment-size-name">${comment.commentor } </a>: 	
											                 <span class="my-pl-con">&nbsp;${comment.content }</span>
											             </div>
											             <div class="date-dz">      <!--  -->
											                 <span class="date-dz-left pull-left comment-time"><fmt:formatDate value="${comment.date }" pattern="yyyy-MM-dd HH:mm:ss"/></span>
											                 <p class="date-dz-right pull-right comment-pl-block">
											                     <!-- <a href="javascript:;" class="removeBlock">删除</a> -->
											                     <a href="javascript:;" class="date-dz-pl pl-hf hf-con-block pull-left" onclick="btnReplyClick(this)">回复</a>
											                 </p>
											             </div>
											             <!-- 回复表单默认隐藏 -->
											             <div class="replybox hide" style="margin-top: 40px;">
														   <form action="${pageContext.request.contextPath}/addReply">
															<textarea id="content" name="content" class="mytextarea" style="width: 640px;height: 45px;resize: none;" placeholder="发表商品评论..." onkeyup="keyUP(this)"></textarea>
															<input type="hidden" name="replyer" value="${loginUser.username}">
															<input type="hidden" name="pid" value="${product.pid }">
															<input type="hidden" name="replyfor" value="${comment.commentor }">
															<input type="hidden" name="commentId" value="${comment.id }">
															<input type="hidden" name="replyId" value="${reply.id }">
															<button id="reply" type="submit" class="plBtn" style="border: 0">回复</button>
														   </form>
														</div>
											            <div class="hf-list-con"></div>
											         </div>
											         <!-- 以下是回复信息 -->
											         <c:forEach items="${replies}" var="reply">
											         	<!-- 每次遍历出来的留言下存在回复信息才展示（本条回复信息是本条留言下的就显示在当前留言下） -->
											         	<c:if test="${reply.pid eq product.pid && reply.commentId eq comment.id }">
												         <div style="width: 773px;margin-left: 70px;">
												         	<div class="comment-show-con-img pull-left"><img src="${pageContext.request.contextPath}/${reply.replyHeader }" style="width: 45px;height: 45px;border-radius: 50%;" alt="头像"></div>
													         <div class="comment-show-con-list pull-left clearfix">
													             <div class="pl-text clearfix">
													                 <a href="#" class="comment-size-name">${reply.replyer } </a>: 	
													                 <span class="my-pl-con">&nbsp;${reply.content }</span>
													             </div>
													             <div class="date-dz">      <!--  -->
													                 <span class="date-dz-left pull-left comment-time"><fmt:formatDate value="${reply.date }" pattern="yyyy-MM-dd HH:mm:ss"/></span>
													                 <p class="date-dz-right pull-right comment-pl-block">
													                     <!-- <a href="javascript:;" class="removeBlock">删除</a> -->
													                     <a href="javascript:;" class="date-dz-pl pl-hf hf-con-block pull-left" onclick="btnReplyClick(this)">回复</a>
													                 </p>
													             </div>
													             <!-- 回复表单默认隐藏 -->
													             <div class="replybox hide" style="margin-top: 40px;">
																   <form action="${pageContext.request.contextPath}/addReply">
																	<textarea id="content" name="content" class="mytextarea" style="width: 572px;height: 45px;resize: none;" placeholder="发表商品评论..." onkeyup="keyUP(this)"></textarea>
																	<input type="hidden" name="replyer" value="${loginUser.username}">
																	<input type="hidden" name="pid" value="${product.pid }">
																	<input type="hidden" name="replyfor" value="${comment.commentor }">
																	<input type="hidden" name="commentId" value="${comment.id }">
																	<input type="hidden" name="replyId" value="${reply.id }">
																	<button id="reply" type="submit" class="plBtn" style="border: 0">回复</button>
																   </form>
																</div>
													            <div class="hf-list-con"></div>
													         </div>
													     </div>
											         	</c:if>
											         </c:forEach> 
											     </div>
											</c:if>
										</c:forEach>
									</div>
							        
							    </div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				
			</div>
		</div>
	</div>
	<%@ include file="/jsp/footer.jsp"%>

<!--textarea限制字数-->
<script type="text/javascript">
    function keyUP(t){
        var len = $(t).val().length;
        if(len > 100){
            $(t).val($(t).val().substring(0,101));
        }
    }
</script>
<script type="text/javascript">
    layui.use('element', function () {
        var element = layui.element;
    });
</script>
<script type="text/javascript">
	function btnReplyClick(elem) {
	    var $ = layui.jquery;
	    //console.log(!$(this))
	    if($(this)){
	    }else if(!$(this)){
	    	//没有用处
	    	$(elem).parent('p').parent('.date-dz').siblings('.replybox').toggleClass('layui-show');
	    }
	    //对添加和移除被选元素的一个或多个类进行切换
	    $(elem).parent('p').parent('.date-dz').siblings('.replybox').toggleClass('hide');
	    if ($(elem).text() == '回复') {
	        $(elem).text('收起')
	    } else {
	        $(elem).text('回复')
	    }
	}
</script>
</body>

</html>
