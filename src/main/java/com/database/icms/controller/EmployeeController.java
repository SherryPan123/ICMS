package com.database.icms.controller;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.database.icms.domain.Company;
import com.database.icms.domain.Employee;
import com.database.icms.service.CompanyService;
import com.database.icms.service.EmployeeService;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

@Controller
@RequestMapping("/employee")
public class EmployeeController {

	@Autowired
	private CompanyService companyService;
	
	@Autowired
	private EmployeeService employeeService;
	
	@RequestMapping(value = "/getEmployeeInJson", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String getEmployeeInJson(@RequestParam("companyId") Integer companyId,
			@RequestParam("employeeId") String employeeId, HttpServletRequest request) {
		Gson gson = new Gson();
		try {
			Company company = companyService.getCompanyById(companyId);
			if (null == company) {
				JsonObject root = new JsonObject();
				root.addProperty("success", false);
				root.addProperty("msg", "Invalid Company Id");
				System.out.println(gson.toJson(root));
				return gson.toJson(root);
			}
			Employee employee = employeeService.loadByEmployeeId(companyId, employeeId);
			if (null == employee) {
				JsonObject root = new JsonObject();
				root.addProperty("success", false);
				root.addProperty("msg", "No Employee Found");
				System.out.println(gson.toJson(root));
				return gson.toJson(root);
			}
			JsonObject root = new JsonObject();
			root.addProperty("success", true);
			root.addProperty("id", employee.getId());
			root.addProperty("name", employee.getName());
			System.out.println(gson.toJson(root));
			return gson.toJson(root);

		} catch (ServiceException e) {
			JsonObject root = new JsonObject();
			root.addProperty("success", false);
			root.addProperty("msg", e.getMessage());
			System.out.println(gson.toJson(root));
			return gson.toJson(root);
		}
	}
	
}
