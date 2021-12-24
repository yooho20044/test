<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body>

<form action="/idCheckProc.mem" method="post" id="checkForm">
<div class="container">
		<div class="row p-4">
			<div class= "col-8 mb-4">
                <input type="text" id="idInput" name="idInput" class="form-control" placeholder="id를 입력하세요." value="${idInput}">
			</div>
			<div class= "col-4 mb-4">
                <button type="button" id="btnCheck" class="btn btn-outline-warning">아이디 확인</button>
			</div>
		</div>
		<div class="row p-4">
			<div class= "col mb-4">
                <h5>확인 결과 : </h5>
			</div>
		</div>
		<div class="row p-4">
			<div class= "col mb-4">
				<c:if test = "${rs eq 'available'}">
				<p id="rs">사용 가능한 아이디입니다.</p>
				</c:if>
				<c:if test="${rs eq 'unavailable'}">
				<p id="rs">사용 불가한 아이디입니다.</p>
				</c:if>
			</div>
		</div>
		<div class="row justify-content-center">
			<div class= "col-4 d-flex justify-content-end">
                <button type="button" id="btnCancel" class="btn btn-outline-secondary">창닫기</button>
			</div>
			<div class="col-4 d-flex justify-content-start">
                <button disabled type="button" id="btnSubmit" class="btn btn-outline-primary">사용</button>
			</div>
		</div>
	</div>
</form>
<script>
	let rs = document.getElementById("rs");
	let btnSubmit = document.getElementById("btnSubmit");
	let btnCancel = document.getElementById("btnCancel");
	let idInput = document.getElementById("idInput");
	let btnCheck = document.getElementById("btnCheck");
	
	//확인버튼을 눌렀을때 submit에 대한 이벤트 처리
	btnCheck.addEventListener("click", function(){
		//아이디 정규식 추가 
		let regexId= /[a-zA-Z]+[a-zA-Z0-9]{5,11}/g;
		if(!regexId.test(idInput.value)){
			alert("아이디를 정확히 입력하세요. (6자리~12자리 이하 영문자 혹은 숫자사용[영문자로 시작해야함])");
			return;
		}
		document.getElementById("checkForm").submit();
	})
	
	
	
	btnCancel.addEventListener("click",function(){
		self.close(); // 현재 팝업창을 닫음
	})
	
	btnSubmit.addEventListener("click", function(){
		opener.document.signupForm.id.value=idInput.value;
		self.close();
	})
	
	if(rs.innerHTML == "사용 가능한 아이디입니다."){
		rs.style.color="green";
		btnSubmit.disabled = false;
	}else{
		rs.style.color="red";
	}
</script>
</body>
</html>