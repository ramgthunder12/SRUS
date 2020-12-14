package kr.co.srus.usagehistory;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UsageHistoryMapper {
    public void insert(UsageHistory usageHistory) throws Exception;
    public List<UsageHistory> selectAll(UsageHistory usageHistory) throws Exception;
}
