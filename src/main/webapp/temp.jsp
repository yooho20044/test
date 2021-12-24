<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
</head>
<body>
	<form id="testForm" method="post">
	<input type="text" id="id" name="id" value="id입니다">
	<input type="text" id="pw" name="pw" value ="password입니다.">
	<button type="button" id="sendForm">전송</button>
	</form>
	<script>
		//form 태그 이용해서 post방식으로 데이터 전송
		$("#sendForm").on("click",function(){
			//주의할 점 : file 전송은 안됨 
			let data = $("#testForm").serialize();
			console.log(data);
			
			$.ajax({
				type:"post",
				url:"${pageContext.request.contextPath}/request3.temp",
				data : data,
				dataType : "json"
				//data: {id : "id입니다", pw : "pw입니다"} 
			}).done(function(data){ //서버에 요청을 보내고, 그 요청이 성공적으로 이뤄졌을때 응답값을 되돌려 받는 곳
				
				console.log(data);
				for(let i of data){
					console.log(i.seq_comment + " : " + i.seq_board + " : " + i.content + " : " + 
							i.writer + " : " + i.writer_id+ " : " + i.written_date);
				}
			}).fail(function(e){ //서버에 요청이 실패했을 때 매개변수로 에러와 관련된 정보값이 담김.
				console.log(e);
			})
			
		});
	</script>
	<br>
	<button type="button" id="btnSend1">ajax 요청1</button>

	
	<script>
		//1. ajax를 이용해서 서버에 요청
		$("#btnSend1").on("click",function(){
			$.ajax({ //요청할 정보, 응답받을 내용에 대한 정보를 기술 -> key, value형식으로
				type:"get" //보낼 요청의 타입
				, url : "${pageContext.request.contextPath}/request1.temp?id=id입니다&pw=pw입니다."//요청을 보낼 url
			})
		});
		

	</script>
</body>
</html>