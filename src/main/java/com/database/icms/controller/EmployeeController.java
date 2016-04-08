package com.database.icms.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.SystemException;
import javax.validation.Valid;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.database.icms.domain.Company;
import com.database.icms.domain.Conditions;
import com.database.icms.domain.Employee;
import com.database.icms.service.CompanyService;
import com.database.icms.service.ConditionsService;
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
	
	@Autowired
	private ConditionsService conditionsService;

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ModelAndView listEmployee(@RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "10") Integer max,
			@RequestParam(value = "companyId", defaultValue = "0") Integer companyId,
			@RequestParam(value = "employeeId", required = false) String employeeId,
			@RequestParam(value = "name", required = false) String name,
			@RequestParam(value = "isEdit", defaultValue = "0") Integer isEdit) {
		ModelAndView mav = new ModelAndView("/employee/list");
		mav.addObject("page", page);
		mav.addObject("max", max);
		try {
			List<Employee> employeeList = null;
			int totalPage;
			//获得当前登陆公司
			if (companyId == 0)
				companyId = companyService.getSessionCompany().getId();
			String companyName = companyService.getCompanyById(companyId).getName();
			System.out.println("当前公司Id: "+companyId);

			//employeeId,name,sex,phone,email,company
			employeeList = employeeService.listDetail(companyId, employeeId, name, (page - 1) * max, max);
			if (null == employeeList || employeeList.isEmpty()) {
				totalPage = 0;
			} else {
				totalPage = (employeeService.listAllDetailSize(companyId, employeeId, name) + max - 1) / max;
			}
			Employee employee = new Employee();
			employee.setCompany(companyService.getCompanyById(companyId));
			mav.addObject("employee", employee);
			mav.addObject("employeeList", employeeList);
			mav.addObject("companyId", companyId);
			mav.addObject("companyName", companyName);
			mav.addObject("employeeId", employeeId);
			mav.addObject("name", name);
			mav.addObject("totalPage", totalPage);
			mav.addObject("isEdit", isEdit);
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public ModelAndView viewEmployee(@RequestParam(value = "id") Integer id,
			@RequestParam(value = "isEdit", defaultValue = "0") Integer isEdit) throws SystemException {
		ModelAndView mav = new ModelAndView("employee/view");
		try {
			Employee employee = employeeService.load(id);
			if (null == employee)
				throw new SystemException("Invalid Employee Id");
			List<Conditions> conditionsList = conditionsService.findByEmployee(id);
			mav.addObject("employee", employee);
			mav.addObject("conditionsList", conditionsList);
			mav.addObject("isEdit", isEdit);
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public ModelAndView addGet(@RequestParam(value = "companyId") Integer companyId) throws SystemException {
		ModelAndView mav = new ModelAndView("employee/add");
		try {
			Employee employee = new Employee();
			Company company = companyService.getCompanyById(companyId);
			if(company == null)
				throw new SystemException("Company Can't Be Null!");
			employee.setCompany(company);
			mav.addObject("companyId", companyId);
			mav.addObject("employee", employee);
			return mav;
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public ModelAndView addPost(@Valid @ModelAttribute Employee employee, BindingResult bindingResult) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView("employee/add");
		try {
			if (bindingResult.hasErrors()) {
				mav.setViewName("/employee/add");
				return mav;
			}
			//String tmp = employee.getName();
			employee.setName(new String(employee.getName().getBytes("iso-8859-1"), "utf-8"));
			System.out.println("雇员的姓名: "+employee.getName());
			employeeService.save(employee);
			mav.setView(new RedirectView("/employee/list.html", true));
			return mav;
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/submitJSON", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String submitPOSTJSON(@Valid @ModelAttribute Employee employee, BindingResult result) throws SystemException {
		Gson gson = new Gson();
		try {
			if (result.hasErrors()) {
				JsonObject root = new JsonObject();
				root.addProperty("success", false);
				root.addProperty("msg", "Invalid Information");
				System.out.println(gson.toJson(root));
				return gson.toJson(root);
			} else {
				employeeService.save(employee);
				JsonObject root = new JsonObject();
				root.addProperty("success", true);
				root.addProperty("msg", "success");
				System.out.println(gson.toJson(root));
				return gson.toJson(root);
			}
		} catch (ServiceException e) {
			throw new SystemException(e.getMessage());
		}
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public ModelAndView update(@RequestParam(value = "id") Integer id) throws SystemException {
		try {
			Employee employee = employeeService.load(id);
			if (null == employee)
				throw new SystemException("Invalid Employee Id");
			ModelAndView mav = new ModelAndView("employee/update");
			mav.addObject("employee", employee);
			return mav;
		} catch (ServiceException e) {
			throw new SystemException(e.getMessage());
		}
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public ModelAndView updateSave(@Valid @ModelAttribute Employee employee,
			BindingResult bindingResult, HttpServletRequest request) throws SystemException, UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();
		try {
			if (bindingResult.hasErrors()) {
				mav.setViewName("/employee/update");
				return mav;
			}
			if (null != employee.getId()) {
				employee.setName(new String(employee.getName().getBytes("iso-8859-1"), "utf-8"));
				employeeService.update(employee);
				mav.setView(new RedirectView("/employee/view.html?id="+employee.getId(), true));
				return mav;
			}
			return new ModelAndView(request.getHeader("Referer"));
		} catch (ServiceException e) {
			throw new SystemException(e.getMessage());
		}
	}

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
