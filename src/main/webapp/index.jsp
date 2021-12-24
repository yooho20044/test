<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 프로그램 홈</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<style>
	.container{
		text-align:center;
		margin-top : 40px;
		width:350px;
	}
	div{
	margin-top : 10px;
	}
	.row{
	margin-top : 10px;
	}
	.container2{
		text-align:center;
		margin-top:40px;
		width:700px;
	}
	.afterBtn{
	width:120px;
	margin:10px;
	}
</style>
</head>
<body>
	<c:choose>
		<c:when test="${!empty loginSession}">
			<div class="container container2">
				<div class= "row">
					<div class="col">
						<h2>${loginSession.nickname}님 환영합니다.</h2>
					</div>
				</div>
				<div class="row">
					<div class="col btnBox">
						<button type = "button" class="btn btn-dark afterBtn" id="btnLogout">로그아웃</button>
					</div>
					<div class="col btnBox">
						<button type = "button" class="btn btn-warning afterBtn" id="btnMyPage">마이페이지</button>
					</div>
					<div class="col btnBox">
						<button type = "button" class="btn btn-success afterBtn" id="btnBoard">게시판</button>
					</div>
					<div class="col btnBox">
						<button type = "button" class="btn btn-danger afterBtn" id="btnDelete">회원탈퇴</button>
					</div>
				</div>
			</div>
			<script>
				document.getElementById("btnLogout").addEventListener("click", function(){
					location.href = "${pageContext.request.contextPath}/logoutProc.mem";
				})
				
				document.getElementById("btnDelete").addEventListener("click",function(){
					let rs = confirm("정말 탈퇴하시겠습니까?");
					
					if(rs){
						location.href = "${pageContext.request.contextPath}/withdrawProc.mem"
					}
				})
				document.getElementById("btnMyPage").addEventListener("click", function(){
					location.href = "${pageContext.request.contextPath}/toMyPage.mem";
				})
				document.getElementById("btnBoard").addEventListener("click", function(){
					location.href = "${pageContext.request.contextPath}/toBoard.bo?currentPage=1";
				})
			</script>
		</c:when>
		<c:otherwise>
			<c:if test="${rs eq 'fail'}"> 
				<script>
					alert("아이디 혹은 비밀번호를 잘못 입력하였습니다.");
				</script>
			</c:if>
			<form action ="${pageContext.request.contextPath}/loginProc.mem" id="formLogin" method="post">
				<div class= "container">
					<h2>Board</h2>
					<div class = "row">
						<input type="text" id="idInput" name = "id" placeholder="id 입력">
					</div>
					<div class="row">
						<input type="password" id="pwInput" name = "pw" placeholder="pw 입력">
					</div>
					<div class="btnBox">
						<button type="button" class="btn btn-outline-primary btn-sm" id="btnLogin">로그인</button>
						<button type="button" class="btn btn-outline-info btn-sm" id="btnSignup">회원가입</button>
					</div>
				</div>
			</form>
			<script>
				
				//로그인
				document.getElementById("btnLogin").onclick = function(){
				if(document.getElementById("idInput").value == "" || document.getElementById("pwInput").value == ""){
				alert("아이디 혹은 비밀번호를 입력하세요.");
				return;
				}
				document.getElementById("formLogin").submit();
				}
				
				document.getElementById("btnSignup").addEventListener("click",function(){
				location.href = "${pageContext.request.contextPath}/toSignup.mem";
				})
				
			</script>
		</c:otherwise>
	</c:choose>
</body>
</html>