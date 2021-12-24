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
            margin: auto;
            width:700px;
            text-align: center;
        }
        .btnUpBox{
          text-align: right; 
        }
        #tblBoard{
            width: 100%;
        }
        .boxContent{
            height:50px;
        }
        .btnDown{
            margin-left:40px;
            <!--display:none;-->
        }
        #btnBack{
        	margin-left:40px;
        }
         .hideBox{
            display:none;
        }
        #content{
        	resize :none;
        	 height: 400px;
        }
		#after-box{
			display:none;
		}
		 .reContainer{
            margin: auto;
            
            border-bottom: 4px solid black;
            width:700px;
            margin-top: 20px;
        }
        .replyBox{
            margin-top: 20px;
            border: 1px solid gainsboro;
            width:650px;
            margin-left:10px;
        }
        .conBox{
            width:100%;
            margin:0;
        }
        #cont{
            width:100%;
            font-size: large;
            border:0px;
            background-color: transparent;
            resize:none;
        }
        .btnBox{
            text-align: right;
            display:flex;
           margin-left: 500px;  
           margin-bottom: 10px;
        }
        .btnBox>div>a{
            color:black;
            text-decoration: none;
        }
        .btnMargin{
            margin-left: 10px;
            margin-right: 30px; 
        }
        .writerBox>p{
            font-size: small;
            font-weight: 600;
            padding-top:5px;
            margin-bottom: 0;
            margin-left: 5px;
        }
        .textBox{
            margin-top:10px;
            width:650px;
            margin-left:10px;
            margin-bottom:10px;
            border: 1px solid gainsboro;
        }
        #contentText{
            width:500px;
            resize: none;
            border:0;
        }
        #btnReplyGo{
            margin-left:20px;
            margin-top:10px;
        }
    </style>
</head>
<body>

<form action="${pageContext.request.contextPath}/modifyProc.bo" method="post" id="modifyForm">
<div class="container">
        <div class="row p-4 btnUpBox">
            <div class="col">
                <button type="button" class="btn btn-outline-danger" id="btnLogout">로그아웃</button>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <h2>상세 글 조회</h2>
            </div>
        </div>
        <div class="row">
            <table class="table-bordered" id="tblBoard">
                <tbody>
                    <tr class="boxContent">
                        <td>제목</td>
                        <td colspan="5">
                        	<input type="text" class="form-control whiteBox" id="title" name="title" style="background-color:transparent;border:none;" value="${dto.getTitle() }" readonly>
                        </td>
                    </tr>
                    <tr class="boxContent">
                        <td class="col-md-1">글쓴이</td>
                        <td class="col-md-3">
                        <input type="text" class="form-control" id="writer" name="writer" style="background-color:transparent;border:none;" value="${dto.getWriter()}" readonly>
                        </td>
                        <td class="col-md-1">날짜</td>
                        <td class="col-md-3">
                        <input type="text" class="form-control" id="written_date" name="written_date" style="background-color:transparent;border:none;" value="${dto.getWritten_date()}" readonly>
                        </td>
                        <td class="col-md-1">조회수</td>
                        <td class="col-md-3">
                        <input type="text" class="form-control" id="view_count" name="view_count" style="background-color:transparent;border:none;" value="${dto.getView_count()}" readonly>
                        </td>
                    </tr>
                    <tr id="boxContent">
                        <td>내용</td>
                        <td colspan="5">
                        <textarea class="form-control" id="content" name="content" style="background-color:transparent;border:none;" readonly>${dto.getContent()}</textarea>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
      
        <div class="hideBox">
        	<input type="text" name="currentPage" value="${currentPage}">
        	<input type="text" class="form-control" id="seq_board" name="seq_board" value="${dto.getSeq_board()}">
        </div>
        
        <div class="row p-2" id="before-box">
            <div class="col">
				<button type="button" class="btn btn-outline-secondary" id="btnBack">뒤로가기</button>
			</div>
			<c:if test="${loginSession.id eq dto.getWriter_id()}">
			<div class="col">
                <button type="button" class="btn btn-outline-warning btnDown" id="btnModify">수정</button>
            </div>
            <div class="col">
                <button type="button" class="btn btn-outline-danger btnDown" id="btnDelete">삭제</button>
            </div>
            <script>
            //삭제버튼 -> 삭제처리
        	document.getElementById("btnDelete").addEventListener("click", function(){
        		let rs = confirm("정말 삭제하시겠습니까?");
        		if(rs){
        			location.href="${pageContext.request.contextPath}/deleteProc.bo?seq_board=${dto.getSeq_board()}";
        		}
        	     
        	})
        	
        	document.getElementById("btnModify").addEventListener("click",function(){
        		 document.getElementById("title").readOnly = false;
        		 document.getElementById("content").readOnly = false;
        		 document.getElementById("before-box").style.display = 'none';
        		 document.getElementById("after-box").style.display = 'flex';
        	 })
        	
            </script>
            </c:if>
        </div>
        <div class="row p-2" id="after-box">
        	<div class="col">
        		<button type="button" class="btn btn-outline-secondary btnDown" id="btnCancel">취소</button>
        	</div>
        	<div class="col">
        		<button type="button" class="btn btn-outline-primary btnDown" id="btnGo">완료</button>
        	</div>
        </div>
    </div>
    </div>
</form>

  <!-- 댓글창 -->
  
     <div class="reContainer">
     	<div class="cmt-showBox">
     	
     	</div>
     	<div class="cmt-textBox">
     	<form method="post" id="replyForm">
         <div class="row textBox">
            <div class="col">
                <textarea id="contentText" name="contentText" placeholder="댓글 입력"></textarea>
            </div>
            <div class="col">
                <button type="button" class="btn btn-primary" id="btnReplyGo">등록</button>
            </div>    
            <input type="text" class="form-control" id="seq_board" name="seq_board" style="display:none;" value="${dto.getSeq_board()}" >  
            <input type="text" name="currentPage" value="${currentPage}" style="display:none;">
        </div>
        </form> 
     	</div>
      
    <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <script>
   
    $(document).ready(function(){
    	getCommentList();
    })
    
     //replyForm /btnReplyGo
     	$("#btnReplyGo").on("click",function(){
     		let data = $("#replyForm").serialize();
     		$("#contentText").val("");
     		
     		
     		$.ajax({
     			url:"${pageContext.request.contextPath}/insertProc.co",
     			type:"post",
     			data:data
     		}).done(function(rs){
     			if(rs == "success"){
     				getCommentList();
     			}else if(rs=="fail"){
     				alert("댓글 등록에 실패했습니다.");
     			}
     		}).done(function(e){
     			console.log(e);
     		})
     	});
    
    function getCommentList(){
    	
    	$.ajax({
    		type : "get",
    		url : "${pageContext.request.contextPath}/getCommentProc.co?seq_board=${dto.getSeq_board()}",
    	    dataType : "json"
    	}).done(function(data){

			$(".cmt-showBox").empty();
    		
    		for(let dto of data){
    			let comment = "<div class='replyBox'>"
    				+"<div class='row writerBox'>"
    				+"<p id='writer'>"
    				+ dto.writer
    				+"</p>"
    				+"<p>"
    				+ dto.written_date
    				+"</p>"
    				+"</div>"
    				+"<div class='row conBox'>"
    				+"<textarea class='form-control' id= 'cont' name='cont' value='" + dto.seq_comment + "'readonly>"
    				+ dto.content
    				+"</textarea>"
    				+"</div>"
    				+"<div class='row btnBox'>"
    				+"</div>"
    				+"</div>"
    				$(".cmt-showBox").append(comment);
    				
    				//수정 삭제 버튼 영역
    				if("${loginSession.id}" == dto.writer_id){
    					let btns = 
    					"<div class='col'>"
    					+"<button type='button' class='btn btn-outline-warning' id='reModifyBtn' value='" + dto.seq_comment + "'>수정</button> "
    					+"<button type='button' class='btn btn-outline-primary' id='reGoBtn' value='" + dto.seq_comment + "' hidden>완료</button> "
    					+"</div>"
    					+"<div class='col btnMargin'>"
    					+"<button type='button' class='btn btn-outline-danger' id='reDeleteBtn' value='" + dto.seq_comment + "'>삭제</button> "
    					+"</div>"
    					+"</div>";
    					
    					$(".btnBox:last").append(btns);
    				}
   
    		}
    		
    		
    	}).fail(function(e){
    		console.log(e);
    	});
    }
    //댓글수정시 div창 수정가능하게
    $(document).on('click', '#reModifyBtn', function(){
    	var index = $(this).val();
    	$(this).css("display","none")
    	$(this).next().attr("hidden",false);
    	$("textarea[value='"+index+"']").attr("readonly",false);
    })
    //댓글 수정하고 버튼 클릭시 수정 
    $(document).on('click', '#reGoBtn', function(){
         let data =  $("#replyForm").serialize();
         let value = $(this).val();
         console.log(value);
         let content = $("textarea[value='"+value+"']").val();
         console.log(content);
         
         $.ajax({
            url : "${pageContext.request.contextPath}/modifyProc.co?comment_no="+value+"&comment_content=" + content
            ,type : "post"
            ,data : data
         }).done(function(rs){
            getCommentList();
         }).fail(function(e){
            console.log(e);
         }); 
         
      })
  //댓글삭제버튼 클릭시 댓글삭제
	$(document).on('click', '#reDeleteBtn', function(){
		let data = $("#replyForm").serialize();
		let value = $(this).val();
		
		$.ajax({
			// aJax 댓글 삭제
			url : "${pageContext.request.contextPath}/deleteProc.co?comment_no="+value
			, type : "post"
			, data : data				
		}).done(function(rs){
			if(rs == "success"){
				getCommentList();// 댓글 삭제에 성공하면 댓글 리스트 리로드
			}else if(rs == "fail"){
				alert("댓글 삭제에 실패했습니다."); // 댓글 삭제에 실패하면 alert 
			}				
		}).fail(function(e){
			console.log(e);
		});
	})
    
    //뒤로가기버튼 -> board화면 이동
    document.getElementById("btnBack").addEventListener("click", function(){
    	location.href="${pagecontext.request.contextPath}/toBoard.bo?currentPage=${currentPage}"
   	     })
     //로그아웃버튼 -> 로그아웃처리 
     document.getElementById("btnLogout").addEventListener("click", function(){
		location.href="${pageContext.request.contextPath}/logoutProc.mem";
	})
	
	document.getElementById("btnCancel").addEventListener("click",function(){
        		 location.href="${pageContext.request.contextPath}/toDetailView.bo?seq_board=${dto.getSeq_board()}&currentPage=${currentPage}"
        	 })
        	 
        	 document.getElementById("btnGo").addEventListener("click",function(){
        		 if(document.getElementById("title").value == "" || document.getElementById("content").value == ""){
        			alert("타이틀 혹은 내용을 입력하세요.")
        		 }else{
        			 document.getElementById("modifyForm").submit();
        		 }
        		 
        	 })
   
    </script>
    
</body>
</html>