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

<style type="text/css">
	div {cursor:default;}
	.sctable td {cursor:pointer;}
	.pagination {
	  display: inline-block;
	  padding-left: 0;
	  margin: 20px 0;
	  border-radius: 4px; }

	.pagination > li {
	  display: inline;	}

	.pagination > li > a,
	.pagination > li > span {
	  position: relative;
	  float: left;
	  padding: 6px 12px;
	  margin-left: -1px;
	  line-height: 1.428571429;
	  text-decoration: none;
	  background-color: #ffffff;
	  border: 1px solid #dddddd; }
	
	.pagination > li:first-child > a,
	.pagination > li:first-child > span {
	  margin-left: 0;
	  border-bottom-left-radius: 4px;
	  border-top-left-radius: 4px;	}
	
	.pagination > li:last-child > a,
	.pagination > li:last-child > span {
	  border-top-right-radius: 4px;
	  border-bottom-right-radius: 4px;	}
	
	.pagination > li > a:hover,
	.pagination > li > span:hover,
	.pagination > li > a:focus,
	.pagination > li > span:focus {
	  background-color: #eeeeee; }
	
	.pagination.pagination-no-border > li > a,
	.pagination.pagination-no-border > li > span {
	  border: 0; }
	
	.pagination > li > a, .pagination > li > span, .pagination > li:first-child > a, .pagination > li:first-child > span, .pagination > li:last-child > a, .pagination > li:last-child > span {
	  border-radius: 50%;
	  margin: 0 2px;
	  color: #777777; }
	
	.pagination > li.active > a, .pagination > li.active > span, .pagination > li.active > a:hover, .pagination > li.active > span:hover, .pagination > li.active > a:focus, .pagination > li.active > span:focus {
	  background-color: #ffc107;
	  border: 0;
	  color: #FFFFFF;
	  padding: 7px 13px; }

</style>

</head>
<body class="sb-nav-fixed">
    <%@ include file="/adminTemplate/navi.jsp" %>
    <div id="layoutSidenav">
        <%@ include file="/adminTemplate/leftSidebar.jsp" %>
        <div id="layoutSidenav_content">
            <main>
			<div class="main">
			    <div class="container tim-container noticeList" style="max-width:1200px;">
			        <div class=" text-center" style=> <!-- navbar-collapse -->
			        	<div class="btn-group btn-group-lg scnav text-center" style="width:80%;margin:50px 0px;">
							<button type="button" class="btn" id="notice" style="width:30%;">공지사항</button>
							<button type="button" class="btn" id="faq" style="width:30%;">FAQ</button>
							<button type="button" class="btn btn-warning" id="chatting" style="width:30%;">실시간 채팅 상담</button>
						</div>
			        </div>
			        <div class="sctitle" style="margin-bottom:30px;">
				        <h2>실시간 채팅 상담 목록(관리자)</h2>
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
				        	<col width="60%">
				        	<col width="15%">
				        	<col width="15%">
				        	<tr><th class="text-center">번호</th>
				        		<th>마지막 채팅내용</th>
				        		<th>회원명</th>
				        		<th>등록일</th></tr>
				        </table>
					</div>
			        <div class="text-center">
				        <ul class="pagination ct-orange"> 
							<li><a href="javascript:goPage(${paging.startBlock-1})">&laquo;</a></li>
							<c:forEach var="cnt" begin="${paging.startBlock}" end="${paging.endBlock}">
								<li class="${paging.curPage==cnt?'active':'' }"><a href="javascript:goPage(${cnt})">${cnt}</a></li>
							</c:forEach>
							<li><a href="javascript:goPage(${paging.endBlock==paging.pageCount?paging.pageCount:paging.endBlock+1})">&raquo;</a></li>
						</ul>
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
		//var curPage="${paging.curPage}";
		//var pageSize="${paging.pageSize}";
		//console.log("curPage:"+curPage+" pageSize:"+pageSize);
		
		$.ajax({
	    	type:"post",
	    	url:"${path}/rtqna.do?method=ajaxlist&curPage=${paging.curPage}&pageSize=${paging.pageSize}",
   			dataType:"json",
	    	success:function(data){
	    		var list = data.list;
	    		//$("h2").text("data.list.lenght:"+list.length);
	    		var show = $(".sctable").html();
	    		$.each(list, function(idx,rtqna){
	    			show += '<tr class="item" onclick="javascript:go('+rtqna.mem_code+')"><td class="text-center">'+rtqna.cnt+'</td>';
	    			show += '<td>'+rtqna.rtqna_detail+'</td>';
	    			show += '<td>'+rtqna.mem_name+'</td>';
	    			show += '<td>'+rtqna.rtqna_state+'</td></tr>';
	    		});
	    		show += '<tr><td colspan="4"></td></tr>';
    			$(".sctable").html(show);
	    	},
	    	error:function(err){
	    		
	    	}
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
		
		
		$("#pageSize").change(function(){
	    	$("#curPage").val(1);	// 페이지크기를 바꾸면 초기 첫페이지가 나오도록 처리
			$("form").submit();
		});
	    
	    
	    
	})
	
	function go(mem_code){
		// alert("mem_code:"+mem_code);
		$(location).attr("href","${path}/rtqna.do?method=admdetail&mem_code="+mem_code);
	}
	function goPage(no){
		$("#curPage").val(no);
		$("form").submit();
	}
	
</script>
</html>

