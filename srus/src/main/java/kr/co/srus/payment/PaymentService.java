package kr.co.srus.payment;

import kr.co.srus.rental.Rental;

public interface PaymentService {
	// 결제 토큰 획득
	public String getToken(String requestURL) throws Exception;

	// 결제 취소
	public void cancelPayment(Rental rental, String token);
}
