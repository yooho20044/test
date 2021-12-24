<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<style>
    .container{
        width:900px;
        margin:auto;
        text-align:center;
    }
    .btnBox>div{
        text-align: right;
    }
    .boardList>td>a{
    	text-decoration:none;
    	color:black;
    }
</style>
</head>
<body>


<div class="container">
    <div class="row p-3 btnBox">
        <div class="col">
            <button type="button" class="btn btn-outline-danger" id="btnLogout">로그아웃</button>
            <button type="button" class="btn btn-outline-warning" id="btnWrite">글쓰기</button>
        </div>
    </div>
    <div class="row p-2">
        <div class="col">
            <h4>게시판</h4>
        </div>
    </div>
    <div class="row">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th class="col-md-1">글번호</th>
                    <th class="col-md-5">제목</th>
                    <th class="col-md-3">글쓴이</th>
                    <th class="col-md-2">작성일</th>
                    <th class="col-md-1">조회수</th>
                </tr>
            </thead>
            <tbody>
               <c:forEach items="${list}" var="board">
               	<tr class="boardList">
               		<td>${board.getSeq_board()}</td>
               		<td><a href="${pageContext.request.contextPath}/toDetailView.bo?seq_board=${board.getSeq_board()}&currentPage=${naviMap.get('currentPage')}">${board.getTitle()}</a></td>
               		<td>${board.getWriter()}</td>
               		<td>${board.getWritten_date()}</td>
               		<td>${board.getView_count()}</td>
               	</tr>
               </c:forEach>
            </tbody>
        </table>
        <div class="row">
    <nav aria-label="Page navigation example">
  <ul class="pagination justify-content-center">
  
  
  	<c:if test="${naviMap.get('needPrev') eq true}">
  	   <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/toBoard.bo?currentPage=${naviMap.get('startNavi')-1}">Previous</a></li>
  	</c:if>
  	
  	<!-- startNavi~endNavi -->
  	<c:forEach var="i" begin="${naviMap.get('startNavi')}" end="${naviMap.get('endNavi')}">
  		<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/toBoard.bo?currentPage=${i}">${i}</a></li>
  	</c:forEach>
    
    
	<c:if test="${naviMap.get('needNext') eq true}">
		<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/toBoard.bo?currentPage=${naviMap.get('endNavi')+1}">Next</a></li>
	</c:if>
    
    
  </ul>
</nav>
    </div>
    </div>
    <div class="row p-4 btnBox">
        <div class="col">
            <button type="button" class="btn btn-outline-success" id="btnHome">홈으로</button>
        </div>
    </div>
</div>
<script>
	//로그아웃 버튼 누를시 로그아웃처리
	document.getElementById("btnLogout").addEventListener("click", function(){
		location.href="${pageContext.request.contextPath}/logoutProc.mem";
	})
	//글쓰기 버튼 누를 시 write.jsp로 이동
	document.getElementById("btnWrite").addEventListener("click", function(){
		location.href="${pageContext.request.contextPath}/toWrite.bo";
	})
	document.getElementById("btnHome").addEventListener("click", function(){
		location.href="${pageContext.request.contextPath}/";
	})
</script>
</body>
</html>