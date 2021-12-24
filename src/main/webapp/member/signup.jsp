<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
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
	.btnId{
	width:100%;
	margin-top:10px;	
	}
	label{
	padding-top:10px;
	}
	
</style>
</head>
<body>
<!-- 절대경로(플젝명)잡아주기 ${pageContext.request.contextPath}/플젝명 -->
<form id="signupForm" action="${pageContext.request.contextPath}/signupProc.mem" method="post" name="signupForm">
<div class="container">
		<div class="row">
			<div class="col">
				<h2>회원가입</h2>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<label for="id">아이디</label>
			</div>
		</div>
		<div class="row">
			<div class="col-9">
				<input type="id" name ="id" id="id" class="form-control sizeInput" readonly>
			</div>
			<div class="col-3">
				<button type = "button" class="btn btn-outline-warning btnId" id="btnCheckId">아이디 확인</button>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<label for="pw">비밀번호</label>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<input type="password" name ="password" id = "pw" class="form-control sizeInput">
			</div>
		</div>
		<div class="row">
			<div class="col">
				<label for="pwCheck">비밀번호 확인</label>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<input type="password" id="pwCheck" class="form-control sizeInput">
			</div>
		</div>
		<div id="pwCheckBox">
		</div>
		<div class="row">
			<div class="col">
				<label for="nickname">닉네임</label>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<input type="text" name="nickname" id="nickname" class="form-control sizeInput">
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
				<input type="phone" id="phMiddle" class="form-control sizeInput">
			</div>
			<div class="col-4">
				<input type="phone" id="phEnd" class="form-control sizeInput">
			</div>
			<div class="col d-none">
				<input type="phone" id="phone" name = "phone" class="form-control">
			</div>
		</div>
		<div class="row">
			<div class="col-6">
			    <input type="text" id="sample4_postcode" class="form-control sizeInput" placeholder="우편번호">
			</div>
			<div class="col-6">
                <input type="button" onclick="sample4_execDaumPostcode()" class="btn btn-outline-info sizeInput" value="우편번호 찾기">
			</div>
		</div>
		<div class="row">
		    <div class="col">
		        <input type="text" id="sample4_roadAddress" class="form-control sizeInput" placeholder="도로명주소">
		    </div>
		</div>
		<div class="row">
			<div class="col-6">
				<span id="guide" style="color:#999;display:none"></span>
				<input type="text" id="sample4_detailAddress" class="form-control sizeInput" placeholder="상세주소">
			</div>
			<div class="col-6">
				<input type="text" id="sample4_extraAddress" class="form-control sizeInput" placeholder="참고항목">
			</div>
		</div>
		<div class="row p-2 d-none">
			<div class="col d-none">
				<input type="text" id="address" class="form-control" name = "address">
			</div>
		</div>
		<div class="row">
			<div class="col btnBox">
				<button type = "button" class="btn btn-outline-secondary" id="btnBack">취소</button>
				<button type = "button" class="btn btn-outline-success" id="btnGo">가입</button>
			</div>
		</div>
	</div>
</form>
	

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
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script>

	let id = document.getElementById("id");
	let pw = document.getElementById("pw");
	let pwCheck = document.getElementById("pwCheck");
	let nickname = document.getElementById("nickname");
	let phFirst = document.getElementById("phFirst");
	let phMiddle = document.getElementById("phMiddle");
	let phEnd = document.getElementById("phEnd");
	let phone = document.getElementById("phone");
	let postcode = document.getElementById("sample4_postcode")
	let roadAddress = document.getElementById("sample4_roadAddress")
	let pwCheckBox = document.getElementById("pwCheckBox");
	let btnGo = document.getElementById("btnGo");
	let address = document.getElementById("address")
	let detailAddress = document.getElementById("sample4_detailAddress")
	let extraAddress = document.getElementById("sample4_extraAddress")


	//아이디 확인 버튼을 클릭했을 때 이벤트
	document.getElementById("btnCheckId").addEventListener("click", function(){
		let uri="/idCheckPopup.mem";
		let name = "아이디 중복검사";
		let option = "width=600, height=400, top=300";
		
		window.open(uri, name, option);
	})
	
	//비밀번호 확인창
	pwCheck.onblur = function(e){
		if(pw.value == pwCheck.value && pw.value!="" ){
			pwCheckBox.innerHTML = "패스워드 일치"
			pwCheckBox.style.color="green";
		}else{
			pwCheckBox.innerHTML = "패스워드 불일치"
			pwCheckBox.style.color="red";
		}
	}
	
	
	
	
	//유효성검사
	btnGo.addEventListener("click", function(){
		
		let regexPw= /^[a-zA-Z0-9-~!@#$%^&*.+]{6,20}$/g;
		let regexNN = /^[ㄱ-힣a-zA-Z0-9]{2,16}$/g;
		
		if(id.value == ""){
			alert("아이디를 입력해주세요.");
			return;
		}else if(pw.value == "" || !regexPw.test(pw.value)){
			alert("비밀번호를 정확히 입력하세요(6자리~20자리 이하 영문자,숮자,특수문자사용)");
			return;
		}else if(pwCheck.value=="" || pw.value != pwCheck.value){
			alert("비밀번호 값이 일치하지 않습니다.");
			return;
		}else if(nickname.value == "" || !regexNN.test(nickname.value)){
			alert("닉네임을 정확히 입력하세요(2자리~16자리 이하 한글, 영문자, 숫자사용)");
			return;
		}else if(phMiddle.value == "" || phEnd.value==""){
			alert("핸드폰 번호를 입력해주세요.");
			return;
		}else if(postcode.value == "" || roadAddress.value == ""){
			alert("주소를 입력해주세요.");
			return;
		}
		
		//핸드폰요소선택
		phone.value = phFirst.value + phMiddle.value + phEnd.value
		//주소요소선택
		address.value = "(" + postcode.value + ") "+roadAddress.value +" " + detailAddress.value + extraAddress.value
		console.log(address.value);
		//모든 유효성 검사를 통과했다면 폼 제출 
		document.getElementById("signupForm").submit();
		
	})
	btnBack.addEventListener("click", function(){
		location.href = "${pageContext.request.contextPath}/";
	})
</script>
</body>
</html>