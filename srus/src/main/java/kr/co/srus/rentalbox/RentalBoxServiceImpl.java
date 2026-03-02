package kr.co.srus.rentalbox;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class RentalBoxServiceImpl implements RentalBoxService {
	@Autowired
	private RentalBoxMapper rentalBoxMapper;

	// 무인 대여함 정보 등록
	@Override
	@Transactional
	public void registerRentalBoxInfo(RentalBox rentalBox) throws Exception {
		rentalBoxMapper.insert(rentalBox);
	}

	// 무인 대여함 정보 목록 조회
	@Override
	@Transactional(readOnly = true)
	public List<RentalBox> searchRentalBoxInfoList(RentalBox rentalBox) throws Exception {
		List<RentalBox> rows = rentalBoxMapper.selectAll(rentalBox);

		for (int i = 0; i < rows.size(); i++) {
			if (rows.get(i).getDivision() == 'D') {
				rows.remove(i);
			}
		}

		return rows;
	}

	// 무인 대여함 정보 조회
	@Override
	@Transactional(readOnly = true)
	public RentalBox searchRentalBoxInfo(RentalBox rentalBox) throws Exception {

		return rentalBoxMapper.select(rentalBox);
	}

	// 무인 대여함 정보 수정
	@Override
	@Transactional
	public void modifyRentalBoxInfo(RentalBox rentalBox) throws Exception {
		rentalBoxMapper.update(rentalBox);
	}
}
