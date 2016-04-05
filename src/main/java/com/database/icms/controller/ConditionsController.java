package com.database.icms.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.SystemException;
import javax.validation.Valid;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.database.icms.domain.Company;
import com.database.icms.domain.Conditions;
import com.database.icms.service.CompanyService;
import com.database.icms.service.ConditionsService;

@Controller
@RequestMapping("/conditions")
public class ConditionsController {

	@Autowired
	private ConditionsService conditionsService;

	@Autowired
	private CompanyService companyService;

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ModelAndView listConditions(
			@RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "10") Integer max,
			@RequestParam(value = "companyId", defaultValue = "0") Integer companyId,
			@RequestParam(value = "car", required = false) String carInfo,
			@RequestParam(value = "employee", required = false) String employeeInfo,
			@RequestParam(value = "lendTime", required = false) Date lendTime,
			@RequestParam(value = "returnTime", required = false) Date returnTime,
			@RequestParam(value = "isEdit", defaultValue = "0") Integer isEdit) {
		ModelAndView mav = new ModelAndView("/conditions/list");
		mav.addObject("page", page);
		mav.addObject("max", max);
		try {
			List<Conditions> conditionsList = null;
			int totalPage;
			//获得当前登陆公司
			if (companyId == 0)
				companyId = companyService.getSessionCompany().getId();
			String companyName = companyService.getCompanyById(companyId).getName();
			System.out.println("当前公司Id: "+companyId);
			System.out.println("carInfo: "+carInfo);
			System.out.println("employeeInfo: "+employeeInfo);

			conditionsList = conditionsService.listDetail(companyId, carInfo, employeeInfo, lendTime, returnTime,
					(page - 1) * max, max);
			if (null == conditionsList || conditionsList.isEmpty()) {
				totalPage = 0;
			} else {
				totalPage = (conditionsService.listAllDetailSize(companyId, carInfo, employeeInfo, lendTime, returnTime) + max - 1) / max;
			}
			mav.addObject("companyId", companyId);
			mav.addObject("companyName", companyName);
			mav.addObject("car", carInfo);
			mav.addObject("employee", employeeInfo);
			mav.addObject("lendTime", lendTime);
			mav.addObject("returnTime", returnTime);
			mav.addObject("conditionsList", conditionsList);
			mav.addObject("totalPage", totalPage);
			mav.addObject("isEdit", isEdit);
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public ModelAndView addGet(@RequestParam(value = "companyId") Integer companyId) throws SystemException {
		ModelAndView mav = new ModelAndView("conditions/add");
		try {
			Conditions conditions = new Conditions();
			Company company = companyService.getCompanyById(companyId);
			if(company == null)
				throw new SystemException("Company Can't Be Null!");
			conditions.setCompany(company);
			mav.addObject("companyId", companyId);
			mav.addObject("conditions", conditions);
			return mav;
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public ModelAndView addPost(@Valid @ModelAttribute Conditions conditions, BindingResult bindingResult) {
		ModelAndView mav = new ModelAndView("conditions/add");
		
		System.out.println("conditions: car-"+conditions.getCar().getId()+"; employee-"+conditions.getEmployee().getId()+"; lendTime-"+conditions.getLendTime());
		
		try {
			if (bindingResult.hasErrors()) {
				mav.setViewName("/conditions/add");
				return mav;
			}
			if (conditions.getLendTime().after(new Date(System.currentTimeMillis()))) {
				FieldError error = new FieldError("conditions", "lendTime",
						"LendTime must before current");
				bindingResult.addError(error);
				mav.setViewName("/conditions/add");
				return mav;
			}
			conditionsService.save(conditions);
			mav.setView(new RedirectView("/conditions/list.html", true));
			return mav;
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@RequestMapping(value = "/delete")
	public String delete(@RequestParam(value = "id") Integer id, HttpServletRequest request) throws SystemException {
		try {
			Conditions conditions = conditionsService.load(id);
			if (null == conditions)
				throw new SystemException("Invalid Conditions Id");
			conditionsService.delete(conditions);
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		return "redirect:" + request.getHeader("Referer");
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public ModelAndView update(@RequestParam(value = "id") Integer id) throws SystemException {
		try {
			Conditions conditions = conditionsService.load(id);
			if (null == conditions)
				throw new SystemException("Invalid Conditions Id");
			ModelAndView mav = new ModelAndView("conditions/update");
			mav.addObject("conditions", conditions);
			return mav;
		} catch (ServiceException e) {
			throw new SystemException(e.getMessage());
		}
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public ModelAndView updateSave(@Valid @ModelAttribute Conditions conditions,
			BindingResult bindingResult) throws SystemException {
		ModelAndView mav = new ModelAndView("");
		try {
			if (bindingResult.hasErrors()) {
				mav.setViewName("/conditions/update");
				return mav;
			}
			conditionsService.update(conditions);
			mav.setView(new RedirectView("/conditions/list.html", true));
			return mav;
		} catch (ServiceException e) {
			throw new SystemException(e.getMessage());
		}
	}

	@InitBinder
    public void initBinder(WebDataBinder binder) {
        CustomDateEditor editor = new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"), true);
        binder.registerCustomEditor(Date.class, editor);
    }

}
