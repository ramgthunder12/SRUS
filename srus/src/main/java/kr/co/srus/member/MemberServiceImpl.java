package kr.co.srus.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberMapper memberMapper;

	// 아이디 찾기
	@Override
	public List<Member> findId(Member member) throws Exception {
		List<Member> rows = memberMapper.selectAll(member);
		
		if (rows != null) {
			for (Member row : rows) {
				char[] id = row.getId().toCharArray();

				for (int i = 0; i < id.length; i++) {
					if (i > 2) {
						id[i] = '*';
					}
				}
				row.setId(new String(id));
			}
		}

		return rows;
	}

	// 비밀번호 찾기
	@Override
	public Member findPassword(Member member) throws Exception {
		Member row = memberMapper.select(member);

		if (row != null) {
			char[] password = row.getPassword().toCharArray();

			for (int i = 0; i < password.length; i++) {
				if (i > 2) {
					password[i] = '*';
				}
			}
			row.setPassword(new String(password));
		}

		return row;
	}

	// 핸드폰 번호 대조
	public boolean comparePhoneNumber(Member member) throws Exception {
		boolean result = false;
		Member row = memberMapper.select(member);
		
		if (row != null) {
			result = true;
		}

		return result;
	}

	// 사용자 정보 등록
	@Override
	public void registerMemberInfo(Member member) throws Exception {
		Member memberInfo = new Member();
		memberInfo.setId(member.getId());
		
		Member row = memberMapper.select(memberInfo);

		if (row == null) {
			memberMapper.insert(member);
		}
	}

	// 회원 목록 조회
	@Override
	public List<Member> searchMemberInfoList(Member member) throws Exception {
		
		return memberMapper.selectAllById(member);
	}

	// 사용자 정보 조회
	@Override
	public Member searchMemberInfo(Member member) throws Exception {
		Member row = memberMapper.select(member);
		
		return row;
	}

	// 회원 정보 수정
	@Override
	public void modifyMemberInfo(Member member) throws Exception {
		memberMapper.update(member);
	}

	// 카드 정보 수정
	@Override
	public boolean cardMemberInfo(Member member) throws Exception {
		if (member.getCardUid() != null && !member.getCardUid().isEmpty()) {
			memberMapper.update(member);
			
			return true;
		} else {
			
			return false;
		}
	}
}
