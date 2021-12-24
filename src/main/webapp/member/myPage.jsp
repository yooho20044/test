<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<style>
	.container{	
		width:700px;
		margin-top:20px;
	}
	.col>h2{
	text-align:center;
	}
	.sizeInput{
	width:100%;
	margin-top:10px;
	}
	.btnBox{
	text-align:center;
	margin-top:10px;
	}
	label{
	padding-top:10px;
	}
	.cls_after{
		display:none;
	}

</style>
</head>
<body>
<form action = "${pageContext.request.contextPath}/modifyInfoProc.mem" method="post" id="modifyForm">
<div class="container">
		<div class="row">
			<div class="col">
				<h2>마이 페이지</h2>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<label for="id">아이디</label>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<input type="id" name ="id" id="id" class="form-control sizeInput" value = ${dto.getId()} readonly>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<label for="nickname">닉네임</label>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<input type="text" name="nickname" id="nickname" class="form-control sizeInput" value = ${dto.getNickname()} readonly>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<label for="phone">휴대폰 번호</label>
			</div>
		</div>
		<div class="row">
			<div class="col-4">
				<select class="form-select sizeInput" id="phFirst" aria-label="Default select example">
					<option value="010">010</option>
					<option value="017">017</option>
					<option value="019">019</option>
					<option value="011">011</option>
					<option value="016">016</option>
				</select>
			</div>
			<div class="col-4">
				<input type="phone" id="phMiddle" class="form-control sizeInput" readonly>
			</div>
			<div class="col-4">
				<input type="phone" id="phEnd" class="form-control sizeInput" readonly>
			</div>
			<div class="col d-none">
				<input type="phone" id="phone" name = "phone" class="form-control">
			</div>
		</div>
		<div class="row">
			<div class="col">
			    <label for="address">주소</label>
			</div>
		</div>
		<div class="row">
			<div class="col">
			    <input type="text" id="addressAll" name="addressAll" class="form-control sizeInput" value="${dto.getAddress()}" readonly>
			</div>
		</div>
		<div class="row cls_after">
			<div class="col-6">
			    <input type="text" id="sample4_postcode" class="form-control sizeInput" placeholder="우편번호" readonly>
			</div>
			<div class="col-6">
                <input type="button" onclick="sample4_execDaumPostcode()" class="btn btn-outline-info sizeInput" id="btnPost" value="우편번호 찾기" disabled>
			</div>
		</div>
		<div class="row cls_after">
		    <div class="col">
		        <input type="text" id="sample4_roadAddress" class="form-control sizeInput" placeholder="도로명주소" readonly>
		    </div>
		</div>
		<div class="row cls_after">
			<div class="col-6">
				<span id="guide" style="color:#999;display:none"></span>
				<input type="text" id="sample4_detailAddress" class="form-control sizeInput" placeholder="상세주소" readonly>
			</div>
			<div class="col-6">
				<input type="text" id="sample4_extraAddress" class="form-control sizeInput" placeholder="참고항목" readonly>
			</div>
		</div>
		<div class="row p-2 d-none">
			<div class="col d-none">
				<input type="text" id="address" class="form-control" name = "address">
			</div>
		</div>
		<div class="row justify-content-center" id = "rowBtnBox1">
			<div class="col justify-content-end btnBox">
				<button type = "button" class="btn btn-outline-secondary" id="btnHome">홈으로</button>
				<button type = "button" class="btn btn-outline-danger" id="btnModify">수정</button>			
			</div>
		</div>
		<div class= "row justify-content-center" id="rowBtnBox2" style="display:none">
			<div class="col justify-content-end btnBox">
				<button type = "button" class="btn btn-outline-secondary" id="btnBack">취소</button>
				<button type = "button" class="btn btn-outline-success" id = "btnGo">완료</button>
			</div>
		</div>
	</div>
</form>
<script>
	//phone
	let oriPhone = "${dto.getPhone()}";
	
	document.getElementById("phFirst").value = oriPhone.substring(0,3);
	document.getElementById("phMiddle").value = oriPhone.substring(3,7);
	document.getElementById("phEnd").value = oriPhone.substring(7);
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	
	<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script>

	let nickname = document.getElementById("nickname");
	let phFirst = document.getElementById("phFirst");
	let phMiddle = document.getElementById("phMiddle");
	let phEnd = document.getElementById("phEnd");
	let phone = document.getElementById("phone");
	let postcode = document.getElementById("sample4_postcode")
	let roadAddress = document.getElementById("sample4_roadAddress")
	let address = document.getElementById("address")
	let detailAddress = document.getElementById("sample4_detailAddress")
	let extraAddress = document.getElementById("sample4_extraAddress")
	let btnHome = document.getElementById("btnHome");
	let btnModify = document.getElementById("btnModify");
	let btnBack = document.getElementById("btnBack");
	let btnPost = document.getElementById("btnPost");
	let readInput = document.getElementsByClassName("cls_readInput")
	
	//완료버튼 처리시 
	document.getElementById("btnGo").addEventListener("click",function(){
		
		let regexNN = /^[ㄱ-힣a-zA-Z0-9]{2,16}$/g;
		let regexPhone = /[0-9]{11}/;
		
		phone.value = phFirst.value + phMiddle.value + phEnd.value
		
		if(nickname.value == "" || !regexNN.test(nickname.value)){
			alert("닉네임을 정확히 입력하세요(2자리~16자리 이하 한글, 영문자, 숫자사용)");
			return;
		}else if(!regexPhone.test(phone.value) ||phMiddle.value == "" || phEnd.value==""){
			alert("핸드폰 번호를 입력해주세요.");
			return;
		}else if(postcode.value == "" || roadAddress.value == ""){
			alert("주소를 입력해주세요.");
			return;
		}
		
		
		//주소요소선택
		
		address.value = "(" + postcode.value + ") "+roadAddress.value +" " + detailAddress.value + extraAddress.value
		console.log(address.value);
		//모든 유효성 검사를 통과했다면 폼 제출 
		document.getElementById("modifyForm").submit();
	})
	
	
	//홈버튼처리 -> index.jsp로 이동
	btnHome.addEventListener("click",function(){
		location.href = "${pageContext.request.contextPath}/"
	})
	
	//수정버튼 처리
	btnModify.addEventListener("click",function(){
		document.getElementById("rowBtnBox1").style.display = 'none';
		document.getElementById("rowBtnBox2").style.display = 'block';
		$(".cls_after").css("display","flex");
		
		nickname.readOnly = false;
		phMiddle.readOnly = false;
		phEnd.readOnly = false;
		postcode.readOnly = false;
		roadAddress.readOnly = false;
		detailAddress.readOnly = false;
		extraAddress.readOnly = false;
		btnPost.disabled= false;
		
	})
	
	//취소버튼 처리
	btnBack.addEventListener("click",function(){
		location.reload();
	})
</script>
</body>
</html>