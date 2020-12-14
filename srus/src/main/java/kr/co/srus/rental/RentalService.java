package kr.co.srus.rental;

import java.util.List;

import kr.co.srus.member.Member;
import kr.co.srus.rentalbox.RentalBox;

public interface RentalService {
	// 대여 불가능 일자 조회
	public List<String> searchUnrentableDate(RentalBox rentalBox) throws Exception;

	// 대여 정보 등록
	public void registerRentalInfo(Rental rental) throws Exception;

	// 대여 정보 목록 조회
	public List<Rental> searchRentalInfoList(Rental rental) throws Exception;

	// 대여 정보 조회
	public List<Rental> searchRentalInfo(Rental rental) throws Exception;

	// 대여 정보 수정
	public void modifyRentalInfo(Rental rental) throws Exception;

	// 결제 금액 계산
	public int calculatePayment(Rental rental) throws Exception;

	// 현재 대여정보 조회
	public List<Rental> searchCurrentRental(Member member) throws Exception;
}
