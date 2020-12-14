package kr.co.srus.rental;

import java.util.List;

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
@RequestMapping("/rental")
public class RentalController {
	@Autowired
	private RentalServiceImpl rentalServiceImpl;
	@Autowired
	private RentalBoxServiceImpl rentalBoxServiceImpl;

	// 무인대여함 선택 화면
	@GetMapping("/step1")
	public ModelAndView chooseRentalBox() {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView("/rental/chooserentalbox");

			RentalBox rentalBox = new RentalBox();

			List<RentalBox> rows = rentalBoxServiceImpl.searchRentalBoxInfoList(rentalBox);
			mav.addObject("rows", rows);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	// 대여 기간 선택 화면
	@GetMapping("/step2/{no}")
	public ModelAndView chooseRentalPeriod(RentalBox rentalBox) {
		ModelAndView mav = null;
		try {
			mav = new ModelAndView();
			RentalBox row = rentalBoxServiceImpl.searchRentalBoxInfo(rentalBox);// {no}에 해당하는 무인 대여함 정보를 조회에 mav에 담아준다.
			
			if (row == null) {
				mav.setViewName("redirect:/rental/step1");
			} else {
				mav.setViewName("/rental/chooserentalperiod");
				
				List<String> unrentalDateList = rentalServiceImpl.searchUnrentableDate(rentalBox); // 대여 불가능한 날짜를 조회한다.
				
				mav.addObject("unrentalDateList", unrentalDateList);			
				mav.addObject("row", row);
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	// 대여 정보 등록
	@PostMapping
	public ModelAndView registerRental(Rental rental) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView("redirect:/payment/success");
			rentalServiceImpl.registerRentalInfo(rental);		
		} catch(Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	// 회원 대여 내역 조회
	@GetMapping("/{id}")
	public ModelAndView memberRentalList(@PathVariable("id") String id) {
		ModelAndView mav = null;
		
		try {			
			mav = new ModelAndView("/rental/memberrentallist");
			
			Rental rental = new Rental();
			rental.setMemberId(id);
			
			List<Rental> rows = rentalServiceImpl.searchRentalInfoList(rental);
			mav.addObject("rows", rows);
		} catch(Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	// 관리자 대여정보 목록 조회
	@GetMapping
	public ModelAndView adminRentalList() {
		ModelAndView mav = null;
		try {			
			mav = new ModelAndView("/rental/adminrentallist");
			
		} catch(Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	// 대여 정보 검색
	@GetMapping(consumes = "application/json")
	public ResponseEntity<List<Rental>> searchRental(Rental rental) {
		List<Rental> responseBody = null;
		
		try {
			responseBody = rentalServiceImpl.searchRentalInfo(rental);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return ResponseEntity.status(HttpStatus.OK).body(responseBody);
	}

	// 현재 대여정보 조회
	@GetMapping("/{id}/current")
	public ResponseEntity<List<Rental>> searchCurrentRental(@PathVariable String id){
		List<Rental> responseBody = null;
		
		try {
			Member member = new Member();
			member.setId(id);
			responseBody = rentalServiceImpl.searchCurrentRental(member);
		} catch(Exception e) {
			e.printStackTrace();
		}

		return ResponseEntity.ok(responseBody);
	}
}