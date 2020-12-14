package kr.co.srus.authentication;

import kr.co.srus.member.Member;
import kr.co.srus.rentalbox.RentalBox;

public interface AuthenticationService {
	// 인증키 부여
	public boolean grantAuthInfo(Member member, RentalBox rentalBox) throws Exception;

	// 카드 UID 대조
	public boolean compareCardUID(RentalBox rentalBox) throws Exception;
}
