package kr.co.srus.interceptor;

import java.io.IOException;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import kr.co.srus.member.Member;

@Component
public class PathVariableInterceptor implements HandlerInterceptor {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws IOException {
		String requestURL = request.getRequestURI();

		HttpSession session = request.getSession();
		Member member = (Member) session.getAttribute("member");

		boolean isMember = verifyMember(requestURL, member.getId());

		if (isMember) {
			return true;
		} else {
			response.sendRedirect("/main");

			return false;
		}
	}

	private boolean verifyMember(String requestURL, String memberId) {

		StringTokenizer stringTokenizer = new StringTokenizer(requestURL, "/");
		while (stringTokenizer.hasMoreTokens()) {
			String token = stringTokenizer.nextToken();

			if (token.equals(memberId)) {
				return true;
			}
		}
		return false;
	}
}