package controller;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Member;
import service.MemberService;

/**
 * Servlet implementation class MemberController
 */
@WebServlet({ "/", "/memJoinForm", "/memLoginForm", "/memJoin", "/memIdCheck", "/memLogin","/memLogout","/myInfo" })
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MemberController() {
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
		request.setCharacterEncoding("UTF-8");
		// 회원 관련 기능 SERVICE
		MemberService msvc = new MemberService();

		HttpSession session = request.getSession();
		System.out.println("url");
		switch (url) {
		case "/memIdCheck":
			System.out.println("아이디 중복 확인 요청");
			String checkId = request.getParameter("inputId");
			System.out.println("확인할 아이디 : " + checkId);
			// 2. 아이디 중복 확인 기능 호출
			String result = msvc.memberIdCheck(checkId);
			response.getWriter().print(result);
			break;

		case "/":
			System.out.println("메인페이지 이동요청");
			response.sendRedirect(path + "/Main.jsp");
			break;
		case "/memJoinForm":
			System.out.println("회원가입 페이지 이동 요청");
			response.sendRedirect(path + "/JoinForm.jsp");
			break;
		case "/memLoginForm":
			System.out.println("로그인 페이지 이동 요청");
			response.sendRedirect(path + "/LoginForm.jsp");
			break;
		case "/memJoin":
			System.out.println("회원가입 요청");
			// 1. 파라메터 확인
			String joinId = request.getParameter("joinId");
			System.out.println("입력한 아이디:" + joinId);

			Member joinMember = new Member();
			joinMember.setMid(joinId);
			joinMember.setMpw(request.getParameter("joinPw"));
			joinMember.setMname(request.getParameter("joinName"));
			joinMember.setMbirth(request.getParameter("joinBirth"));
			String postcode = request.getParameter("postcode");
			String address = request.getParameter("address");
			String detailAddress = request.getParameter("detailAddress");
			String extraAddress = request.getParameter("extraAddress");

			String maddr = postcode + "_" + address + "_" + detailAddress + "_" + extraAddress;
			joinMember.setMaddr(maddr);
			System.out.println(joinMember);
			// 2. 회원가입 처리 서비스 호출
			int joinService = msvc.joinService(joinMember);
			// 3. 회원가입결과 확인
			if (joinService > 0) {
				System.out.println("회원가입 성공");
				String joinMsg = "회원가입에 성공하였습니다.";
				String joinUrl = "main";
				response.sendRedirect(path + "/Success.jsp" + "?" + URLEncoder.encode("msg", "UTF-8") + "="
						+ URLEncoder.encode(joinMsg, "UTF-8") + "&" + URLEncoder.encode("url", "UTF-8") + "="
						+ URLEncoder.encode(joinUrl, "UTF-8"));
			} else {
				System.out.println("회원가입 실패");
				response.sendRedirect(
						path + "/Fail.jsp" + "?" + "msg" + "=" + URLEncoder.encode("회원가입에 실패했습니다.", "UTF-8"));
			}

			// 4. 회원가입 성공 >> "회원가입에 성공하였습니다."메인페이지로
			// 회원가입 실패 >> "회원가입에 실패하였습니다." 회원가입페이지로
			/*
			 * if(호출값 == 1) { System.out.println("회원가입에 성공하였습니다.");
			 * response.sendRedirect(path+"/Main.jsp"); }else {
			 * System.out.println("회원가입에 실패하였습니다.");
			 * response.sendRedirect(path+"/JoinForm.jsp"); }
			 */
			break;
		case "/memLogin":
			System.out.println("로그인 요청");
			String LoginId = request.getParameter("LoginId");
			String LoginPw = request.getParameter("LoginPw");
			System.out.println("입력한 아이디 : " + LoginId);
			System.out.println("입력한 비밀번호 : " + LoginPw);
			// 1. 아이디, 비밀번호 파라메터 확인

			// 2. SERVICE - 회원정보를 조회
			// SELECT * FROM MEMBERS WHERE MID = ? AND MPW = ?;
			Member memInfo = msvc.LoginMemCheck(LoginId, LoginPw);
			if (memInfo == null) {
				System.out.println("로그인 실패");
				response.sendRedirect(
						path + "/Fail.jsp" + "?" + "msg" + "=" + URLEncoder.encode("아이디/비밀번호가 일치하지 않습니다.", "UTF-8"));
			} else {
				System.out.println("로그인 성공");
				session.setAttribute("LoginMemberId", memInfo.getMid()); // 로그인 정보 담기

				response.sendRedirect(
						path + "/Success.jsp" + "?" + "msg" + "=" + URLEncoder.encode("로그인 성공", "UTF-8") +"&"+ URLEncoder.encode("url", "UTF-8") + "="
								+ URLEncoder.encode("/main", "UTF-8"));
				// 로그인 처리 - 세션
			}
			break;
		case "/memLogout":
			System.out.println("로그아웃 요청");
			session.removeAttribute("LoginMemberId");
			response.sendRedirect(path + "/Success.jsp" + "?msg=" + URLEncoder.encode("로그아웃 되었습니다.","UTF-8")
								+ "&url="+URLEncoder.encode("/main","UTF-8"));
			break;
		case "/myInfo":
			System.out.println("내 정보 확인 페이지 이동 요청");
			String infoId = (String)session.getAttribute("LoginMemberId");
			System.out.println(infoId);
			if(infoId == null) {
			/*	response.sendRedirect(path + "/Fail.jsp" 
			+ "?msg=" + URLEncoder.encode("로그인 후 이용가능합니다.","UTF-8"));*/
				response.sendRedirect(path + "/Success.jsp" 
			    + "?msg=" + URLEncoder.encode("로그인 후 이용가능합니다.","UTF-8")
				+ "&url="+URLEncoder.encode("/memLoginForm","UTF-8"));
			}else {
				Member memberInfo = msvc.memberInfo(infoId);
				System.out.println(memberInfo);
				request.setAttribute("mInfo", memberInfo);
				request.getRequestDispatcher("MyInfo.jsp").forward(request, response);
				//myInfo.jsp
			}
			//SERVICE - 회원 정보를 조회
			//SELECT * FROM MEMBERS WHERE MID = ?;
			
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
