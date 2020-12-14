package kr.co.srus.member;

import java.util.List;

public interface MemberService {
	// 아이디 찾기
	public List<Member> findId(Member member) throws Exception;

	// 비밀번호 찾기
	public Member findPassword(Member member) throws Exception;

	// 핸드폰 번호 대조
	public boolean comparePhoneNumber(Member member) throws Exception;

	// 사용자 정보 등록
	public void registerMemberInfo(Member member) throws Exception;

	// 사용자 정보 목록 조회
	public List<Member> searchMemberInfoList(Member member) throws Exception;

	// 사용자 정보 조회
	public Member searchMemberInfo(Member member) throws Exception;

	// 사용자 정보 수정
	public void modifyMemberInfo(Member member) throws Exception;

	// 카드 정보 수정
	public boolean cardMemberInfo(Member member) throws Exception;
}
