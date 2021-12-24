package kh.com.board.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kh.com.board.dao.CommentDAO;
import kh.com.board.dto.CommentDTO;

@WebServlet("*.temp")
public class TempController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		actionDo(request, response);
	}
	public void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		String uri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = uri.substring(ctxPath.length());
		
		System.out.println("요청 url : " + cmd);
		
		if(cmd.equals("/request1.temp")){
			System.out.println("요청 도착");
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			System.out.println("id : " + id);
			System.out.println("pw : " + pw);
		}
		else if(cmd.equals("/request3.temp")) {
			System.out.println("요청 도착");
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			System.out.println(id + " : " + pw);
			
			//응답값 세팅 
			response.setContentType("html/text; charset=utf-8");
			PrintWriter out = response.getWriter();
//			out.write("Hello");
//			out.write("Hi");
//			out.write("한글 결과");
			CommentDAO dao = CommentDAO.getInstance();
			List<CommentDTO> list = CommentDAO.getInstance().getCommentList(106);
			/*
			 * json (javaScript Object Notation)
			 *  : 데이터 구조 {key : value} 
			 *  단일 데이터를 주고 받을때 외에, 즉 다량의 데이터를 주고 받을 때(list,array)
			 *  사용하는 데이터 구조, 많은 API, 서버 클라이언트 통신할 때 사용.
			 */
			Gson gson = new Gson();
			String rs = gson.toJson(list);
			System.out.println("rs :" + rs);
			out.write(rs);
			
			
		}
	}
}
