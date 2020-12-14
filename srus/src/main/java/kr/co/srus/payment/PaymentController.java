package kr.co.srus.payment;

import java.time.LocalDate;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.srus.member.Member;
import kr.co.srus.rental.Rental;
import kr.co.srus.rental.RentalServiceImpl;
import kr.co.srus.rentalbox.RentalBox;
import kr.co.srus.rentalbox.RentalBoxServiceImpl;
import kr.co.srus.validator.RentalDateValidator;

@Controller
@RequestMapping("/payment")
public class PaymentController {
	@Autowired
	private PaymentServiceImpl paymentServiceImpl;
	@Autowired
	private RentalServiceImpl rentalServiceImpl;
	@Autowired
	private HttpSession session;
	@Autowired
	private RentalBoxServiceImpl rentalBoxServiceImpl;

	// 결제 성공 양식
	@GetMapping("/success")
	public ModelAndView paymentSuccessForm() {
		ModelAndView mav = new ModelAndView("/payment/success");

		return mav;
	}

	// 결제 확인 양식
	@GetMapping("/confirmationform")
	public ModelAndView confirmForm(Rental rental, Errors errors) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView();
			new RentalDateValidator().validate(rental, errors);

			RentalBox rentalBox = new RentalBox();
			rentalBox.setNo(rental.getRentalBoxNo());
			
			if (errors.hasFieldErrors("rentalBoxNo") || rentalBoxServiceImpl.searchRentalBoxInfo(rentalBox) == null) {
				mav.setViewName("redirect:/rental/step1");
			} else if (errors.hasErrors()) {
				mav.setViewName("redirect:/rental/step2/" + rental.getRentalBoxNo());
			} else {
				mav.setViewName("/payment/confirmationform");

				int charge = rentalServiceImpl.calculatePayment(rental);

				rental.setAmountOfPayment(charge);
				rental.setPaymentDate(LocalDate.now());
				Member member = (Member) session.getAttribute("member");
				rental.setMemberId(member.getId());

				mav.addObject("rental", rental);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	// 결제 취소
	@GetMapping("/cancel")
	public ModelAndView cancelPayment(Rental rental) {
		ModelAndView mav = null;

		try {
			mav = new ModelAndView("/payment/cancel");
			String token = null;

			token = paymentServiceImpl.getToken("https://api.iamport.kr/users/getToken");
			paymentServiceImpl.cancelPayment(rental, token);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}
}
