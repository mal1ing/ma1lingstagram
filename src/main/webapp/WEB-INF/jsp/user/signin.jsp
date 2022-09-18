<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ma1lingstagram - 로그인</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
 	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script> 
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    
    <link rel="stylesheet" href="/static/css/style.css" type="text/css">
</head>
<body>
		<c:import url="/WEB-INF/jsp/include/header.jsp"></c:import>
		<div class="container">
			<section class="contents d-flex justify-content-center">
			<div class="join-box my-5">
				<h2 class="text-center">로그인</h2>
				<form id=loginForm>
					<input text="text" placeholder="아이디" class="form-control mt-2" id="loginIdInput">
					<input text="password" placeholder="비밀번호" class="form-control mt-2" id="passwordInput">
					<button type="submit" class="btn btn-primary btn-block mt-2" id="loginBtn">로그인</button>
					
				</form>
				<div class="text-center mt-2">
					<A href="/user/signup/view">회원가입</A>
				</div>
			</div>
			</section>		
		</div>
		<c:import url="/WEB-INF/jsp/include/footer.jsp"></c:import>
		<script>
			$(document).ready(function(){
				$("#loginForm").on("submit", function(e){
					
					e.preventDefault();
					
					let loginId = $("#loginIdInput").val();
					let password = $("#passwordInput").val();
					
					if(loginId == ""){
						alert("아이디를 입력해주세요.");
						return;
					}
					
					if(password == ""){
						alert("비밀번호를 입력해주세요.");
						return;
					}
					
					$.ajax({
						type:"post"
						, url:"/user/signin"
						, data:{"loginId":loginId, "password":password}
						, success:function(data){
							
							if(data.result == "success"){
								location.href = "/timeline/list/view";
							} else {
								alert("아이디/비밀번호를 확인하세요.");
							}
						}
						, error:function(){
							alert("로그인 에러");
						}
					});
				});
			});
		</script>
</body>
</html>