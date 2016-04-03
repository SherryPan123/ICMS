package com.database.icms.configuration;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

public class AjaxAuthenticationFailureHandler implements AuthenticationFailureHandler {

	private AuthenticationFailureHandler defaultHandler;

	public AjaxAuthenticationFailureHandler() {

	}

	public AjaxAuthenticationFailureHandler(AuthenticationFailureHandler defaultHandler) {
		this.defaultHandler = defaultHandler;
	}
	
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException auth)
			throws IOException, ServletException {
		if ("true".equals(request.getHeader("X-Ajax-call"))) {
			response.getWriter().print("error");
			response.getWriter().flush();
		} else {
			defaultHandler.onAuthenticationFailure(request, response, auth);
		}
	}
}
