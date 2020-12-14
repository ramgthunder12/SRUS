package kr.co.srus.rentalbox;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import kr.co.srus.validator.RentalBoxValidator;

@Controller
@RequestMapping("/rentalbox")
public class RentalBoxController {
	@Autowired
	private RentalBoxServiceImpl rentalBoxServiceImpl;

	// 무인대여함 목록 조회
	@GetMapping
	public ModelAndView rentalBoxList() {
		ModelAndView mav = null;

		try {
			mav = new ModelAndView("/rentalbox/list");
			RentalBox rentalBox = new RentalBox();

			List<RentalBox> rows = rentalBoxServiceImpl.searchRentalBoxInfoList(rentalBox);
			
			mav.addObject("rows", rows);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	// 무인대여함 등록 폼
	@GetMapping("/form")
	public ModelAndView registerRentalBoxForm() {
		ModelAndView mav = new ModelAndView("/rentalbox/registerform");

		return mav;
	}

	// 무인 대여함 등록
	@PostMapping
	public ModelAndView registerRentalBox(@Valid RentalBox rentalBox, Errors errors) {
		ModelAndView mav = null;

		try {
			if (errors.hasErrors()) {
				mav = new ModelAndView("/rentalbox/registerform");
				mav.addObject("errorMessage", "입력란에 모든 항목을 형식에 맞게 제대로 입력해주세요.");
			} else {
				rentalBoxServiceImpl.registerRentalBoxInfo(rentalBox);
				
				mav = new ModelAndView(new RedirectView("/rentalbox"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	// 무인대여함 수정 폼
	@GetMapping("/{no}/form")
	public ModelAndView modifyRentalBoxForm(@PathVariable("no") int no) {
		ModelAndView mav = null;

		try {
			mav = new ModelAndView("/rentalbox/modifyform");
			RentalBox rentalBox = new RentalBox();
			rentalBox.setNo(no);

			RentalBox row = rentalBoxServiceImpl.searchRentalBoxInfo(rentalBox);

			mav.addObject("row", row);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	// 무인 대여함 수정
	@PutMapping("/{no}")
	public ModelAndView modifyRentalBox(@Valid RentalBox rentalBox, Errors errors) {
		ModelAndView mav = null;
		
		try {
			if (errors.hasErrors()) {
				mav = new ModelAndView("/rentalbox/modifyform");
				mav.addObject("errorMessage", "입력란에 모든 항목을 형식에 맞게 제대로 입력해주세요.");
			} else {
				rentalBoxServiceImpl.modifyRentalBoxInfo(rentalBox);
				
				mav = new ModelAndView(new RedirectView("/rentalbox"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		}

		return mav;
	}


	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		binder.setValidator(new RentalBoxValidator());
	}
}
