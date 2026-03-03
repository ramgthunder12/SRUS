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
	// 인증 유효 시간 (분)
	private static final long AUTH_VALIDITY_MINUTES = 1;
	// 카드 찍힘과 인증 만료가 거의 동시에 발생하는 경우를 위한 유예 기간 (초)
	private static final long AUTH_GRACE_PERIOD_SECONDS = 5;

	@Autowired
	private MemberMapper memberMapper;
	@Autowired
	private RentalBoxMapper rentalBoxMapper;

	// 인증키 부여 (동시 접근 방지를 위해 동기화 처리)
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

	// 카드UID 대조 (동시 접근 방지를 위해 동기화 처리)
	// 카드 찍힘과 인증 만료가 동시에 발생할 경우를 대비하여
	// 유효 시간 이후에도 유예 기간 내에는 인증을 허용하고 인증 정보를 초기화함
	@Override
	public synchronized boolean compareCardUID(RentalBox rentalBox) throws Exception {
		boolean isMatched = false;
		
		RentalBox row = rentalBoxMapper.select(rentalBox);

		if (row != null && row.getAuthKey() != null
				&& row.getAuthKey().equals(rentalBox.getAuthKey())) {
			LocalDateTime now = LocalDateTime.now();
			LocalDateTime authExpiryDate = row.getAuthIssueDate().plusMinutes(AUTH_VALIDITY_MINUTES);
			LocalDateTime graceExpiryDate = authExpiryDate.plusSeconds(AUTH_GRACE_PERIOD_SECONDS);
			
			if (now.isBefore(authExpiryDate) || now.isEqual(authExpiryDate)) {
				// 유효 시간 이내: 인증 성공
				isMatched = true;
			} else if (now.isBefore(graceExpiryDate) || now.isEqual(graceExpiryDate)) {
				// 유예 기간 이내: 인증 성공 후 인증 정보 초기화 (재사용 방지)
				isMatched = true;

				row.setAuthIssueDate(null);
				row.setAuthKey(null);
				rentalBoxMapper.updateAuth(row);
			} else {
				// 유예 기간 초과: 인증 실패 및 인증 정보 초기화
				row.setAuthIssueDate(null);
				row.setAuthKey(null);
				rentalBoxMapper.updateAuth(row);
			}
		}

		return isMatched;
	}
}
