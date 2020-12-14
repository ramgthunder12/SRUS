package kr.co.srus.rental;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.srus.member.Member;
import kr.co.srus.rentalbox.RentalBox;
import kr.co.srus.rentalbox.RentalBoxMapper;

@Service
public class RentalServiceImpl implements RentalService {
	@Autowired
	private RentalMapper rentalMapper;
	@Autowired
	private RentalBoxMapper rentalBoxMapper;

	// 대여 불가능 일자 조회
	@Override
	public List<String> searchUnrentableDate(RentalBox rentalBox) throws Exception {
		int rentalBoxNo = rentalBox.getNo();

		List<LocalDate> unrentableDateList = new ArrayList<LocalDate>();
		List<String> resultList = new ArrayList<String>();
		List<Rental> rentalList = new ArrayList<Rental>();
		List<Rental> rows = null;

		Rental rental = new Rental();
		rental.setRentalBoxNo(rentalBoxNo);
		
		rows = rentalMapper.selectAll(rental);

		for (int i = 0; i < rows.size(); i++) {
			if (rows.get(i).getCancellationDate() == null) {
				rentalList.add(rows.get(i));
			}
		}

		if (rentalList != null) {
			for (int i = 0; i < rentalList.size(); i++) {
				LocalDate startDate = rentalList.get(i).getStartDate();
				LocalDate endDate = rentalList.get(i).getEndDate();
				LocalDate unrentableDate = startDate; // 대여 정보의 시작 날짜

				long period = ChronoUnit.DAYS.between(startDate, endDate); // 대여 기간을 구해 반복문을 대여 기간만큼 수행한다.

				for (int j = 0; j <= period; j++) {
					unrentableDateList.add(unrentableDate);
					unrentableDate = unrentableDate.plusDays(1); // 하루를 더한다.
				}
			}
		}

		for (int i = 0; i < unrentableDateList.size(); i++) {
			resultList.add("\"" + unrentableDateList.get(i) + "\"");
		}

		return resultList;
	}

	// 대여 정보 등록
	@Override
	public void registerRentalInfo(Rental rental) throws Exception {
		rentalMapper.insert(rental);
	}

	// 대여 정보 목록 조회
	@Override
	public List<Rental> searchRentalInfoList(Rental rental) throws Exception {

		return rentalMapper.selectAll(rental);
	}

	// 대여 정보 조회
	@Override
	public List<Rental> searchRentalInfo(Rental rental) throws Exception {

		return rentalMapper.selectAllById(rental);
	}

	// 대여 정보 수정
	@Override
	public void modifyRentalInfo(Rental rental) throws Exception {
		if (rentalMapper.select(rental) != null) {
			rentalMapper.update(rental);
		}
	}
	
	// 결제 금액 계산
	@Override
	public int calculatePayment(Rental rental) throws Exception {
		LocalDate startDate = null;
		LocalDate endDate = null;
		long period = 0;
		int rentalBoxNo = 0;
		int charge = 0;

		rentalBoxNo = rental.getRentalBoxNo();
		startDate = rental.getStartDate();
		endDate = rental.getEndDate();

		RentalBox rentalBox = new RentalBox();
		rentalBox.setNo(rentalBoxNo);

		rentalBox = rentalBoxMapper.select(rentalBox);
		charge = rentalBox.getCharge();

		period = ChronoUnit.DAYS.between(startDate, endDate.plusDays(1));

		return (int) (charge * period);
	}

	// 현재 대여정보 조회
	@Override
	public List<Rental> searchCurrentRental(Member member) throws Exception {
		Rental rental = new Rental();
		rental.setMemberId(member.getId());
		List<Rental> currentRentalList = null;
		List<Rental> rows = rentalMapper.selectAll(rental);

		if (rows != null) {
			currentRentalList = new ArrayList<Rental>();
			for (Rental row : rows) {
				if ((LocalDate.now().isAfter(row.getStartDate()) || LocalDate.now().isEqual(row.getStartDate()))
						&& (LocalDate.now().isBefore(row.getEndDate()) || LocalDate.now().isEqual(row.getEndDate()))
						&& row.getCancellationDate() == null) {
					currentRentalList.add(row);
				}
			}
		}

		return currentRentalList;
	}
}
