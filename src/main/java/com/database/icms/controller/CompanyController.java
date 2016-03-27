package com.database.icms.controller;

import java.util.ArrayList;
import java.util.List;

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

	@RequestMapping(value = "list" ,method = RequestMethod.GET)
	public ModelAndView listAllCompany() {
		ModelAndView mav = new ModelAndView("company/list");
		List<Company> companyList = new ArrayList<Company>();
		companyList = companyService.findAllCompany();
		mav.addObject("company", companyList);
		return mav;
	}
	
	// 根据名字询公司
	@RequestMapping(value = "search", method = RequestMethod.GET)
	public ModelAndView searchCompanyByName( @RequestParam(defaultValue = "ICMS" ) String name)
	{
		//System.out.println(name);
		ModelAndView mav = new ModelAndView("company/search");
		Company company = companyService.getCompanyByName(name);
		mav.addObject("company",company);
		return mav;
	}

	// 根据id删除公司
	@RequestMapping(value = "delete-{id}-company", method = RequestMethod.GET)
	public String deleteCompanyByName(@PathVariable String id, ModelMap model) {
		// System.out.println(id);
		if (companyService.deleteCompanyById(id)) {
			List<Company> companyList = new ArrayList<Company>();
			companyList = companyService.findAllCompany();
			model.addAttribute("companyList", companyList);
			return "redirect:/company/list";
		} else {
			return "company/list";
		}
	}
	
	//添加公司
	@RequestMapping(value="add",method=RequestMethod.GET)
	public ModelAndView addCompany()
	{
		ModelAndView mav = new ModelAndView("company/add");
		Company company = new Company();
		mav.addObject("company",company);
		return mav;
	}
	
	@RequestMapping(value="add",method=RequestMethod.POST)
	public ModelAndView saveCompany( @Valid Company company ,BindingResult result)
	{
		if(result.hasErrors())
		{
			return new ModelAndView("redirect:/company/add");
		}
		company.setPassword(new BCryptPasswordEncoder().encode(company.getPassword()));
		Role role = roleService.getRoleByName("company");
		company.setRole(role);
		companyService.save(company);
		return new ModelAndView("redirect:/company/list");
	}
	
	//更新公司信息
	@RequestMapping(value="update",method=RequestMethod.GET)
	public ModelAndView getUpdatedCompany(@RequestParam String name)
	{
		//System.out.println(name);
		ModelAndView mav = new ModelAndView("company/update");
		Company company = companyService.getCompanyByName(name);
		mav.addObject("company",company);
		//System.out.println(company.toString());
		return mav;
	}
	
	@RequestMapping(value="update",method=RequestMethod.POST)
	public ModelAndView updateCompany(@Valid Company company,BindingResult result)
	{
		if( result.hasErrors() ) return new ModelAndView("redirect:company/update");
		
		Role role;
		if(company.getName().equals("ICMS")) role = roleService.getRoleByName("admin");
		else role = roleService.getRoleByName("company");
		
		company.setName(company.getName().substring(company.getName().indexOf(',')+1));
		Company company_be_updated = companyService.getCompanyById(company.getId().toString());
		
		System.out.println(company.getPassword());
		if(!(company_be_updated.getPassword().equals(company.getPassword())))
		{
			company_be_updated.setPassword(new BCryptPasswordEncoder().encode(company.getPassword()));
		}
		company_be_updated.setName(company.getName());
		company_be_updated.setPhone(company.getPhone());
		company_be_updated.setRole(role);
		company_be_updated.setAddress(company.getAddress());
		
		companyService.update(company_be_updated);
		return new ModelAndView("redirect:/company/list");
	}

}


