package kr.co.srus.common;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.srus.member.Member;
import kr.co.srus.member.MemberMapper;

@Service
public class CommonServiceImpl implements CommonService {
	@Autowired
	private MemberMapper memberMapper;
	@Autowired
	private HttpSession session;

	// 로그인
	@Override
	@Transactional(readOnly = true)
	public boolean login(Member member) throws Exception {
		boolean isLogin = false;
		
		Member row = memberMapper.select(member);

		if (row != null && row.getWithdrawalDate() == null) {
			isLogin = true;
		}
		
		return isLogin;
	}

	// 로구아웃
	@Override
	public void logout() {
		session.invalidate();
	}
}