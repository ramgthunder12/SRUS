package kr.co.srus.usagehistory;

import java.util.List;

public interface UsageHistoryService {
	// 이용 내역 등록
	public void registerUsageHistory(UsageHistory usageHistory) throws Exception;

	// 이용 내역 목록 조회
	public List<UsageHistory> searchUsageHistoryList(UsageHistory usageHistory) throws Exception;
}