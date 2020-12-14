package kr.co.srus.usagehistory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import kr.co.srus.member.Member;
import kr.co.srus.rentalbox.RentalBox;
import kr.co.srus.rentalbox.RentalBoxServiceImpl;

@RestController
@RequestMapping("/usagehistory")
public class UsageHistoryController {
	@Autowired
	private UsageHistoryServiceImpl usageHistoryServiceImpl;
	@Autowired
	private HttpSession session;
	@Autowired
	private RentalBoxServiceImpl rentalBoxSerivceImpl;

	// 회원 이용내역 조회
	@GetMapping("/{id}")
	public ModelAndView memberUsageHistoryList(@PathVariable String id) {
		ModelAndView mav = null;

		try {
			mav = new ModelAndView("/usagehistory/memberlist");
			Member member = (Member) session.getAttribute("member");

			UsageHistory usageHistory = new UsageHistory();
			usageHistory.setMemberId(member.getId());
			
			List<UsageHistory> rows = usageHistoryServiceImpl.searchUsageHistoryList(usageHistory);
			
			mav.addObject("rows",rows);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	// 관리자 이용내역 조회
	@GetMapping
	public ModelAndView adminUsageHistoryList() {
		ModelAndView mav = null;

		try {
			mav = new ModelAndView("/usagehistory/adminlist");
			
			RentalBox rentalBox = new RentalBox();
			List<RentalBox> rows = rentalBoxSerivceImpl.searchRentalBoxInfoList(rentalBox);
			
			mav.addObject("rows", rows);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	// 이용 내역 검색
	@GetMapping(consumes = "application/json")
	public ResponseEntity<List<UsageHistory>> searchUsageHistory(UsageHistory usageHistory) {
		List<UsageHistory> responseBody = null;
		
		try {
			responseBody = usageHistoryServiceImpl.searchUsageHistoryList(usageHistory);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return ResponseEntity.status(HttpStatus.OK).body(responseBody);
	}
	
	// 이용 내역 등록
	@PostMapping
	public ResponseEntity<Object> registerUsageHistory(UsageHistory usageHistory) {
		boolean result = false;
		Map<String,Boolean> responseBody = new HashMap<String, Boolean>();
		
		try {
			usageHistoryServiceImpl.registerUsageHistory(usageHistory);
			result = true;			
		} catch(Exception e) {
			e.printStackTrace();
		}
		responseBody.put("result", result);
		
		return ResponseEntity.status(HttpStatus.OK).body(responseBody);
	}
}
