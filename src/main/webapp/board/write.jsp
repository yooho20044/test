<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<style>
    .container{
        width:900px;
        margin:auto;
        text-align: center;
    }
    .inputBox{
        width:100%;
    }
    #content{
    	width:100%;
    	height:500px;
    	resize:none;
    }
</style>
</head>
<body>
    <form id = "boardForm" action="${pageContext.request.contextPath}/writeProc.bo" method="post"
    enctype="multipart/form-data">
        <div class="container">
            <div class="row p-4">
                <div class="col">
                    <h2>글쓰기</h2>
                </div>
            </div>
            <div class="row">
                <table class="table table-bordered">
                    <tbody>
                        <tr>
                            <td>제목</td>
                            <td>
                                <input type="text" class="inputBox" id="title" name="title">
                            </td>
                        </tr>
                        <tr>
                            <td>파일첨부</td>
                            <td>
                                <div class="input-group mb-3">
                                    <div class="custom-file">
                                      <input type="file" class="custom-file-input" name="file1" id="inputGroupFile01" aria-describedby="inputGroupFileAddon01">
                                      <label class="custom-file-label" for="inputGroupFile01">Choose file</label>
                                    </div>
                                  </div>
                            </td>
                        </tr>
                        <tr>
                            <td>내용</td>
                            <td>
                                <textarea id="content" name="content" placeholder="내용을 입력하세요."></textarea>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="row">
                <div class="col">
                    <button type="button" class="btn btn-outline-secondary" id="btnBack">뒤로가기</button>
                    <button type="button" class="btn btn-outline-primary" id="btnSave">저장</button>
                </div>
            </div>
        </div>
    </form>
    <script>
    	document.getElementById("btnBack").addEventListener("click", function(){
    		location.href="${pageContext.request.contextPath}/toBoard.bo?currentPage=1";
    	})
    	document.getElementById("btnSave").addEventListener("click", function(){
    		if(document.getElementById("title").value == ""|| document.getElementById("content").value ==""){
    			alert("제목 혹은 내용을 입력하세요.");
    			return;
    		}
    		document.getElementById("boardForm").submit();
    	})
    </script>
</body>
</html>