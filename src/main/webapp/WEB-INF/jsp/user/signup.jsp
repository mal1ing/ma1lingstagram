<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ma1lingstagram - 회원가입</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
 	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script> 
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    
    <link rel="stylesheet" href="/static/css/style.css" type="text/css">
</head>
<body>
	<h1>회원가입</h1>
		<c:import url="/WEB-INF/jsp/include/header.jsp"/>
		<div class="container">
			<section class="contents d-flex justify-content-center">
				<div class="join-box my-5">
					<h2 class="text-center">회원가입</h2>
					<input type="text" placeholder="아이디" class="form-control mt-2" id="loginIdInput">
					<button type="button" class="btn btn-success btn-block mt-3" id="isDuplicateBtn">아이디 중복 검사</button>
					<div>
						<small  class="text-info text-success d-none" id="availableText" >사용가능한 아이디입니다..</small>
						<small  class="text-info text-danger d-none" id="duplicateText">중복된 아이디입니다..</small>
					</div>
					<input type="password" placeholder="비밀번호" class="form-control mt-2" id="passwordInput">
					<input type="password" placeholder="비밀번호 확인" class="form-control mt-2" id="passwordConfirmInput">
					<input type="text" placeholder="이름" class="form-control mt-2" id="nameInput">
					<input type="text" placeholder="이메일 주소" class="form-control mt-2" id="emailInput">
					<button type="button" class="btn btn-primary btn-block mt-2" id="joinBtn">가입</button>
					<A href="/user/signin/view" class="btn btn-danger btn-block mt-3">로그인페이지</A>
				</div>
			</section>
		</div>
		<c:import url="/WEB-INF/jsp/include/footer.jsp"/>
	
		<script>
			$(document).ready(function(){
			
				//전역 변수 만들어서 중복체크에 사용
				var isDuplicateCheck = false;
				var isDuplicateID = true;
				
				$("#loginIdInput").on("input", function(){
					
					// 사용자가 아이디 인풋을 건두는 순간
					// 중복체크 과련 모든 사항을 초기화
					
					isDuplicateCheck = false;
					isDuplicateID = true;
					
					$("#duplicateText").addClass("d-none");
					$("#availableText").addClass("d-none");
					
					
				});
				
				$("#isDuplicateBtn").on("click", function(){
					
					let loginId = $("#loginIdInput").val();
					
					if(loginId == ""){
						alert("아이디를 입력해주세요.");
						return;
					}
					
					
					$.ajax({
						type:"get"
						, url:"/user/duplicate_id"
						, data:{"loginId":loginId}
						, success:function(data){
							
							isDuplicateCheck = true;
							/* 중복시{"id_duplicate" : true}
							중복이 아닌 경우 {"id_duplicate:"false} */
							
							if(data.id_duplicate){
								$("#duplicateText").removeClass("d-none");
								$("#availableText").addClass("d-none");
								isDuplicateId = true;
							} else {
								$("#duplicateText").addClass("d-none");
								$("#availableText").removeClass("d-none");
								isDuplicateId = false;
							}
						}
						, error:function(){
							alert("중복체크 에러");
						}
					});
					
				});
				
				$("#joinBtn").on("click", function(){
					
					let loginId = $("#loginIdInput").val();
					let password = $("#passwordInput").val();
					let passwordConfirm = $("#passwordConfirmInput").val();
					let name = $("#nameInput").val();
					let email = $("#emailInput").val();
					
					if(loginId == ""){
						alert("아이디를 입력해주세요.");
						return;
					}
					
					// 중복체크 여부 확인 (중복체크가 진행되지 않으면 return)
					if(isDuplicateCheck == false){
						alert("중복체크를 진행해주세요.");
						return;
					}
					
					// 아이디 중복확인 (중복된 상태면 return)
					if(isDuplicateId){
						alert("아이디가 중복되었습니다.");
						return;
					}
					
					if(password == ""){
						alert("비밀번호를 입력해주세요.");
						return;
					}
					
					if(password != passwordConfirm){
						alert("비밀번호가 일치하지 않습니다.");
					}
					
					if(name == ""){
						alert("이름을 입력해주세요.");
						return;
					}
					
					if(email == ""){
						alert("이메일을 입력해주세요.");
						return;
					}
					
					//회원가입 api 호출\
					$.ajax({
						type:"post"
						, url:"/user/signup"
						, data:{"loginId":loginId, "password":password, "name":name, "email":email}
						, success:function(data){
							if(data.result == "success"){
								location.href = "/user/signin/view";
							} else {
								alert("회원가입 실패");
							}
						}
						, error:function(){
							alert("회원가입 에러");
						}
					});
					
				});
				
				
				
				
			});
		</script>

</body>
</html>