package kr.co.srus.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import kr.co.srus.member.Member;

@Component
public class AuthCheckInterceptor implements HandlerInterceptor {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();

		Member member = (Member) session.getAttribute("member");

		String requestMappingURL = extractRequestMappingURL(request);
		String requestMethod = request.getMethod();

		if ("/member".equals(requestMappingURL) && "POST".equals(requestMethod)) {
			return true;
		} else if ("/usagehistory".equals(requestMappingURL) && "POST".equals(requestMethod)) {
			return true;
		} else if ("/rental".equals(requestMappingURL) && "POST".equals(requestMethod)) {
			return true;
		}

		if (member != null && 'A' == member.getDivision()) {
			return true;
		} else {
			response.sendRedirect("/main");

			return false;
		}
	}

	private String extractRequestMappingURL(HttpServletRequest request) {
		String requestURL = request.getRequestURI();

		return requestURL.substring(request.getContextPath().length(), requestURL.length());
	}
}