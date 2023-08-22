package service;

import java.util.ArrayList;

import dao.BoardDao;
import dto.Board;


public class BoardService {
	
	BoardDao bdao = new BoardDao();
	
	public int boardWrite(Board board) {
		System.out.println("SERVICE - boardWrite() 호출");
		//board - 글제목, 글내용, 글작성자
		//1. 새 글번호 생성
		/*현재 등록된 글 번호의 최대값 + 1
		 * 글번호의 최대값 조회 : SELECT MAX(BNO) FROM BOARDS;
		 * 글번호의 최대값 조회 : SELECT NVL(MAX(BNO),0) FROM MEMBERS;
		 * */
		int bno = bdao.selectMaxBno()+1;
		board.setBno(bno); //board - 글번호, 글제목, 글내용, 글작성자
		//2. DAO - INSERT INTO BOARDS VALUES(?,?,?,?,0,'1') 호출
		int result = bdao.insertBoard(board);
		
		return result;
	}

	public ArrayList<Board> getBoardList() {
		System.out.println("SERVICE - getBoardList() 호출");
		ArrayList<Board> BoardResult = bdao.selectBoardList();
		
		return BoardResult;
	}

	public Board getBoardView(int viewBno) {
		System.out.println("SERVICE - getBoardView() 호출");
		bdao.updateBoardHits(viewBno);
		Board getBoardView = bdao.getBoard(viewBno);
		//dao - UPDATE BOARDS SET BHITS = BHITS + 1 WHERE BNO = ?;
		
		/*
		String bcontents = getBoardView.getBcontents();
		bcontents = bcontents.replace("/r/n","<br>").replace(" ","&nbsp;");
		getBoardView.setBcontents(bcontents
		*/
		return getBoardView;
	}

	public int boardDelete(int delBno) {
		System.out.println("SERVICE - boardDelete() 호출");
		int result = bdao.updateBstate(delBno, "0");
		return result;
	}
	
	public int boardDeleteCancle(int delBno) {
		System.out.println("SERVICE - boardDelete() 호출");
		int result = bdao.updateBstate(delBno, "1");
		return result;
	}

	public ArrayList<Board> getSearchBoard(String searchTitle) {
		System.out.println("SERVICE - getSearchBoard() 호출");
		ArrayList<Board> boardList = bdao.searchBoardSearch(searchTitle);
		return boardList;
	}

}
