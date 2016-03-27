package com.database.icms.check;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.database.icms.domain.Company;
import com.database.icms.service.*;

@Controller
public class Check_update extends HttpServlet {
	
	@Autowired
	CompanyService companyService;
	// 用于异步检查用户名是否可用_更新用户
	@RequestMapping(value = "check_update", method = RequestMethod.GET)
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 解决返回中文乱码问题
		response.setCharacterEncoding("utf-8");
		String name = request.getParameter("name");
		String id = request.getParameter("id");
		// 解决接收中文乱码问题
		name = new String(name.getBytes("iso-8859-1"), "gb2312");
		id = new String(id.getBytes("iso-8859-1"), "gb2312");

		Company getById = companyService.getCompanyById(id);
		Company getByName = companyService.getCompanyByName(name);
		String msg = null;
		if (getById.getName().equals(name) || getByName == null) {
			msg = "用户名可以使用!";
		} else {
			msg = "用户名已被占用!";
		}
		// System.out.println(msg);
		response.getWriter().print(msg);

	}

	@RequestMapping(value = "check_update", method = RequestMethod.POST)
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}