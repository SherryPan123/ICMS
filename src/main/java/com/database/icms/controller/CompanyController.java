package com.database.icms.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
			
			mav.addObject("companies",companyList);
			mav.addObject("totalPage",totalPage);
		}
		else
		{
			companyList = companyService.findCompanyByVagueName(name);
			int totalPage = (companyList.size() + max - 1) / max;
			
			mav.addObject("companies",companyList);
			mav.addObject("totalPage",totalPage);
			
		}
		return mav;
	}

	// 根据id删除公司
	@RequestMapping(value = "delete", method = RequestMethod.GET)
	public String deleteCompanyByName(@RequestParam Integer id, ModelMap model) {
		if (companyService.deleteCompanyById(id)) {
			return "redirect:/company/list?isEdit=1";
		} else 
		{
			return "company/list?isEdit=1";
		}
	}

	// 添加公司
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public ModelAndView addCompany(
		@RequestParam(value="name",required=false) String name,
		@RequestParam(value="password",required=false) String password,
		@RequestParam(value="address",defaultValue="",required=false) String address,
		@RequestParam(value="phone",defaultValue="",required=false) String phone
			) 
	{
		if(name==null||name.isEmpty()||(password==null)||password.isEmpty())
		{
			ModelAndView mav = new ModelAndView("company/add");
			return mav;
		}
		else
		{
			Company company = new Company();
			Role role = roleService.getRoleByName("company");
			
			company.setAddress(address);
			company.setName(name);
			company.setPassword(new BCryptPasswordEncoder().encode(password));
			company.setPhone(phone);
			company.setRole(role);
			
			companyService.save(company);
			ModelAndView mav = new ModelAndView("redirect:/company/list");
			return mav;
		}
		
	}

	// 更新公司信息
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public ModelAndView updatedCompany(
			@RequestParam(value="id",required=true) Integer id,
			@RequestParam(value="name",required=false) String name,
			@RequestParam(value="password",required=false) String password,
			@RequestParam(value="address",defaultValue="",required=false)String address,
			@RequestParam(value="phone",defaultValue="",required=false)String phone
			) 
	{
		if(name==null||name.isEmpty())
		{
			ModelAndView mav = new ModelAndView("company/update");
			Company company = companyService.getCompanyById(id);
			mav.addObject("company", company);
			return mav;
		}
		else
		{
			ModelAndView mav = new ModelAndView("redirect:/company/list");
			Role role;
			Company company_be_updated = companyService.getCompanyById(id);
			if (name.equals("ICMS")) role = roleService.getRoleByName("admin");
			else role = roleService.getRoleByName("company");
			
			//确定密码是否更改过，若更改过则对新密码加密并保存
			if (!(company_be_updated.getPassword().equals(password))) {
				company_be_updated.setPassword(new BCryptPasswordEncoder().encode(password));
			}
			company_be_updated.setName(name);
			company_be_updated.setPhone(phone);
			company_be_updated.setRole(role);
			company_be_updated.setAddress(address);
			companyService.update(company_be_updated);
			return mav;
		}
		
	}

	//检查用户名是否可用
	@RequestMapping(value = "/check")
	@ResponseBody
	protected String checkCompanyNameAvailable(String username, String id) throws ServletException, IOException {
		Company getByUserame = companyService.getCompanyByUsername(username);
		String msg = null;
		if (id == null || id.isEmpty()) {
			if (getByUserame == null) {
				msg = "The name is available!";
			} else {
				msg = "The name has been used!";
			}
		} else {
			Company getById = companyService.getCompanyById(Integer.parseInt(id));
			if (getById.getUsername().equals(username) || getByUserame == null) {
				msg = "The name is available!";
			} else {
				msg = "The name has been used!!";
			}
		}
		return msg;
	}

}
