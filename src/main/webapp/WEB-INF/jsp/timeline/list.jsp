<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>     
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>timeline - 리스트</title>
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
 	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script> 
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    
    <link rel="stylesheet" href="/static/css/style.css" type="text/css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
</head>
<body>

	<div class="container ">
		<c:import url="/WEB-INF/jsp/include/header.jsp"/>
		<section class="contents d-flex justify-content-center">
			<!-- 사진 넣기 버튼 -->
			<!-- timeline -->
			<div class="col-6 mt-3">
				<!-- 입력 상자	 -->
				<div class="border rounded">
					<textarea class="form-control border-0" rows="4" id="contentInput"></textarea>
					
					<div class="d-flex justify-content-between ">
						<a href="#" id="imageIcon"><i class="bi bi-image ml-2 .image-icon"></i></a>
						<input type="file" id="fileInput" class="d-none">
						<button type="button" class="btn btn-primary" id="saveBtn">업로드</button>
					</div>
				</div>
				
				<!-- /입력상자 -->
				
				<!-- 피드들 -->
				<div class="mt-3">
					<!--카드  -->
					<div class="border rounded p-2">
					
						<c:forEach var="timeline" items="${timelineList }">
						<div class="d-flex justify-content-between p-2">
							<div>${userName }</div>
							<i class="bi bi-three-dots"></i>
						</div>
						
						<div>
							<img class="w-100" src="${timeline.imagePath }">
						</div>
						
						<!-- 좋아요 -->
						<div class="p-2">
							<i class="bi bi-suit-heart"></i> <span class="small">좋아요 10</span>
						</div>
						
						<div class="mt-2">
							<b>${userName }</b> ${timeline.content }
						</div>
					
						<!-- 댓글 -->
						<div class="mt-3 p-2">
							<div class="small">댓글</div>
							<hr>
							<div class="small"> <b>김현식2</b> 진짜 귀엽네요 ㅋㅋ</div>
							<div class="small"> <b>김현식3</b> 진짜 귀엽네요 ㅋㅋ</div>
						
							<!-- 댓글입력 -->
							<div class="d-flex mt-3">
								<input type="text" class="form-control">
								<button type="button" class="btn btn-primary">게시</button>
							</div>
						</div>
						<!-- /댓글 -->
						</c:forEach>
					
					</div>
				</div>
			</div>
		</section>
		<c:import url="/WEB-INF/jsp/include/footer.jsp"/>
	</div>
	
	
	<script>
		$(document).ready(function(){
			$("#saveBtn").on("click", function(){
				let content = $("#contentInput").val();
				
				if(content == ""){
					alert("내용을 입력해주세요.");
					return;
				}
				
				var formData = new FormData();
				formData.append("content", content);
				formData.append("file", $("#fileInput")[0].files[0]);
				
				$.ajax({
					type:"post"
					, url:"/timeline/create"
					, data:formData
					, enctype:"multipart/form-data" //파일 업로드 필수 옵션
					, processData:false				//파일 업로드 필수 옵션
					, contentType:false				//파일 업로드 필수 옵션
					, success:function(data){
						if(data.result == "success"){
							location.href="/timeline/list/view";
						} else {
							alert("입력실패");
						}
					}
					, error:function(){
						alert("입력 실패");
					}
				});
			});
			
			
			
			
			$("#imageIcon").on("click", function(){
					//파일 인풋을 클릭한 효과
					$("#fileInput").click();
			});
		});
	</script>
</body>
</html>