package com.database.icms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.database.icms.service.CompanyService;
import com.database.icms.domain.Company;
import java.util.*;

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
}