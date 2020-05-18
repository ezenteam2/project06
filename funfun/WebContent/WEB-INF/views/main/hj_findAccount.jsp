<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<%@ include file="/template/header.jsp" %>
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
		
</script>
<link rel="stylesheet" href="${path }/css/shakeAndBounce.css" />

<script>
	$(document).ready(function(){
		$('.main').addClass('bounce');
		setTimeout(()=>{
			$('.main').removeClass('bounce');
		},500);
	})
</script>
</head>
<body>
	<div class="main">
	    <div id="vue-container"  class="container tim-container" style="max-width:1200px; padding-top:100px">
	       <form-find-id  v-bind:class="{bounce:isBounce}" v-if="status==='id'" v-on:change="change"></form-find-id>
           <form-find-pass  v-bind:class="{bounce:isBounce}" v-if="status==='pass'" v-on:change="change"></form-find-pass>
	    </div>
	</div>
	<!-- end main -->
	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
	<script type="text/x-template" id="form-find-id">
    <div>
    <h1 class="text-center">아이디 찾기</h1>
        <br><br><br>
        <div class="row">
	        <div class="col-md-4"></div>
	        <div class="col-md-4">
	        	<div class="btn-group btn-group-justified">
				  <a id="changeBtn" v-on:click="changeForm" class="btn btn-warning">비밀번호 찾기 > </a>
			</div>
	        </div>
		</div>
        <br><br>
        <div class="row">
	        <div class="col-md-4"></div>
	        <div class="col-md-4">
	        	<div class="form-group">
				  <label for="usr">가입 시 등록한 이메일 주소 입력</label>
				  <input v-model="inputEmail" type="text" class="form-control" name="mem_email">
				</div>
	        </div>
		</div>
        
        <div class="row">
	        <div class="col-md-4"></div>
	        <div class="col-md-4">
	        	<div v-bind:style="{color:fontColor}" v-bind:class="{shaking:isShake}">{{alertMsg}}</div>
	        </div>
		</div>
        
    	<br><br>
    	<div class="row">
    		<div class="col-md-4"></div>
    		<div class="col-md-4">
    			<button v-on:click="checkIsEmailReg" type="button" class="btn btn-warning btn-lg" style="width:100%; background-color:rgb(255,150,0); color:white;">가입여부 확인</button>
    		</div>
        </div>
    </div>
	</script>

<script type="text/x-template" id="form-find-pass">
    <div>
        <h1 class="text-center">비밀번호 찾기</h1>
            <br><br><br>
            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    <div class="btn-group btn-group-justified">
                      <a v-on:click="changeForm" id="changeBtn" class="btn btn-warning"> < 아이디 찾기</a>
                </div>
                </div>
            </div>
            <br><br>
            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    <div class="form-group">
                      <label for="usr">가입 시 등록한 이메일 주소 입력</label>
                      <input v-bind:disabled="isDisabled" v-model="inputEmail" type="text" class="form-control" name="mem_email">
                    </div>
                </div>
            </div>

			<div class="row">
	        <div class="col-md-4"></div>
	        <div class="col-md-4">
	        	<div v-bind:style="{color:fontColor}" v-bind:class="{shaking:isShake}">{{alertMsg}}</div>
	        </div>
		</div>
            
            <form-reset-pass v-bind:change-result="changeResult"  v-on:changePass="changePass" v-bind:class="{bounce:isBounce}" v-if="isResetForm"></form-reset-pass>
            
            <br><br>
            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    <button v-if="isResetForm===false" v-on:click="checkEmail" type="button" class="btn btn-warning btn-lg" style="width:100%; background-color:rgb(255,150,0); color:white;">비밀번호 재설정</button>
                </div>
            </div>
        </div>
</script>
<script type="text/x-template" id="form-reset-pass">
<div>
	<div class="row">
      <div class="col-md-4"></div>
      <div class="col-md-4">
          <div class="form-group">
              <label for="usr">재설정할 비밀번호</label>
              <input v-model="pass1" v-on:blur="pass1Chk" v-on:focus="pass1Focus" type="password" class="form-control">
          </div>
      </div>
    </div>
	<div class="row">
      <div class="col-md-4"></div>
      <div class="col-md-4">
          <div class="form-group">
              <label for="usr">재설정할 비밀번호 확인</label>
              <input v-on:blur="pass2Chk" v-model="pass2" type="password" class="form-control">
          </div>
      </div>
    </div>

	<div class="row">
	        <div class="col-md-4"></div>
	        <div class="col-md-4">
	        	<div v-bind:style="{color:fontColor}" v-bind:class="{shaking:isShake, bounce:isBounce}">{{alertMsg}}</div>
				<div v-if="countOn" style="color:black;" >{{count}}초 후에 로그인 페이지로 이동합니다..</div>
	        </div>
		</div>
	<br>
	<div class="row">
       <div class="col-md-4"></div>
       <div class="col-md-4">
         <button v-if="isButtonOn" v-on:click="changePass" type="button" class="btn btn-warning btn-lg" style="width:100%; background-color:rgb(255,150,0); color:white;">변경 완료</button>
       </div>
    </div>
</div>
</script>
<script>
        var formFindId=Vue.extend({
            template:"#form-find-id",
            data:function(){
                return {
                    inputEmail:"",
                    alertMsg:"",
                    isShake:false,
                    fontColor:"green",
                }
                
            },
            methods:{
                changeForm:function(){
                    this.$emit('change');
                },
                checkIsEmailReg:function(){
                    if(this.inputEmail!==''){
                    	console.log("${path}/signupIdCheck.do?mem_email="+this.inputEmail);
                    	this.fontColor="black";
                    	this.alertMsg="확인중...";
                    	$.ajax({
        					type:"post",
        					url:"${path}/signupIdCheck.do?mem_email="+this.inputEmail,
        					dataType:"json",
        					success:(data)=>{
        						if(data.verification===false){
        							this.alertMsg="이미 등록된 이메일입니다."
        							this.isShake=true;
        							this.fontColor="red";
        							setTimeout(()=>{
        								this.isShake=false;
        							}, 500)
        							
        						} else {
        							this.alertMsg="등록가능한 이메일입니다."
        							this.fontColor="green";
        						}
        					},
        					error:(err)=>{
        						console.log("ajax처리 에러");
        						console.log(err);
        					}
        				});
                    }
                }
            }
        });
        
        var formResetPass=Vue.extend({
        	template:"#form-reset-pass",
        	data:function(){
        		return{
        			pass1:"",
        			pass2:"",
        			isButtonOn:false,
        			alertMsg:"",
        			fontColor:"red",
        			isShake:false,
        			isBounce:false,
        			countOn:false,
        			count:5,
        		}
        	},
        	props:['change-result'],
            watch:{
            	changeResult:function(val){
            		this.alertMsg="변경이 완료되었습니다.";
            		this.fontColor="green";
            		this.countOn=true;
            	},
            	countOn:function(val){
            		if(val===true){
            			setInterval(()=>{
            				this.count=this.count-1;
            			}, 1000);
            		}
            	},
            	count:function(val){
            		if(val===0){
            			window.location="${path}/login.do";
            		}
            	}
            },
        	methods:{
        		pass1Focus:function(){
        			this.isButtonOn=false;
        		},
        		pass1Chk:function(){
        			var regExp = /^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{8,20}$/; //  8 ~ 20자 영문, 숫자 조합
        			if(!regExp.test(this.pass1)){
        				this.alertMsg="비밀번호는 8~20자 영문과 숫자를 조합해야합니다.";
        				this.fontColor="red";
        				this.isShake=true;
        				setTimeout(()=>{
        					this.isShake=false;
        				},500);
        				this.pass1="";
        			} else {
        				this.alertMsg="";
        			}
        		},
        		pass2Chk:function(){
        			if(this.pass1!==this.pass2){
        				this.alertMsg="비밀번호가 일치하지 않습니다.";
        				this.fontColor="red";
        				this.isShake=true;
        				setTimeout(()=>{
        					this.isShake=false;
        				},500);
        				this.pass2="";
        			} else {
        				this.alertMsg="비밀번호가 일치합니다.";
        				this.fontColor="green";
        				this.isBounce=true;
        				setTimeout(()=>{
        					this.isBounce=false;
        				},500);
        				this.isButtonOn=true;
        			}
        		},
        		changePass:function(){
        			this.alertMsg="비밀번호 변경 중입니다...";
        			this.fontColor="black";
        			this.$emit('changePass', this.pass1);
        		}
        	}
        });
        
        var formFindPass=Vue.extend({
            template:"#form-find-pass",
            data:function(){
            	return{
            		inputEmail:"",
            		isShake:false,
            		isResetForm:false,
            		fontColor:"red",
            		alertMsg:"",
            		isBounce:false,
            		isDisabled:false,
            		changeResult:false,
            	}
            },
            methods:{
            	changePass:function(pass){
            		$.ajax({
    					type:"post",
    					url:"${path}/changePass.do?mem_email="+this.inputEmail+"&mem_pw="+pass,
    					dataType:"json",
    					success:(data)=>{
    						console.log("비밀번호 변경완료");
    						if(data.result===true){
    							this.changeResult=true;
    						}
    					},
    					error:(err)=>{
    						console.log("ajax처리 에러");
    						console.log(err);
    					}
    				});
            		
            	},
                changeForm:function(){
                    this.$emit('change');
                },
                callResetForm:function(){
                	this.isResetForm=true;
                	this.isBounce=true;
                	this.isDisabled=true;
                	setTimeout(()=>{
                		this.isBounce=false;
                	},500);
                	
                },
                checkEmail:function(){
                	if(this.inputEmail===''){
                		this.alertMsg="이메일을 입력해주세요..";
                		this.fontColor="red";
                		this.isShake=true;
                		setTimeout(()=>{
                			this.isShake=false;
                		}, 500);
                	} else {
                		this.fontColor="black";
                    	this.alertMsg="확인중...";
                    	$.ajax({
        					type:"post",
        					url:"${path}/signupIdCheck.do?mem_email="+this.inputEmail,
        					dataType:"json",
        					success:(data)=>{
        						this.alertMsg="";
        						if(data.verification===false){
        							this.callResetForm();
        							
        						} else {
        							this.alertMsg="등록되지 않은 이메일입니다."
        							this.fontColor="red";
        							this.isShake=true;
        							this.fontColor="red";
        							setTimeout(()=>{
        								this.isShake=false;
        							}, 500)
        						}
        					},
        					error:(err)=>{
        						console.log("ajax처리 에러");
        						console.log(err);
        					}
        				});
                	}
                }
                
            },
            components:{
            	'form-reset-pass':formResetPass,
            }
        });
        
        
        

        var vm = new Vue({
            el:'#vue-container',
            data:{
                status:"id",
				isBounce:false
            },
			components:{
                'form-find-id':formFindId,
                'form-find-pass':formFindPass
            },
            methods:{
                change:function(){
                	if(this.status==='id'){
                        this.isBounce=true;
                        this.status='pass';
                        setTimeout(function(){
                            this.isBounce=false;
                        }, 1000);
                    } else if(this.status==='pass'){
                        this.status='id';
                        this.isBounce=true;
                        setTimeout(function(){
                            this.isBounce=false;
                        }, 1000);
                    }
                }
            }
		});
   </script>
</body>
</html>