package kr.co.srus.member;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.Errors;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import kr.co.srus.validator.MemberValidator;

@RestController
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberServiceImpl memberServiceImpl;

	// 핸드폰 번호 대조
	@GetMapping("/phone")
	public ResponseEntity<Map<String, Boolean>> comparePhoneNumber(Member member) {
		Map<String, Boolean> responseBody = null;

		try {
			responseBody = new HashMap<String, Boolean>();
			responseBody.put("result", memberServiceImpl.comparePhoneNumber(member));
		} catch (Exception e) {
			e.printStackTrace();
		}

		return ResponseEntity.ok(responseBody);
	}
	
	// 아이디 찾기 양식
	@GetMapping("/findid")
	public ModelAndView findIdForm() {

		return new ModelAndView("/member/findid");
	}

	// 아이디 찾기
	@PostMapping("/findid")
	public ModelAndView findId(@Valid Member member, Errors errors) {
		ModelAndView mav = null;

		try {
			if (errors.hasFieldErrors("email")) {
				mav = new ModelAndView("/member/findid");
			} else {
				mav = new ModelAndView("/member/findidsuccess");
				mav.addObject("rows", memberServiceImpl.findId(member));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	// 비밀번호 찾기 양식
	@GetMapping("/findpassword")
	public ModelAndView findPasswordForm() {

		return new ModelAndView("/member/findpassword");
	}

	// 비밀번호 찾기
	@PostMapping("/findpassword")
	public ModelAndView findPassword(@Valid Member member, Errors errors) {
		ModelAndView mav = null;

		try {
			if (errors.hasFieldErrors("id") || errors.hasFieldErrors("email")) {
				mav = new ModelAndView("/member/findpassword");
			} else {
				mav = new ModelAndView("/member/findpasswordsuccess");
				mav.addObject("row", memberServiceImpl.findPassword(member));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	// 회원 가입 양식
	@GetMapping("/form")
	public ModelAndView signUpForm() {

		return new ModelAndView("/member/signup");
	}

	// 회원 가입
	@PostMapping
	public ModelAndView signUp(@Valid Member member, Errors errors) {
		ModelAndView mav = null;

		try {
			if (errors.hasFieldErrors("id") || errors.hasFieldErrors("password") || errors.hasFieldErrors("email")
					|| errors.hasFieldErrors("phoneNumber")) {
				mav = new ModelAndView("/member/signup");
			} else {
				memberServiceImpl.registerMemberInfo(member);

				mav = new ModelAndView(new RedirectView("/main"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	// 내정보 조회 양식
	@GetMapping("/{id}")
	public ModelAndView searchMyInfo(@PathVariable String id) {
		ModelAndView mav = null;

		try {
			mav = new ModelAndView("/member/myinfo");
			Member member = new Member();
			member.setId(id);
			
			mav.addObject("row", memberServiceImpl.searchMemberInfo(member));
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	// 회원 탈퇴
	@DeleteMapping("/{id}")
	public ModelAndView withdrawalMember(@PathVariable String id) {
		try {
			Member member = new Member();
			member.setId(id);
			member.setWithdrawalDate(LocalDate.now());

			memberServiceImpl.modifyMemberInfo(member);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView(new RedirectView("/logout"));
	}

	// 내 정보 수정하기 양식
	@GetMapping("/{id}/form")
	public ModelAndView modifyMemberForm(@PathVariable String id) {
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView("/member/modifyform");
			Member member = new Member();
			member.setId(id);
			
			mav.addObject("row", memberServiceImpl.searchMemberInfo(member));
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	// 내 정보 수정
	@PutMapping("/{id}")
	public ModelAndView modifyMember(@PathVariable String id, @Valid Member member, Errors errors){
		ModelAndView mav = null;
		
		try {
			mav = new ModelAndView(new RedirectView("/member/" + id));
			
			if (errors.hasFieldErrors("email") || errors.hasFieldErrors("phoneNumber")) {
				mav = new ModelAndView("/member/modifyform");				
			} else {
				member.setId(id);
				
				memberServiceImpl.modifyMemberInfo(member);
			}	
		} catch(Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	// 카드 정보 수정
	@PutMapping("/card")
	public ResponseEntity<Map<String, Boolean>> modifyCardInfo(Member member) {
		Map<String, Boolean> responseBody = null;

		try {
			responseBody = new HashMap<String, Boolean>();

			responseBody.put("result", memberServiceImpl.cardMemberInfo(member));
		} catch (Exception e) {
			e.printStackTrace();
		}

		return ResponseEntity.ok(responseBody);
	}

	// 사용자 목록 조회
	@GetMapping
	public ModelAndView memberList() {
		ModelAndView mav = null;

		try {
			mav = new ModelAndView("/member/list");

			mav.addObject("rows", memberServiceImpl.searchMemberInfoList(new Member()));
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	// 사용자 검색
	@GetMapping(consumes = "application/json")
	public ResponseEntity<List<Member>> searchMember(Member member) {
		List<Member> responseBody = null;

		try {
			responseBody = memberServiceImpl.searchMemberInfoList(member);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return ResponseEntity.status(HttpStatus.OK).body(responseBody);
	}

	// 아이디 중복 조회
	@GetMapping(path = "/idcheck", consumes = "application/json")
	public ResponseEntity<Map<String, Boolean>> idCheck(@Valid Member member, Errors errors) {
		Map<String, Boolean> responseBody = null;

		try {
			responseBody = new HashMap<String, Boolean>();

			if (!errors.hasFieldErrors("id") && memberServiceImpl.searchMemberInfo(member) != null) {
				responseBody.put("isDuplicated", true);
			} else {
				responseBody.put("isDuplicated", false);
			}
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
