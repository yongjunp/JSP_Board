package service;

import dao.MemberDao;
import dto.Member;

public class MemberService {
	
	MemberDao mdao = new MemberDao();
	//아이디 중복 확인 기능
	public String memberIdCheck(String checkId) {
		System.out.println("service - memberIdCheck() 호출");
		String checkResult ="Y";// Y이면 사용가능 N이면 사용 불가능
		//SELECT * FROM MEMBERS WHERE MID=?
		Member mem = mdao.selectMemberInfo(checkId);
		if(mem != null) {
			checkResult = "N";
		}else {
			checkResult = "Y";
		}
		return checkResult;
	}
	public int joinService(Member joinMember) {
		System.out.println("service - joinService() 호출");
		int joinResult = mdao.insertMemberInfo(joinMember);
		return joinResult;
	}
	//로그인 서비스
	public Member LoginMemCheck(String LoginId,String LoginPw) {
		System.out.println("service - LoginMemCheck");
		Member memInfo = mdao.LoginCheckInfo(LoginId,LoginPw);
		return memInfo;
	}
	public Member memberInfo(String infoId) {
		System.out.println("service - memberInfo() 호출");
		Member infomem = mdao.LoginMemberInfo(infoId);
		/*1.
		SELECT MID,MPW,MNAME,TO_CHAR(BIRTH,'YYYY-MM-DD',MADDR
		FROM MEMBERS WHERE MID = ?;
*/		
		//생년월일 일(DAY)까지만 쓰는 구문
		String birthDate = infomem.getMbirth().split(" ")[0];	
		infomem.setMbirth(birthDate);
		
		return infomem;
	}
}
