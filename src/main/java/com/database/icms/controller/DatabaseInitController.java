package com.database.icms.controller;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.database.icms.domain.Company;
import com.database.icms.domain.Role;
import com.database.icms.service.CompanyService;
import com.database.icms.service.RoleService;

@Controller
public class DatabaseInitController {

	@Autowired
    private RoleService roleService;
	
	@Autowired
	private CompanyService companyService;
	
	@RequestMapping(value = "/initDatabase", method = RequestMethod.GET)
	@Transactional
	public String initDatabase() {
		System.out.println("开始初始化数据库");
		
		//初始化角色
		Role role = new Role();
		role.setName("ROLE_admin");
		roleService.save(role);
		role = new Role();
		role.setName("company");
		roleService.save(role);
		
		//初始化公司/管理员
		Company company = new Company();
		company.setName("ICMS");
		company.setPassword(new BCryptPasswordEncoder().encode("ICMS"));
		System.out.println("1");
		company.setRole(roleService.getRoleByName("admin"));
		System.out.println("2");
		company.setRole(roleService.getRoleByName("ROLE_admin"));
		companyService.save(company);
		System.out.println("3");
		company = new Company();
		company.setName("company1");
		company.setPassword(new BCryptPasswordEncoder().encode("123456"));
		company.setRole(roleService.getRoleByName("company"));
		companyService.save(company);
		
		System.out.println("初始化数据库完成");
		return "redirect:/";
	}
	
}
