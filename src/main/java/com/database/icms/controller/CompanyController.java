package com.database.icms.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.database.icms.domain.Company;
import com.database.icms.domain.Role;
import com.database.icms.service.CompanyService;
import com.database.icms.service.RoleService;

@Controller
@RequestMapping("/company")
public class CompanyController {
	
	@Autowired
	private CompanyService companyService;

	@Autowired
	private RoleService roleService;

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ModelAndView listAllCompany(
			@RequestParam( defaultValue = "1") Integer page,
			@RequestParam( defaultValue = "10") Integer max,
			@RequestParam( value="name",required = false ) String name,
			//0代表不需要被编辑,1代表需要被编辑
			@RequestParam( value="isEdit",defaultValue="0") Integer isEdit
			) 
	{
		ModelAndView mav = new ModelAndView("company/list");
		mav.addObject("page",page);
		mav.addObject("max",max);
		mav.addObject("isEdit",isEdit);
		mav.addObject("name",name);
		
		List<Company> companyList = new ArrayList<Company>();
		if(name==null||name.isEmpty())
		{
			companyList = companyService.findAllCompanyByPage(page,max);
			int totalPage = ( companyService.findAllCompany().size() + max - 1 ) / max;
			
			mav.addObject("company",companyList);
			mav.addObject("totalPage",totalPage);
		}
		else
		{
			companyList = companyService.findCompanyByVagueName(name);
			int totalPage = (companyList.size() + max - 1) / max;
			
			mav.addObject("company",companyList);
			mav.addObject("totalPage",totalPage);
			
		}
		return mav;
	}

	// 根据id删除公司
	@RequestMapping(value = "delete", method = RequestMethod.GET)
	public String deleteCompanyByName(@RequestParam Integer id, ModelMap model) {
		// System.out.println(id);
		if (companyService.deleteCompanyById(id)) {
			List<Company> companyList = new ArrayList<Company>();
			companyList = companyService.findAllCompany();
			model.addAttribute("companyList", companyList);
			return "redirect:/company/list?isEdit=1";
		} else 
		{
			return "company/list?isEdit=1";
		}
	}

	// 添加公司
	@RequestMapping(value = "add", method = RequestMethod.GET)
	public ModelAndView addCompany() {
		ModelAndView mav = new ModelAndView("company/add");
		Company company = new Company();
		mav.addObject("company", company);
		return mav;
	}

	@RequestMapping(value = "add", method = RequestMethod.POST)
	public ModelAndView saveCompany(@Valid Company company, BindingResult result) {
		if (result.hasErrors()) {
			return new ModelAndView("redirect:/company/add");
		}
		company.setPassword(new BCryptPasswordEncoder().encode(company.getPassword()));
		Role role = roleService.getRoleByName("company");
		company.setRole(role);
		companyService.save(company);
		return new ModelAndView("redirect:/company/list");
	}

	// 更新公司信息
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public ModelAndView getUpdatedCompany(@RequestParam String name) {
		// System.out.println(name);
		ModelAndView mav = new ModelAndView("company/update");
		Company company = companyService.getCompanyByName(name);
		mav.addObject("company", company);
		return mav;
	}

	@RequestMapping(value = "update", method = RequestMethod.POST)
	public ModelAndView updateCompany(@Valid Company company, BindingResult result) {
		if (result.hasErrors())
			return new ModelAndView("redirect:company/update?id="+company.getId());

		Role role;
		if (company.getName().equals("ICMS"))
			role = roleService.getRoleByName("ROLE_admin");
		else
			role = roleService.getRoleByName("company");

		company.setName(company.getName().substring(company.getName().indexOf(',') + 1));
		Company company_be_updated = companyService.getCompanyById(company.getId());

		System.out.println(company.getPassword());
		if (!(company_be_updated.getPassword().equals(company.getPassword()))) {
			company_be_updated.setPassword(new BCryptPasswordEncoder().encode(company.getPassword()));
		}
		company_be_updated.setName(company.getName());
		company_be_updated.setPhone(company.getPhone());
		company_be_updated.setRole(role);
		company_be_updated.setAddress(company.getAddress());

		companyService.update(company_be_updated);
		return new ModelAndView("redirect:/company/list?isEdit=1");
	}

	//检查用户名是否可用
	@RequestMapping(value = "check", method = RequestMethod.GET)
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 解决返回中文乱码问题
		response.setCharacterEncoding("utf-8");
		String name = request.getParameter("name");
		String id = request.getParameter("id");
		// 解决接收中文乱码问题
		name = new String(name.getBytes("iso-8859-1"), "utf-8");
		
		Company getByName = companyService.getCompanyByName(name);
		String msg = null;
		if(id==null||id.isEmpty())
		{
			if (getByName == null) {
				msg = "The Name is available!";
			} else {
				msg = "The name has been used!";
			}
		}
		else
		{
			Company getById = companyService.getCompanyById(Integer.parseInt(id));
			if (getById.getName().equals(name) || getByName == null) {
				msg = "The Name is available!";
			} else {
				msg = "The name has been used!!";
			}
			
		}
		response.getWriter().print(msg);

	}

	@RequestMapping(value = "check", method = RequestMethod.POST)
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
