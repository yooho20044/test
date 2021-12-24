package kh.com.board.controller;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kh.com.board.dao.MemberDAO;
import kh.com.board.dto.MemberDTO;
import kh.com.board.utils.EncryptionUtils;

/**
 * Servlet implementation class MemberController
 */
@WebServlet("*.mem")
public class MemberController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request,response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		actionDo(request,response);
	}

	private void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String uri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = uri.substring(ctxPath.length());
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		
		System.out.println("요청 uri : " + cmd);
		
		if(cmd.equals("/toSignup.mem")) {
			response.sendRedirect("/member/signup.jsp");
		}else if(cmd.equals("/idCheckPopup.mem")) {
			response.sendRedirect("/member/idCheckPopup.jsp");
	    }else if(cmd.equals("/idCheckProc.mem")) {
	    	String idInput= request.getParameter("idInput");
	    	System.out.println("id값 : " + idInput);
	    	
	    	
	    	boolean rs = MemberDAO.getInstance().checkId(idInput);
	    	
	    	RequestDispatcher rd = request.getRequestDispatcher("/member/idCheckPopup.jsp");
	    	//클라이언트가 요청할 때 함께 보낸 idInput  
	    	//중복 검사 결과값
	    	request.setAttribute("idInput", idInput);
	    	if(rs) { //true라면
	    		request.setAttribute("rs", "unavailable");
	    	}else {  //false라면
	    		request.setAttribute("rs", "available");
	    	}
	    	rd.forward(request, response);
	    }else if(cmd.equals("/signupProc.mem")) {
	    	String id = request.getParameter("id");
	    	String password = request.getParameter("password");
	    	String nickname = request.getParameter("nickname");
	    	String phone = request.getParameter("phone");
	    	String address = request.getParameter("address");
	    	
	    	password = EncryptionUtils.getSHA512(password);
	    	
	    	//int rs = dao.insert(new MemberDTO(id,password,nickname,phone,address, System.currentTimeMillis()));
	    	int rs = MemberDAO.getInstance().insert(new MemberDTO(id,password,nickname,phone,address, System.currentTimeMillis()));
	    	if(rs != -1) {
	    		response.sendRedirect("/");
	    	}
	    }else if(cmd.equals("/loginProc.mem")) {
	    	String id = request.getParameter("id");
	    	String pw = request.getParameter("pw");
	    	
	    	System.out.println(id + ": " + pw);
	    	pw = EncryptionUtils.getSHA512(pw);
	    	
	    	try {
	    	MemberDTO dto = MemberDAO.getInstance().isLoginOK(id, pw);
	    	
	    	if(dto != null) { //로그인성공시
	    		System.out.println("로그인성공");
	    		request.getSession().setAttribute("loginSession", dto);
	    		response.sendRedirect("/");
	    	}else { //로그인실패시
	    		System.out.println("로그인실패");
	    		RequestDispatcher rd = request.getRequestDispatcher("/");
	    		request.setAttribute("rs", "fail");
	    		rd.forward(request, response);
	    	}
	    	}catch(Exception e) {
	    		e.printStackTrace();
	    		response.sendRedirect("/error.jsp");
	    	}
	    	
	    	
	    }else if(cmd.equals("/logoutProc.mem")) {//로그아웃 요청
	    	//로그아웃 -> session안에 있는 loginSession의 값을 비워주는것
	    	
	    	//1. session 저장소를 로그인 용으로만 사용할때
	    	//session.invalidate(); //무효화 -> 제거
	    	
	    	//2. session 이라는 저장소가 로그인했을 때와 관계없이 
	    	// 다른 값을 저장하는 용도로 사용할 때(장바구니)
	    	session.removeAttribute("loginSession");
	    	
	    	response.sendRedirect("/");
	    }else if(cmd.equals("/withdrawProc.mem")) {
	    	//현재 로그인된 사용자의 id값을 꺼냄
	    	String id = ((MemberDTO)request.getSession().getAttribute("loginSession")).getId();
	    	System.out.println("탈퇴할 id : " + id);
	    	
	    	int rs = MemberDAO.getInstance().deleteById(id);
	    	
	    	if(rs != -1) {
	    		session.invalidate();
	    		response.sendRedirect("/");
	    	}
	    }else if(cmd.equals("/toMyPage.mem")) {
	    	//현재 로그인된 사용자의 id값을 얻어옴
	    	String id = ((MemberDTO)request.getSession().getAttribute("loginSession")).getId();
	    	//id값을 이용해서 DB에서 사용자의 정보를 불러옴.
	    	MemberDTO dto= MemberDAO.getInstance().selectById(id);
	    	
	    	//그 정보를 마이페이지로 전달+이동
	    	if(dto != null) {
	    		RequestDispatcher rd = request.getRequestDispatcher("/member/myPage.jsp");
	    		request.setAttribute("dto", dto);
	    		rd.forward(request, response);
	    	}
	    	
	    }else if(cmd.equals("/modifyInfoProc.mem")) {
	    	String nickname = request.getParameter("nickname");
	    	String phone = request.getParameter("phone");
	    	String address = request.getParameter("address");
	    	String id = ((MemberDTO)request.getSession().getAttribute("loginSession")).getId();
	    	
	    	System.out.println(nickname + " : " + phone + " : " + address);
	    	
	    	int rs = MemberDAO.getInstance().modifyById(new MemberDTO(id,null,nickname,phone,address,0));
	    	
	    	if(rs != -1) {
	    		
	    		response.sendRedirect("toMyPage.mem");
	    	}
	    }
	}
}
