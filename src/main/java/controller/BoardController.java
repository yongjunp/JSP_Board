package controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Board;
import service.BoardService;

/**
 * Servlet implementation class BoardController
 */
@WebServlet({ "/Board", "/BoardWriteForm", "/BoardWrite", "/BoardView", "/BoardDelete", "/BoardSearch" })
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public BoardController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		String url = request.getServletPath();
		String path = request.getContextPath();
		HttpSession session = request.getSession();

		BoardService bsvc = new BoardService();
		switch (url) {
		case "/BoardSearch":
			System.out.println("게시글 검색 요청");
			String searchTitle = request.getParameter("searchTitle");
			System.out.println("검색어 : " + searchTitle);
			/* select * from board where bstate = '1' and btitle like '%검색어%' */
			ArrayList<Board> searchBList = bsvc.getSearchBoard(searchTitle);
			request.setAttribute("bList", searchBList);
			request.getRequestDispatcher("BoardList.jsp").forward(request, response);
			break;
		case "/BoardDelete":
			System.out.println("글삭제 요청");
			int delBno = Integer.parseInt(request.getParameter("delBno")); // ""
			System.out.println("삭제할 글번호 : " + delBno);
			/* UPDATE BOARD SET BSTATE = '0' WHERE BNO = ? */
			int delResult = bsvc.boardDelete(delBno);
			if (delResult > 0) {
				System.out.println("삭제처리 성공");
				response.sendRedirect(
						path + "/Success.jsp" + "?msg=" + URLEncoder.encode(delBno + "번 글이 삭제 처리 되었습니다.", "UTF-8")
								+ "&url=" + URLEncoder.encode("/Board", "UTF-8"));
			} else {
				System.out.println("삭제처리 실패");
			}
			break;
		case "/BoardView":
			System.out.println("글 상세보기 페이지 이동 요청");
			int viewBno = Integer.parseInt(request.getParameter("viewBno"));
			System.out.println("상세보기 글번호 : " + viewBno);
			// 1. 상세보기 페이지에 출력할 글 조회
			// SELECT * FROM BOARDS WHERE BNO = ?;

			Board board2 = bsvc.getBoardView(viewBno); // bsvc.aaaa();
			request.setAttribute("Board", board2);
			System.out.println("보드" + board2.getBno());
			request.getRequestDispatcher("BoardView.jsp").forward(request, response);
			break;

		case "/Board":
			System.out.println("게시판 이동 요청");
			// 1. Board 게시글 목록 조회
			// SELECT * FROM BOARDS WHERE BSTATE = '1';
			// ArrayList<Board> bList = bsvc.getBoardList();
			// request.setAttribute("bList",bList);
			ArrayList<Board> bList = bsvc.getBoardList();
			request.setAttribute("bList", bList);

			request.getRequestDispatcher("BoardList.jsp").forward(request, response);
			break;
		case "/BoardWriteForm":
			System.out.println("게시판 글작성 요청");

			response.sendRedirect("BoardWriteForm.jsp");
			break;
		case "/BoardWrite":
			System.out.println("글 등록 요청");
			String bwriter = (String) request.getSession().getAttribute("LoginMemberId");
			if (bwriter == null) {
				response.sendRedirect(path + "/Success.jsp" + "?msg=" + URLEncoder.encode("로그인 후 이용가능합니다.", "UTF-8")
						+ "&url=" + URLEncoder.encode("/memLoginForm", "UTF-8"));
			} else {
				String btitle = request.getParameter("btitle");
				String bcontents = request.getParameter("bcontents");
				System.out.println("글제목 : " + btitle);
				System.out.println("글내용 : " + bcontents);
				Board board = new Board();
				board.setBtitle(btitle);
				board.setBcontents(bcontents);
				board.setBwriter(bwriter);
				// 2. service 글 등록 기능 호출
				int writeResult = bsvc.boardWrite(board);
				// 3. 등록 결과 확인 및 응답
				if (writeResult > 0) {
					System.out.println("글 등록 성공");
					// BoardList.jsp 게시판페이지
					response.sendRedirect(path + "/Success.jsp" + "?msg=" + URLEncoder.encode("새 글이 등록되었습니다.", "UTF-8")
							+ "&url=" + URLEncoder.encode("BoardList.jsp", "UTF-8"));
				} else {
					System.out.println("글 등록 실패");
					// BoardWriteForm.jsp 글작성 페이지
					response.sendRedirect(path + "/Fail.jsp" + "?msg=" + URLEncoder.encode("글 등록에 실패하였습니다..", "UTF-8"));
				}
			}
			// 1. 파라메터 - 글제목, 글내용 확인
			break;
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
