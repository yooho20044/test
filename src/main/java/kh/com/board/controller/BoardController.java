package kh.com.board.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kh.com.board.dao.BoardDAO;
import kh.com.board.dao.FileDAO;
import kh.com.board.dto.BoardDTO;
import kh.com.board.dto.MemberDTO;
import kh.com.board.service.BoardService;


/**
 * Servlet implementation class BoardController
 */
@WebServlet("*.bo")
public class BoardController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		actionDo(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		actionDo(request, response);
	}
	private void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		FileDAO fdao = FileDAO.getInstance();
		
		String uri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		String cmd = uri.substring(ctxPath.length());
		
		System.out.println("요청 url : " + cmd);
		
		if(cmd.equals("/toBoard.bo")) {
			int currentPage = Integer.parseInt(request.getParameter("currentPage"));
			System.out.println("currentPage : " + currentPage);
			BoardService service = new BoardService();
			HashMap<String, Object> naviMap =service.getPageNavi(currentPage);
			List<BoardDTO> list = service.getBoardList((int)naviMap.get("currentPage"));
			
			if(list != null) {
				request.setAttribute("naviMap", naviMap);
				request.setAttribute("list", list);
				RequestDispatcher rd = request.getRequestDispatcher("/board/board.jsp");
				rd.forward(request, response);
			}
		}else if(cmd.equals("/toWrite.bo")) {
			response.sendRedirect("/board/write.jsp");
		}else if(cmd.equals("/writeProc.bo")) {
	    	String id = ((MemberDTO)request.getSession().getAttribute("loginSession")).getId();
	    	String nickname= ((MemberDTO)request.getSession().getAttribute("loginSession")).getNickname();
			String filePath = request.getServletContext().getRealPath("files");
	    	System.out.println("filePath : " + filePath);
	    	
	    	int fileSize = 1024*1024*10;
	    	try {
	    		MultipartRequest multi = new MultipartRequest(request,filePath, fileSize, "utf-8", new DefaultFileRenamePolicy());
	    		String origin_name = multi.getOriginalFileName("file1");
	    		String system_name = multi.getOriginalFileName("file1");
	    		String title = multi.getParameter("title");
	    		String content = multi.getParameter("content");
	    		
		    	int rs = BoardDAO.getInstance().insert(new BoardDTO(0,title,content, nickname,id, null, 0));
		    
		    	if(rs != -1 && filePath !=null) {
		    		//response.sendRedirect("/fileUploadProc.fl?title="+title+"&content="+content
		    		//		+"&origin_name=" + origin_name + "&system_name=" + system_name);
		    		response.sendRedirect("/toBoard.bo?currentPage=1");
		    	}else {
		    		response.sendRedirect("/toBoard.bo?currentPage=1");
		    	}
	    		
	    	}catch(Exception e) {
	    		response.sendRedirect("error.jsp");
	    		/*
	    		 * 알수 없는 에러가 발생했습니다. 문제를 해결하려면 관리자에게 연락하세요.
	    		 * 
	    		 */
	    		e.printStackTrace();
	    	}
	    	
		}else if(cmd.equals("/toDetailView.bo")) {
			
			
			int seq_board = Integer.parseInt(request.getParameter("seq_board"));
			int currentPage = Integer.parseInt(request.getParameter("currentPage"));
			System.out.println(seq_board + ":" + currentPage);
			
			//조회수 +1작업
			//tbl_board 테이블에서 view_count 컬럼에 +1 수정
			BoardDAO.getInstance().updateView_count(seq_board);
			
	
			BoardDTO dto = BoardDAO.getInstance().selectBySeq(seq_board);
			
			//CommentDAO dao = CommentDAO.getInstance();
			//ArrayList<CommentDTO> list = Cdao.selectAll(seq_board);
			
			
			
			
			if(dto != null) {
				request.setAttribute("dto", dto);
				//request.setAttribute("commentList", list);
				request.setAttribute("currentPage", currentPage);
				RequestDispatcher rd = request.getRequestDispatcher("/board/detailView.jsp");
				rd.forward(request, response);
			}
				
		}else if(cmd.equals("/deleteProc.bo")){
			int seq_board = Integer.parseInt(request.getParameter("seq_board"));
			System.out.println(seq_board);
			
			int rs =BoardDAO.getInstance().deleteBySeq(seq_board);
			if(rs != -1) {
				response.sendRedirect("/toBoard.bo?currentPage=1");
			}
		}else if(cmd.equals("/modifyProc.bo")) {
			int seq_board = Integer.parseInt(request.getParameter("seq_board"));
			int currentPage = Integer.parseInt(request.getParameter("currentPage"));
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			System.out.println(title + " : " + seq_board + " : " + content);
			
			int rs = BoardDAO.getInstance().modifyBySeq(seq_board, title, content);
			
			if(rs !=-1) {
				response.sendRedirect("/toDetailView.bo?seq_board=" + seq_board+"&currentPage=" + currentPage);
			}
			
			
		}
	}
}
