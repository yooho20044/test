package kh.com.board.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import kh.com.board.dao.BoardDAO;
import kh.com.board.dto.BoardDTO;

// request.response랑 직접 관련이 없는 
// 특정한 객체(board)와 관련된 비지니스 로직을 여기, Service 클래스에서 처리 
//Paging 
public class BoardService {
	private int recordCntPerPage = 10; //하나의 페이지에 보여질 데이터 수 
	private int naviCntPerPage = 10; //네비게이션 범위를 얼마나 잡아줄지 
	
	public HashMap<String, Object> getPageNavi(int currentPage){
		int recordTotalCnt =BoardDAO.getInstance().countAll();//전체데이터수
		
		int pageTotalCnt = 0; //총 몇페이지가 나올지?
		if(recordTotalCnt % recordCntPerPage > 0) {
			pageTotalCnt = (recordTotalCnt/recordCntPerPage) + 1;
		}else {
			pageTotalCnt = recordTotalCnt/recordCntPerPage;
		}
		
		if(currentPage < 1) {
			currentPage = 1;
		}else if(currentPage > pageTotalCnt) {
			currentPage = pageTotalCnt;
		}
		
		//시작네비페이지와 끝네비페이지 잡아주기 
		int startNavi = ((currentPage-1)/naviCntPerPage)*naviCntPerPage +1;
		int endNavi = startNavi + naviCntPerPage -1;
		
		if(endNavi > pageTotalCnt) {
			endNavi = pageTotalCnt;
		}
		
		boolean needPrev = true;
		boolean needNext = true;
		
		if(startNavi ==1) needPrev = false;
		else if(endNavi == pageTotalCnt) needNext = false;
		
		System.out.println("startNavi : " + startNavi);
		System.out.println("endNavi : " + endNavi);
		System.out.println("needPrev : " + needPrev);
		System.out.println("needNext : " + needNext);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("startNavi", startNavi);
		map.put("endNavi", endNavi);
		map.put("needPrev", needPrev);
		map.put("needNext", needNext);
		map.put("currentPage", currentPage);
		return map;
	}
	
	public List<BoardDTO> getBoardList(int currentPage){
		int startRange = currentPage * recordCntPerPage - (recordCntPerPage -1);
		int endRange = currentPage * recordCntPerPage;
		
		try {
		List<BoardDTO> list = BoardDAO.getInstance().getBoardList(startRange, endRange);
		
		for(BoardDTO dto : list) {
			System.out.println(dto.getSeq_board() + " : " + dto.getTitle() + " : " + dto.getWriter()
			 + " : " + dto.getWritten_date() + " : " + dto.getView_count());
		}return list;
	}catch(Exception e) {
		e.printStackTrace();
	}
		return null;
	}
}
