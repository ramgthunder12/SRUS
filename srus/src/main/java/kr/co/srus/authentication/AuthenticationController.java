package kr.co.srus.authentication;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.co.srus.member.Member;
import kr.co.srus.rentalbox.RentalBox;

@RestController
@RequestMapping("/authentication")
public class AuthenticationController {
	@Autowired
	private AuthenticationServiceImpl authenticationServiceImpl;

	// 인증키 부여
	@GetMapping("/grantauthinfo")
	public ResponseEntity<Map<String, Boolean>> grantAuthInfo(Member member, RentalBox rentalBox) {
		Map<String, Boolean> responseBody = null;

		try {
			responseBody = new HashMap<String, Boolean>();
			responseBody.put("result", authenticationServiceImpl.grantAuthInfo(member, rentalBox));
		} catch (Exception e) {
			e.printStackTrace();
		}

		return ResponseEntity.ok(responseBody);
	}

	// 카드UID 대조
	@GetMapping("/comparecarduid")
	public ResponseEntity<Map<String, Boolean>> compareCardUID(RentalBox rentalBox) {
		Map<String, Boolean> responseBody = null;
		
		try {
			responseBody = new HashMap<String, Boolean>();
			responseBody.put("result", authenticationServiceImpl.compareCardUID(rentalBox));
		} catch (Exception e) {
			e.printStackTrace();
		}

		return ResponseEntity.ok(responseBody);
	}
}
