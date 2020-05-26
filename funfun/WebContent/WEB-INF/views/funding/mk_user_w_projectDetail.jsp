<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/template/header.jsp" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/mk_user_w_projectList.css">
<style type="text/css">
input[type=file]{display:inline;}
.project-inquiry{width:100%; padding: 15px;}
.inquiry-title{width: 100%; height: 60px; font-family: 'Nanum Gothic', sans-serif; font-weight: 800; font-size: 16pt; }
.title_td {display: inline-block; width: 300px; padding-left: 25%; padding-right: 25%; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; padding-left: 20px;}
th{text-align:center;}

</style>
<script>
	$(document).ready(function(){
		var mem_code = "${user.mem_code}";
		// 관심프로젝트
		$("#favBtn").click(function(){
	  		if(mem_code == ""){
	  			if(confirm("로그인이 필요합니다.")){
	  				$(location).attr("href","${path}/login.do");
	  			}
	  		} else{
	  			$.ajax({
	  				type:"post",
	  				url:"${path}/funding.do?method=ckfavor",
	  				data:$("#favor").serialize(),
	  				dataType:"json",
	  				success:function(data){
	  					if(data.ckfavor){
	  						alert("관심프로젝트에 추가되었습니다");
	  			  			$("#favor").attr("action","${path}/funding.do?method=favor");
	  			  			$("#favor").submit();
	  					} else{
	  						alert("이미 등록된 프로젝트입니다");
	  					}
	  				},
					error:function(err){
						console.log("ajax처리 에러");
						console.log(err);
					}
	  			});
	  		}
		});
		// 펀딩하기
		$("#gofun").click(function(){
			if(mem_code == ""){
	  			if(confirm("로그인이 필요합니다.")){
	  				$(location).attr("href","${path}/login.do");
	  			}
	  		} else{
	  			var no = $("[name=pro_code]").val();
				$(location).attr("href","${path}/funding.do?method=option&pro_code="+no);
	  		}
		});
		// 신고하기
		$("#reportBtn").click(function(){
			if(mem_code == ""){
	  			if(confirm("로그인이 필요합니다.")){
	  				$(location).attr("href","${path}/login.do");
	  			}
	  		}
		});
		$("#report").click(function(){
			alert("신고가 접수되었습니다");
			$(location).attr("href","${path}/funding.do?method=report");
			$("#report-content").submit(); 
		});

		$(".custom-file-input").on("change", function(){
			$(this).next(".custom-file-label").text($(this).val());
		});
		// 문의하기
		var article = $(".qnaShow");
        $(".question td").click(function(){
            var myArticle = $(this).parent().next("tr");
            if($(myArticle).hasClass('hide')){
                $(article).removeClass('qnaShow').addClass('hide');
                $(myArticle).removeClass('hide').addClass('qnaShow');
            } else {
                $(myArticle).addClass('hide').removeClass('qnaShow');
            }
        });
        $("#qnaSubmit").click(function(){
        	if(user != ''){
            $("#qnaForm").submit();
            $(".btn btn-warning").modal("hide");
            $(".project-inquiry").focus();
        	} else {
        		alert("로그인이 필요합니다");
        	}
        });
	});
	
</script>
</head>
<body>
	<div class="main" style="overflow:hidden;">
	    <div class="container tim-container" style="max-width:1200px; padding-top:100px">
	    	<div class="project-title" >
	    		<div class="label label-warning">${project.cate_title}</div>
	    		<h3 style="font-weight:800;">${project.pro_title}</h3>
	    	</div>
	    	<div class="row project-basic col-md-8 col-sm-6">
	    		<div class="projectDetail_img">
	    			<img alt="" src="img/${project.pro_image}">
	    			<div class="container alert alert-warning" style="width:678px; margin:50px 0;">
	    			<fmt:parseDate var="pro_start" value="${project.pro_start_date}" pattern="yyyy-MM-dd HH:mm:ss" />
	    			<fmt:parseDate var="pro_finish" value="${project.pro_finish_date}" pattern="yyyy-MM-dd HH:mm:ss" />  
           			<b>목표 금액 <fmt:formatNumber type="number" maxFractionDigits="3" value="${project.pro_target}"/>원     펀딩기간
           			<fmt:formatDate value="${pro_start}" pattern="yyyy-MM-dd"/> - <fmt:formatDate value="${pro_finish}" pattern="yyyy-MM-dd"/></b><br><br>
            		100% 이상 모이면 펀딩이 성공되는 프로젝트<br>
					이 프로젝트는 펀딩 마감일까지 목표 금액이 100% 모이지 않으면 결제가 진행되지 않습니다.
		        	</div>
	    		</div>
	    	</div>
	    	
	    	<div class="project-state col-md-4 col-sm-6">
				<div class="state-box">
					<c:choose>
						<c:when test="${project.dday>0}">
							<p class="remainday">${project.dday}일 남음</p>
						</c:when>
						<c:when test="${project.dday<0}">
							<p class="remainday">펀딩 종료</p>
						</c:when>
						<c:when test="${project.dday==0}">
							<p class="remainday">오늘 자정 마감</p>
						</c:when>
					</c:choose>
					<div class="progress">
						<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="${project.percent}" aria-valuemin="0" aria-valuemax="100" style="width: ${project.percent}%;">
							<span class="sr-only">${project.percent}% Complete</span>
						</div>
					</div>
					<p class=""><strong>${project.percent}</strong>% 달성</p>
					<p class=""><strong><fmt:formatNumber type="number" maxFractionDigits="3" value="${project.pro_money}"/></strong>원  펀딩</p>
				</div>
				<div class="btn-funding">
					<button id="gofun" class="btn btn-block btn-lg btn-fill btn-warning">펀딩하기</button>
				</div>

				<div class="btn-wrap share">
				<form method="post" id="favor">
					<input type="hidden" name="mem_code" value="${user.mem_code}"/>
					<input type="hidden" name="pro_code" value="${project.pro_code}" />
				</form>
					<div class="btn-wrap-flex">
						<button class="btn btn-block btn-lg btn-round btn-warning" id="favBtn">관심프로젝트 등록</button>
					</div>
				</div>
				
				<div class="project-report">
					<p style="font-size:13px;">신고하기란?</p>
					<p>해당 프로젝트에 허위내용 및 지적재산권을<br>침해하는 내용이 있다면 제보해주세요.</p>
					<button id="reportBtn" class="btn btn-block btn-lg btn-default" data-toggle="modal" data-target="#myModal">프로젝트 신고하기</button>
					<!-- 신고하기 Modal -->
					<div class="modal fade in" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
									<h4 class="modal-title" id="myModalLabel">프로젝트 신고하기</h4>
								</div>
								<div class="modal-body">
								<form method="post" id="report-content" enctype="multipart/form-data">
								<input type="hidden" name="mem_code" value="${user.mem_code}"/>
								<input type="hidden" name="pro_code" value="${project.pro_code}" />
									<table class="report-modal">
										<colgroup>
											<col width="20%">
											<col width="80%">
										</colgroup>
										<tr>
											<th>프로젝트명</th><th>${project.pro_title}</th>
										</tr>
										<tr>
											<th>신고내용</th>
											<td>
												<textarea name="report_detail" placeholder="신고할 내용을 작성해주세요" class="form-control report-cont" rows="5" ></textarea>
											</td>
										</tr>
										<tr>
											<th>파일첨부</th>
											<td class="input-group mb-3">
												<div class="custom-file">
													<input type="file" name="report" class="custom-file-input" id="file01"/>
																		<label class="custom-file-label" for="file01">파일을 선택하세요</label>					
													
												</div>
											</td>
										</tr>
									</table>
								</form>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default btn-simple" data-dismiss="modal">취소</button>
									<div class="divider"></div>
									<button id="report" type="button" class="btn btn-warning btn-simple">신고하기</button>
								</div>
							</div>
						</div>
					</div>
					
				</div>
			</div>
			
			<!-- 메이커정보 -->
			<div class="project-maker">
				<div class="img-thumbnail" style="width:100%; padding:10px;">
					<div  class="col-md-10">
                 	   <img src="${path}/template/assets/img/mockup.png" alt="Circle Image" class="img-circle"  style="width: 50px; height: 50px;">
                 	   <span style="font-size:20px; vertical-align:middle;">${project.maker_name}</span>
                    </div>
                    <span class="col-md-2"><button id="goinq" class="btn btn-block btn-lg btn-warning">문의하기</button></span>
                </div>
			</div>
			
			<!-- 프로젝트 소개 -->
			<div class="col-md-8 col-sm-6" style="min-height:500px;margin-bottom: 100px;">
				<h3>프로젝트 스토리</h3>
				<div>
					${project.pro_story}
				</div>
			</div>
			
			<!-- 프로젝트 옵션 -->
			<div class="project-opt col-md-4 col-sm-6" style="min-height:500px;">
			<c:forEach var="opt" items="${opt}">
				<div class="project-opt-info">
				<fmt:parseDate var="opt_deliver_date" value="${opt.opt_deliver_date}" pattern="yyyy-MM-dd HH:mm:ss" />
					<button href="#fakelink" class="img-thumbnail opt-cont" style="width:300px;">
						<h6>${opt.opt_title}</h6>
						<p>${opt.opt_detail}</p><br>
						<p class="text-muted">${opt.opt_condition}</p><br>
						<p class="text-muted">배송비</p>
						<p><fmt:formatNumber type="number" maxFractionDigits="3" value="${opt.opt_delivery}"/>원</p>
						<p class="text-muted">리워드 발송 시작일</p>
						<p><fmt:formatDate value="${opt_deliver_date}" pattern="yyyy년 MM월 dd일"/> 예정</p>
					</button>
				</div>
			</c:forEach>
			</div>
			
	    	<!-- 문의 리스트 -->
	    	<div class="project-inquiry">
	    		<div class="inquiry-title">프로젝트 문의
	    			<button type="button" class="btn btn-warning" data-toggle="modal" data-target="#exampleModal" style="float:right;margin-bottom: 40px;" >문의하기</button>
	    		</div>
           		<table class="table table-hover" style="margin-top:2%;border-top: 1px solid #EaEaEa;">
					<thead>
						<tr style="text-align:center;padding:20px;">
							<th>번호</th><th>제목</th><th>작성자</th><th>작성날짜</th><th>답변여부</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="qna" items="${qna}">
						<tr class="question" style="text-align:center">
							<td>${qna.qna_code}</td>
							<td>
								<span class="title_td"><c:if test="${qna.qna_open=='Y'}">[비밀글]</c:if>${qna.qna_detail}</span>
							</td>
							<td>${qna.mem_name} </td>
							<td>${qna.qna_reg_date} </td>
							<td>
								<c:if test="${qna.qna_ans==null}">미답변</c:if>
								<c:if test="${qna.qna_ans!=null}">답변완료</c:if>
							</td>
						</tr>
						<tr class="hide">
						<c:if test="${qna.qna_open=='Y' && qna.mem_name==user.mem_name}">
							<td colspan="5">
								<pre>${qna.qna_detail}</pre>
                    			<c:if test="${qna.qna_ans!=null }">
                    				<pre class="qna_answer_pre">--------------------<span class="qna_answer">메이커 답변</span>---------------------------------------------------------------${qna.qna_ans_reg_date }--------------------<br>${qna.qna_ans}</pre>
                    		</td>
                    			</c:if>
                    			<c:if test="${qna.qna_ans==null }">
                    		</td>
                    			</c:if>
                    	</c:if>
                    	<c:if test="${qna.qna_open=='Y' && qna.mem_name!=user.mem_name}">
                    		<td colspan="5"><pre>[비밀글 입니다]</pre></td>
                    	</c:if>
                    	<c:if test="${qna.qna_open=='N'}">
                    		<td colspan="5">
                    			<pre>${qna.qna_detail}</pre>
                    			<c:if test="${qna.qna_ans!=null }">
									<pre class="qna_answer_pre">--------------------<span class="qna_answer">메이커 답변</span>---------------------------------------------------------------${qna.qna_ans_reg_date }--------------------<br>${qna.qna_ans}</pre>
							</td>
                    			</c:if>
                    			<c:if test="${qna.qna_ans==null }">
                    		</td>
                    			</c:if>
                    	</c:if>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
			<!-- 문의글 작성 -->
			<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                      <h4 class="modal-title" id="exampleModalLabel">스토어 문의하기</h4>
                    
                    </div>
                    <div class="modal-body">
                      <form method="post" id="qnaForm" action="store.do?method=insert">
                      	<div class="form-group">
                      		<label for="message-text" class="control-label">비밀글 유무</label>
                      		<input type="radio" value="Y" name="qna_open"> 비밀글로 하기 <input type="radio" value="n" name="qna_open"> 비밀글로 안하기
                      	</div>
                        <div class="form-group">
                          <label for="message-text" class="control-label">문의내용:</label>
                          <textarea class="form-control report-cont" id="message-text" name="qna_detail"></textarea>
                        </div>
                      </form>
                    </div>
                    <div class="modal-footer">
						<button type="button" class="btn btn-default btn-simple" data-dismiss="modal">닫기</button>
						<div class="divider"></div>
						<button type="submit" class="btn btn-warning btn-simple" id="qnaSubmit">문의하기</button>
                    </div>
                  </div>
                </div>
              </div>
	    
	    
		</div>
	</div>
	
</body>
</html>