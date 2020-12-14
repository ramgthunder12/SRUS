package kr.co.srus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import kr.co.srus.interceptor.AuthCheckInterceptor;
import kr.co.srus.interceptor.LoginInterceptor;
import kr.co.srus.interceptor.PathVariableInterceptor;
import kr.co.srus.interceptor.SessionCheckInterceptor;
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
	@Autowired
	SessionCheckInterceptor sessionCheckInterceptor;
	@Autowired
	AuthCheckInterceptor authCheckInterceptor;
	@Autowired
	LoginInterceptor loginInterceptor;
	@Autowired
	PathVariableInterceptor pathVariableInterceptor;
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(loginInterceptor)
			.addPathPatterns("/login");
		
		registry.addInterceptor(sessionCheckInterceptor)
			//.addPathPatterns("/main")
			
			.addPathPatterns("/member")
			.addPathPatterns("/member/*")
			.addPathPatterns("/member/*/form")
			.excludePathPatterns("/member/phone")
			.excludePathPatterns("/member/card")
			.excludePathPatterns("/member/form")
			.excludePathPatterns("/member/findid")
			.excludePathPatterns("/member/findpassword")
			.excludePathPatterns("/member/rental")
			.excludePathPatterns("/member/idcheck")
			
			.addPathPatterns("/payment")
			.addPathPatterns("/payment/*")
			
			.addPathPatterns("/rental")
			.addPathPatterns("/rental/*")
			.addPathPatterns("/rental/*/*")
			.excludePathPatterns("/rental/*/current")
			
			.addPathPatterns("/rentalbox")
			.addPathPatterns("/rentalbox/*")
			.addPathPatterns("/rentalbox/*/form")
			
			.addPathPatterns("/usagehistory")
			.addPathPatterns("/usagehistory/*");
		
		registry.addInterceptor(authCheckInterceptor)
			.addPathPatterns("/member")
			
			.addPathPatterns("/rentalbox")
			.addPathPatterns("/rentalbox/*")
			.addPathPatterns("/rentalbox/*/form")
			
			.addPathPatterns("/rental/admin")
			.addPathPatterns("/rental")
			.addPathPatterns("/rental/")
			.excludePathPatterns("/rental/*/current")
			
			.addPathPatterns("/usagehistory/admin")
			.addPathPatterns("/usagehistory")
			.addPathPatterns("/usagehistory/");
		
		registry.addInterceptor(pathVariableInterceptor)
			.addPathPatterns("/member/*")
			.addPathPatterns("/member/*/form")
			.excludePathPatterns("/member/phone")
			.excludePathPatterns("/member/card")
			.excludePathPatterns("/member/form")
			.excludePathPatterns("/member/findpassword")
			.excludePathPatterns("/member/findid")
			.excludePathPatterns("/member/idcheck")
			.addPathPatterns("/usagehistory/*")
			.addPathPatterns("/usagehistory/*/form")
			.addPathPatterns("/rental/*")
			.excludePathPatterns("/rental/step1")
			.excludePathPatterns("/rental/step2");
	}
}