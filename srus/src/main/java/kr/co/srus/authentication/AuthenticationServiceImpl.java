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
	private static final long AUTH_VALIDITY_MINUTES = 1;
	private static final long AUTH_GRACE_PERIOD_SECONDS = 5;

	@Autowired
	private MemberMapper memberMapper;
	@Autowired
	private RentalBoxMapper rentalBoxMapper;

	// 인증키 부여
	@Override
	public synchronized boolean grantAuthInfo(Member member, RentalBox rentalBox) throws Exception {
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
	public synchronized boolean compareCardUID(RentalBox rentalBox) throws Exception {
		boolean isMatched = false;
		
		RentalBox row = rentalBoxMapper.select(rentalBox);

		if (row != null && row.getAuthKey() != null) {
			LocalDateTime now = LocalDateTime.now();
			LocalDateTime authExpiryDate = row.getAuthIssueDate().plusMinutes(AUTH_VALIDITY_MINUTES);
			LocalDateTime graceExpiryDate = authExpiryDate.plusSeconds(AUTH_GRACE_PERIOD_SECONDS);
			
			if (!now.isAfter(authExpiryDate)) {
				isMatched = true;
			} else if (!now.isAfter(graceExpiryDate)) {
				isMatched = true;

				row.setAuthIssueDate(null);
				row.setAuthKey(null);
				rentalBoxMapper.updateAuth(row);
			} else {
				row.setAuthIssueDate(null);
				row.setAuthKey(null);
				rentalBoxMapper.updateAuth(row);
			}
		}

		return isMatched;
	}
}
