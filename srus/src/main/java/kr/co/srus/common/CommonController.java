package kr.co.srus.common;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.srus.member.Member;
import kr.co.srus.member.MemberServiceImpl;
import kr.co.srus.validator.MemberValidator;

@Controller
@RequestMapping("/")
public class CommonController {
	@Autowired
	private CommonServiceImpl commonServiceImpl;
	@Autowired
	private MemberServiceImpl memberServiceImpl;
	@Autowired
	private HttpSession session;

	// 로그인 양식
	@GetMapping("/login")
	public ModelAndView loginForm() {
		ModelAndView mav = new ModelAndView("/common/login");
		
		return mav;
	}

	// 로그인
	@PostMapping("/login")
	public ModelAndView login(@Valid Member member, Errors errors) {
		ModelAndView mav = null;
		
		try {
			if (errors.hasFieldErrors("id") || errors.hasFieldErrors("password")) {
				mav = new ModelAndView("/common/login");
				mav.addObject("errorMessage", "입력란에 모든 항목을 형식에 맞게 제대로 입력해주세요.");
			} else {
				boolean isLogin = commonServiceImpl.login(member);
				if (isLogin == true) {
					char division = memberServiceImpl.searchMemberInfo(member).getDivision();
																							
					member.setDivision(division);
					session.setAttribute("member", member);

					mav = new ModelAndView("redirect:/main");
				} else {
					mav = new ModelAndView("/common/login");
					mav.addObject("errorMessage", "가입하지 않은 아이디이거나, 잘못된 비밀번호입니다.");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	// 로그아웃
	@GetMapping("/logout")
	public ModelAndView logout() {
		ModelAndView mav = new ModelAndView("redirect:/main");
		commonServiceImpl.logout();

		return mav;
	}

	// 메인 양식
	@GetMapping("/main")
	public ModelAndView main() {
		ModelAndView mav = new ModelAndView("/common/main");

		return mav;
	}

	// 회원 검증
	@PostMapping("/validmember")
	public ResponseEntity<Map<String, Boolean>> validMember(Member member) {
		Map<String, Boolean> responseBody = null;

		try {
			boolean result = false;
			responseBody = new HashMap<String, Boolean>();

			Member row = memberServiceImpl.searchMemberInfo(member);
			if (row != null) {
				if (row.getDivision() == 'M') {
					result = commonServiceImpl.login(member);
				}
			}
			responseBody.put("result", result);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return ResponseEntity.ok(responseBody);
	}
	
	// validator 설정
	@InitBinder 
	protected void initBinder(WebDataBinder binder) {
		binder.setValidator(new MemberValidator());
	}
}