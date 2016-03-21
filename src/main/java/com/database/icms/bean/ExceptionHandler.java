package com.database.icms.bean;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

@Component
public class ExceptionHandler implements HandlerExceptionResolver {

	@Override
	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler,
			Exception ex) {
		ex.printStackTrace();
		ModelAndView mav = new ModelAndView();
		if (!(request.getHeader("accept").indexOf("application/json") > -1 || (request
				.getHeader("X-Requested-With") != null && request.getHeader(
				"X-Requested-With").indexOf("XMLHttpRequest") > -1))) {
			mav.addObject("msg", ex.getMessage());
			mav.setViewName("/error");
			return mav;
		} else {  // for ajax
			try {
				PrintWriter writer = response.getWriter();
				writer.write(responseJson(false, ex.getMessage()));
				writer.flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return null;
		}
	}
	
	private String responseJson(boolean isSuccess, String message) {

		StringBuffer sb = new StringBuffer();
		sb.append("{");
		sb.append("\"success\":");
		if (isSuccess)
			sb.append("true");
		else
			sb.append("false");

		if (null != message && !"".equals(message)) {
			sb.append(",\"message\":");
			sb.append("\"");
			sb.append(message);
			sb.append("\"");
		}

		sb.append("}");
		String jsonStr = sb.toString();
		return jsonStr;

	}

}
