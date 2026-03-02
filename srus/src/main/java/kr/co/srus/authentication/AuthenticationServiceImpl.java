package kr.co.srus.authentication;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.srus.member.Member;
import kr.co.srus.member.MemberMapper;
import kr.co.srus.rentalbox.RentalBox;
import kr.co.srus.rentalbox.RentalBoxMapper;

@Service
public class AuthenticationServiceImpl implements AuthenticationService {
	@Autowired
	private MemberMapper memberMapper;
	@Autowired
	private RentalBoxMapper rentalBoxMapper;

	// 인증키 부여
	@Override
	public boolean grantAuthInfo(Member member, RentalBox rentalBox) throws Exception {
		boolean result = false;

		Member row = memberMapper.select(member);

		if (row.getCardUid() != null && !row.getCardUid().isEmpty()) {
			rentalBox.setAuthKey(row.getCardUid());
			rentalBox.setAuthIssueDate(LocalDateTime.now());

			rentalBoxMapper.update(rentalBox);

			result = true;
		}

		return result;
	}

	// 카드UID 대조
	@Override
	public boolean compareCardUID(RentalBox rentalBox) throws Exception {
		boolean isMatched = false;
		
		RentalBox row = rentalBoxMapper.select(rentalBox);

		if (row != null && row.getAuthKey() != null) {
			LocalDateTime authIssueDate = row.getAuthIssueDate().plusMinutes(1);
			
			if (LocalDateTime.now().isAfter(authIssueDate)) {
				row.setAuthIssueDate(null);
				row.setAuthKey(null);
				
				rentalBoxMapper.updateAuth(row);
			} else {
				isMatched = true;
			}
		}

		return isMatched;
	}
}
