package kh.com.board.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import kh.com.board.dao.CommentDAO;
import kh.com.board.dto.CommentDTO;
import kh.com.board.dto.MemberDTO;

/**
 * Servlet implementation class CommentController
 */
@WebServlet("*.co")
public class CommentController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		actionDo(request, response);
	}

	public void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		
		String uri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = uri.substring(ctxPath.length());
		
		System.out.println("요청 url : " + cmd);
		
		if(cmd.equals("/insertProc.co")) {
			String content = request.getParameter("contentText");
			int seq_board = Integer.parseInt(request.getParameter("seq_board"));
			String id = ((MemberDTO)request.getSession().getAttribute("loginSession")).getId();
			String nickname = ((MemberDTO)request.getSession().getAttribute("loginSession")).getNickname();
			int currentPage = Integer.parseInt(request.getParameter("currentPage"));
			
			System.out.println(seq_board + " : " + content + " : " + nickname + " : " + id);
			System.out.println(currentPage);
			int rs = CommentDAO.getInstance().insert(new CommentDTO(0,seq_board,content,nickname,id,null));
			
			if(rs == 1 ) {
				response.getWriter().write("success");
			}else {
				response.getWriter().write("fail");
			}
		}else if(cmd.equals("/getCommentProc.co")) {
			System.out.println("요청 도착");
			int seq_board = Integer.parseInt(request.getParameter("seq_board"));
			System.out.println(seq_board);
			
			List<CommentDTO> list = CommentDAO.getInstance().getCommentList(seq_board);
			//list를 json형식으로 변환
			Gson gson = new Gson();
			String rs = gson.toJson(list);
			System.out.println(rs);
			if(list != null) {
				response.getWriter().write(rs);
			}else {
				response.getWriter().write("fail");
			}
		}else if(cmd.equals("/deleteProc.co")) {
			System.out.println("요청도착");
			int comment_no = Integer.parseInt(request.getParameter("comment_no"));
			
			try {
				int rs = CommentDAO.getInstance().deleteBySeq(comment_no);
				
				if(rs != -1) {
					response.getWriter().write("success");
				}else {
					response.getWriter().write("fail");
				}
			}catch(Exception e) {
				e.printStackTrace();
				response.sendRedirect("/error.jsp");
			}
		}else if(cmd.equals("/modifyProc.co")) {
			System.out.println("요청 도착");
			int comment_no = Integer.parseInt(request.getParameter("comment_no"));
			String comment_content = request.getParameter("comment_content");
			System.out.println(comment_no + " : " + comment_content);
			
			try {
			int rs = CommentDAO.getInstance().modifyBySeq(comment_no, comment_content);
			
			if(rs != -1) {
				response.getWriter().write("success");
			}else {
				response.getWriter().write("fail");
			}
			}catch(Exception e) {
				e.printStackTrace();
				response.sendRedirect("/error.jsp");
			}
		}
	}
}
