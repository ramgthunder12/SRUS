package kr.co.srus.common;

import kr.co.srus.member.Member;

public interface CommonService {
	// 로그인
	public boolean login(Member member) throws Exception;

	// 로그아웃
	public void logout();
}