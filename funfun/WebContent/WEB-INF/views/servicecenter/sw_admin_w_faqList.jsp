<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>FunFun - 템플릿</title>
<link href="${path }/adminTemplate/css/styles.css" rel="stylesheet" />
<link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/js/all.min.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
    <%@ include file="/adminTemplate/navi.jsp" %>
    <div id="layoutSidenav">
        <%@ include file="/adminTemplate/leftSidebar.jsp" %>
        <div id="layoutSidenav_content">
            <main>
			<div class="main">
			    <div class="container tim-container faqList" style="max-width:1200px; padding-top:100px">
			        <div class="navbar-collapse text-center">
			        	<div class="btn-group btn-group-lg scnav" style="width:80%;">
							<button type="button" class="btn " id="notice" style="width:30%;">공지사항</button>
							<button type="button" class="btn btn-warning" id="faq" style="width:30%;">FAQ</button>
							<button type="button" class="btn " id="chatting" style="width:30%;">실시간 채팅 상담</button>
						</div>
			        </div>
			        <div class="sctitle">
				        <h2>FAQ 목록(관리자)</h2>
				    </div>
		        	<form:form class="form" commandName="paging" method="post">
			        <form:hidden path="curPage" />
			        <div class="row">
			        	<div class="text-left col-sm-3 ">총건수 : ${paging.count}건</div> 
			        	<div class="text-right col-sm-9">페이지수 : 
				        	<form:select path="pageSize">
				        		<form:option value="5">5건</form:option>
				        		<form:option value="10">10건</form:option>
				        		<form:option value="20">20건</form:option>
				        	</form:select></div>
					</div>
					</form:form>
					<div>
				        <table class="table table-hover sctable">
				        	<col width="10%">
				        	<col width="70%">
				        	<col width="20%">
				        	<tr><th class="text-center">번호</th>
				        		<th>제목</th>
				        		<th>작성자</th></tr>
				        	<c:forEach var="faq" items="${list}">
					        	<tr class="item" onclick="javascript:go(${faq.faq_code})">
					        		<td class="text-center">${faq.cnt}</td>
					        		<td>${faq.faq_title}</td>
					        		<td>${faq.admin_name}</td>
				        	</c:forEach>
				        	<tr><td colspan="3"></td></tr>
				        </table>
					</div>
			        <div class="text-center">
				        <ul class="pagination"> 
							<li><a href="javascript:goPage(${paging.startBlock-1})">&laquo;</a></li>
							<c:forEach var="cnt" begin="${paging.startBlock}" end="${paging.endBlock}">
								<li class="${paging.curPage==cnt?'active':'' }"><a href="javascript:goPage(${cnt})">${cnt}</a></li>
							</c:forEach>
							<li><a href="javascript:goPage(${paging.endBlock==paging.pageCount?paging.pageCount:paging.endBlock+1})">&raquo;</a></li>
						</ul>
			        </div>
			        <div class="text-right">
						<button class="btn btn-warning insertFaq">등록</button>
					</div>
			    </div>
			</div>
			<!-- end main -->
			</main>
            <%@ include file="/adminTemplate/footer.jsp" %>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="${path }/adminTemplate/js/scripts.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
    <script src="${path }/adminTemplate/assets/demo/chart-area-demo.js"></script>
    <script src="${path }/adminTemplate/assets/demo/chart-bar-demo.js"></script>
    <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
    <script src="${path }/adminTemplate/assets/demo/datatables-demo.js"></script>
</body>
<script>
	$(document).ready(function(){
		$("#pageSize").change(function(){
	    	$("#curPage").val(1);	// 페이지크기를 바꾸면 초기 첫페이지가 나오도록 처리
			$("form").submit();
		});
	    
	    $("#notice").click(function(){
	    	$(location).attr("href","${path}/notice.do?method=admList");
	    });
	    $("#faq").click(function(){
	    	$(location).attr("href","${path}/faq.do?method=admList");
	    });
	    $("#chatting").click(function(){
	    	$(location).attr("href","${path}/rtqna.do?method=admList");
	    });
	    $(".insertFaq").click(function(){
		 	$(location).attr("href","${path}/faq.do?method=insForm");	
	    });
	})
	
	function go(faq_code){
		$(location).attr("href","${path}/faq.do?method=detail&faq_code="+faq_code);
	}
	function goPage(no){
		$("#curPage").val(no);
		$("form").submit();
	}
	
</script>
</html>

