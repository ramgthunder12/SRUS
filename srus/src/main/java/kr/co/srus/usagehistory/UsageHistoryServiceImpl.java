package kr.co.srus.usagehistory;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.srus.rental.Rental;
import kr.co.srus.rental.RentalMapper;

@Service
public class UsageHistoryServiceImpl implements UsageHistoryService {
	@Autowired
	private UsageHistoryMapper usageHistoryMapper;
	@Autowired
	private RentalMapper rentalMapper;

	// 이용 내역 등록
	@Override
	public void registerUsageHistory(UsageHistory usageHistory) throws Exception {
		Rental rental = new Rental();
		rental.setRentalBoxNo(usageHistory.getRentalBoxNo());
		
		List<Rental> rows = rentalMapper.selectAll(rental);
		String memberId = null;
		
		for (int i = 0; i < rows.size(); i++) {
			if (rows.get(i).getStartDate().isBefore(LocalDate.now())
					|| LocalDate.now().isEqual(rows.get(i).getStartDate())
							&& (rows.get(i).getEndDate().plusDays(1)).isAfter(LocalDate.now())
					|| LocalDate.now().isEqual(rows.get(i).getEndDate())
							&& rows.get(i).getCancellationDate() == null) {
				memberId = rows.get(i).getMemberId();
			}
		}
		usageHistory.setMemberId(memberId);

		usageHistoryMapper.insert(usageHistory);
	}

	// 이용 내역 목록 조회
	@Override
	public List<UsageHistory> searchUsageHistoryList(UsageHistory usageHistory) throws Exception {
		
		return usageHistoryMapper.selectAll(usageHistory);
	}

}
