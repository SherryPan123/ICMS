package com.database.icms.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.transaction.SystemException;
import javax.validation.Valid;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.database.icms.domain.Company;
import com.database.icms.domain.Role;
import com.database.icms.service.CompanyService;
import com.database.icms.service.RoleService;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

@Controller
@RequestMapping("/company")
public class CompanyController {

	@Autowired
	private CompanyService companyService;

	@Autowired
	private RoleService roleService;

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ModelAndView listAllCompany(@RequestParam(defaultValue = "1") Integer page,
			@RequestParam(defaultValue = "10") Integer max, @RequestParam(value = "name", required = false) String name,
			// 0代表不需要被编辑,1代表需要被编辑
			@RequestParam(value = "isEdit", defaultValue = "0") Integer isEdit) {
		ModelAndView mav = new ModelAndView("company/list");

		mav.addObject("max", max);
		mav.addObject("isEdit", isEdit);
		mav.addObject("name", name);

		List<Company> companyList = new ArrayList<Company>();
		if (name == null || name.isEmpty()) {
			int totalPage = (companyService.findAllCompany().size() + max - 1) / max;
			if (page > totalPage)
				page = totalPage;
			companyList = companyService.findAllCompanyByPage(page, max);
			mav.addObject("page", page);
			mav.addObject("companies", companyList);
			mav.addObject("totalPage", totalPage);
		} else {
			int totalPage = (companyService.findCountByVagueName(name) + max - 1) / max;
			if (page > totalPage)
				page = totalPage;
			companyList = companyService.findCompanyByVagueNameByPage(page, max, name);

			mav.addObject("page", page);
			mav.addObject("companies", companyList);
			mav.addObject("totalPage", totalPage);

		}
		mav.addObject("company",new Company());
		return mav;
	}

	// 根据id删除公司
	@RequestMapping(value = "delete", method = RequestMethod.GET)
	public String deleteCompanyByName(@RequestParam Integer id,
			@RequestParam(value = "name", required = false) String name, @RequestParam Integer page) {
		companyService.deleteCompanyById(id);
		return "redirect:/company/list?isEdit=1&name=" + name + "&page=" + page;
	}

	// 添加公司(不适用ajax方式)
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public ModelAndView addCompany(@RequestParam(value = "username", required = false) String username,
			@RequestParam(value = "name", required = false) String name,
			@RequestParam(value = "password", required = false) String password,
			@RequestParam(value = "address", defaultValue = "", required = false) String address,
			@RequestParam(value = "phone", defaultValue = "", required = false) String phone) {
		if (name == null || name.isEmpty() || (password == null) || password.isEmpty()) {
			ModelAndView mav = new ModelAndView("company/add");
			return mav;
		} else {
			Company company = new Company();
			Role role = roleService.getRoleByName("company");

			company.setAddress(address);
			company.setName(name);
			company.setUsername(username);
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
	public ModelAndView updatedCompany(@RequestParam(value = "id", required = true) Integer id,
			@RequestParam(value = "username", required = false) String username,
			@RequestParam(value = "name", required = false) String name,
			@RequestParam(value = "password", required = false) String password,
			@RequestParam(value = "address", defaultValue = "", required = false) String address,
			@RequestParam(value = "phone", defaultValue = "", required = false) String phone) {
		if (username == null || username.isEmpty()) {
			ModelAndView mav = new ModelAndView("company/update");
			Company company = companyService.getCompanyById(id);
			mav.addObject("company", company);
			return mav;
		} else {
			ModelAndView mav = new ModelAndView("redirect:/company/list?isEdit=1");
			Role role;
			Company company_be_updated = companyService.getCompanyById(id);
			if (username.equals("ICMS"))
				role = roleService.getRoleByName("admin");
			else
				role = roleService.getRoleByName("company");

			// 确定密码是否更改过，若更改过则对新密码加密并保存
			if (!(company_be_updated.getPassword().equals(password))) {
				company_be_updated.setPassword(new BCryptPasswordEncoder().encode(password));
			}
			System.out.println("************" + company_be_updated.getPassword());
			company_be_updated.setUsername(username);
			company_be_updated.setName(name);
			company_be_updated.setPhone(phone);
			company_be_updated.setRole(role);
			company_be_updated.setAddress(address);
			companyService.update(company_be_updated);
			return mav;
		}
	}

	// 检查用户名是否可用
	@RequestMapping(value = "/check")
	@ResponseBody
	protected String checkCompanyNameAvailable(String username, String id) throws ServletException, IOException {
		Company getByUserame = companyService.getCompanyByUsername(username);
		String msg = null;
		if (id == null || id.isEmpty()) {
			if (getByUserame == null) {
				msg = "The Username is available!";
			} else {
				msg = "The Username has been used!";
			}
		} else {
			Company getById = companyService.getCompanyById(Integer.parseInt(id));
			if (getById.getUsername().equals(username) || getByUserame == null) {
				msg = "The Username is available!";
			} else {
				msg = "The Username has been used!!";
			}
		}
		//System.out.println(msg);
		return msg;
	}

	// 添加公司(使用JSON方式)
	@RequestMapping(value = "/addJSON", method = RequestMethod.POST)
	@ResponseBody
	public String addPOSTJSON(@Valid @ModelAttribute Company company, BindingResult result) throws SystemException {
		Gson gson = new Gson();
		JsonObject jo = new JsonObject();
		try {
			if (result.hasErrors()) {
				jo.addProperty("success", false);
				jo.addProperty("msg","Invalid Message!");
				System.out.println(result.getFieldError().toString());
				return gson.toJson(jo);
			}
			else
			{
				if(company.getId()==null)
				{
					Role role = roleService.getRoleByName("company");
					company.setRole(role);
					company.setPassword(new BCryptPasswordEncoder().encode(company.getPassword()));
					companyService.save(company);
				}
				else
				{
					System.out.println("Update****************");
					Company cmy = companyService.getCompanyById(company.getId());
					System.out.println(cmy.getPassword()+"****************");
					System.out.println(company.getPassword()+"***************");
					// 确定密码是否更改过，若更改过则对新密码加密并保存
					if (!(cmy.getPassword().equals(company.getPassword()))) {
						company.setPassword(new BCryptPasswordEncoder().encode(company.getPassword()));
					}
					companyService.update(company);
				}
				jo.addProperty("success", true);
				jo.addProperty("msg","success");
				return gson.toJson(jo);
			}
			
		} catch (ServiceException e) {
			throw new SystemException(e.getMessage());
		}
	}
	@RequestMapping(value="/getCompanyInJson",method=RequestMethod.GET, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String getCompanyInJson(@RequestParam(value="companyId") Integer company_id)
	{
		Gson gson = new Gson();
		JsonObject jo = new JsonObject();
		Company company = companyService.getCompanyById(company_id);
		System.out.println(company.toString());
		jo.addProperty("id",company.getId());
		jo.addProperty("username",company.getUsername());
		jo.addProperty("name",company.getName());
		jo.addProperty("password",company.getPassword());
		jo.addProperty("addredd",company.getAddress());
		jo.addProperty("phone",company.getPhone());
		
		//System.out.println(gson.toJson(jo));
		
		return gson.toJson(jo);
	}
}
