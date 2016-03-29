package com.database.icms.controller;

import java.sql.Date;
import java.util.List;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.database.icms.domain.Car;
import com.database.icms.domain.Conditions;
import com.database.icms.domain.Employee;
import com.database.icms.service.CarService;
import com.database.icms.service.CompanyService;
import com.database.icms.service.ConditionsService;
import com.database.icms.service.EmployeeService;

@Controller
@RequestMapping("/conditions")
public class ConditionsController {

	@Autowired
	private ConditionsService conditionsService;

	@Autowired
	private CompanyService companyService;

	@Autowired
	private CarService carService;

	@Autowired
	private EmployeeService employeeService;

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ModelAndView listConditions(
			@RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "10") Integer max,
			@RequestParam(value = "id", defaultValue = "0") Integer companyId,
			@RequestParam(value = "car", required = false) String carInfo,
			@RequestParam(value = "employee", required = false) String employeeInfo,
			@RequestParam(value = "lendTime", required = false) Date lendTime,
			@RequestParam(value = "returnTime", required = false) Date returnTime,
			@RequestParam(value = "isEdit", defaultValue = "0") Integer isEdit) {
		ModelAndView mav = new ModelAndView("/conditions/list");
		mav.addObject("page", page);
		mav.addObject("max", max);
		try {
			//获得当前登陆公司
			companyId = companyService.getSessionCompany().getId();
			int totalPage;
			if ((carInfo == null || carInfo.isEmpty()) && (employeeInfo == null || employeeInfo.isEmpty())
				&& (lendTime == null) && (returnTime == null)) {
				List<Conditions> condtionsList = conditionsService.list((page-1) * max, max);
				if(condtionsList == null) {
					totalPage = 0;
				} else {
					totalPage = (condtionsList.size() + max-1) / max;
				}
				mav.addObject("totalPage", totalPage);
			} else {
				Integer carId = -1, employeeId = -1;
				Car car = null;
				Employee employee = null;
				int flag = 1; //标记查询是否有效，0无效
				if(null != carInfo && !carInfo.equals("")) {
					try {
						car = carService.loadByPlateNumber(carInfo);
					} catch (Exception e) {
						car = carService.loadByCarType(carInfo);
					}
					if (null == car) {
						flag = 0;
					} else {
						carId = car.getId();
					}
				}
				if(null != employeeInfo && employeeInfo.equals("")) {
					try {
						employee = employeeService.loadByEmployeeId(employeeInfo);
					} catch (Exception e) {
						employee = employeeService.loadByName(employeeInfo);
					}
					if (null == employee) {
						flag = 0;
					} else {
						employeeId = employee.getId();
					}
				}
				List<Conditions> conditionsList = null;
				if (flag == 1) {
					conditionsList = conditionsService.listDetail(companyId, carId, employeeId, lendTime, returnTime,
							(page - 1) * max, max);
					totalPage = (conditionsList.size() + max - 1) / max;
				} else {
					totalPage = 0;
				}

				mav.addObject("id", companyId);
				mav.addObject("car", carInfo);
				mav.addObject("employee", employeeInfo);
				mav.addObject("lendTime", lendTime);
				mav.addObject("returnTime", returnTime);
				mav.addObject("conditionsList", conditionsList);
				mav.addObject("totalPage", totalPage);
			}
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		return mav;
	}

}
