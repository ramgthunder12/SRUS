package kr.co.srus.rentalbox;

import java.util.List;

public interface RentalBoxService {
	// 무인 대여함 정보 등록
	public void registerRentalBoxInfo(RentalBox rentalBox) throws Exception;

	// 무인 대여함 정보 목록 조회
	public List<RentalBox> searchRentalBoxInfoList(RentalBox rentalBox) throws Exception;

	// 무인 대여함 정보 조회
	public RentalBox searchRentalBoxInfo(RentalBox rentalBox) throws Exception;

	// 무인 대여함 정보 수정
	public void modifyRentalBoxInfo(RentalBox rentalBox) throws Exception;
}
