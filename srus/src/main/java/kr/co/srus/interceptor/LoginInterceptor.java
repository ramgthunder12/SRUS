package kr.co.srus.interceptor;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import kr.co.srus.member.Member;

@Component
public class LoginInterceptor implements HandlerInterceptor {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws IOException {
		HttpSession session = request.getSession();

		Member member = (Member) session.getAttribute("member");

		String requestMappingURL = extractRequestMappingURL(request);

		if ("/login".equals(requestMappingURL) && member != null) {
			response.sendRedirect("/main");

			return false;
		} else {
			return true;
		}
	}

	private String extractRequestMappingURL(HttpServletRequest request) {
		String requestURL = request.getRequestURI();

		return requestURL.substring(request.getContextPath().length(), requestURL.length());
	}
}