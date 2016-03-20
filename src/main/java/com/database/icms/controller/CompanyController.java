package com.database.icms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.database.icms.service.CompanyService;
import com.database.icms.domain.Company;
import java.util.*;

import javax.validation.Valid;

@Controller
@RequestMapping("/company")
public class CompanyController
{
	@Autowired
	private CompanyService companyService;
	
	@RequestMapping(value = "/listAllCompany" ,method = RequestMethod.GET)
	public String listAllCompany( ModelMap model )
	{
		List<Company> companyList = new ArrayList<Company>();
		companyList = companyService.findAllCompany();
		model.addAttribute("companyList",companyList);
		return "company/listAllCompany";
	}
	
	//根据名字查询公司
	@RequestMapping(value = "/searchCompanyByName",method = RequestMethod.GET)
	public String searchCompanyByName( ModelMap model )
	{
		Company company = new Company();
		model.addAttribute("company",company);
		return "company/searchCompanyByName";
	}
	
	@RequestMapping( value = "/searchCompanyByName",method = RequestMethod.POST )
	public String listCompanyByName( @Valid Company company, BindingResult result ,ModelMap model )
	{
		//System.out.println(company.getName());
		Company cmy = companyService.getCompanyByName(company.getName());
	    model.addAttribute("company",cmy);
		return "company/listCompanyByName";
	}
	
	//根据名字删除公司
	@RequestMapping(value = "company/delete-{name}-company",method = RequestMethod.GET)
	public String deleteCompanyByName(@PathVariable String name,ModelMap model)
	{
		System.out.println(name);
		//listAllCompany(model);
		//return "redirect:/listAllCompany";
		List<Company> companyList = new ArrayList<Company>();
		companyList = companyService.findAllCompany();
		model.addAttribute("companyList",companyList);
		return "company/listAllCompany";
	}
}