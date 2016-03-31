package com.database.icms.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.database.icms.domain.Car;
import com.database.icms.domain.Company;
import com.database.icms.service.CarService;
import com.database.icms.service.CompanyService;

import java.util.*;

@Controller
@RequestMapping("/car")
public class CarController {

	@Autowired
	private CarService carService;
	@Autowired
	private CompanyService companyService;

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ModelAndView listCar(
			@RequestParam(defaultValue = "1", value = "page", required = false) Integer page,
			@RequestParam(defaultValue = "10", value = "max", required = false) Integer max,
			@RequestParam(value = "carType", required = false) String carType,
			@RequestParam(value = "plateNumber", required = false) String plateNumber,
			@RequestParam(value = "status", defaultValue = "2") Integer status,
			// 0代表不需要被编辑,1代表需要被编辑
			@RequestParam(value = "isEdit", defaultValue = "0") Integer isEdit) 
	{
		ModelAndView mav = new ModelAndView();
		Company currentCompany = companyService.getSessionCompany();
		
		mav.addObject("page", page);
		mav.addObject("max",max);
		mav.addObject("carType",carType);
		mav.addObject("plateNumber",plateNumber);
		mav.addObject("status", status);
		mav.addObject("isEdit", isEdit);
		if ((carType == null || carType.isEmpty()) && (plateNumber == null || plateNumber.isEmpty())) 
		{
			Integer totalPage = ( carService.findAllCarByCompany(currentCompany).size() + max - 1 ) / max;
			List<Car> carList = carService.getCarByCompany(page, max, currentCompany);
			mav.addObject("totalPage",totalPage);
			mav.addObject("cars", carList);
			mav.setViewName("car/list");
		}
		else
		{
			if(carType==""||carType.isEmpty()) carType="";
			if(plateNumber==""||plateNumber.isEmpty()) plateNumber="";
			
			List<Car> carList = carService.findCarByInfo(page,max,carType,plateNumber,currentCompany);
			Integer totalPage = ( carList.size() + max - 1 ) / max;
			mav.addObject("totalPage",totalPage);
			mav.addObject("cars",carList);
			mav.setViewName("car/list");
		}
		return mav;
	}

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String addCar(ModelMap model) {
		Car car = new Car();
		model.addAttribute("car", car);
		return "car/add";
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String saveCar(@Valid Car car, BindingResult result, ModelMap model) {
		if (result.hasErrors()) {
			return "car/add";
		}
		carService.saveCarForm(car);
		model.addAttribute("success", "Car " + car.getPlateNumber() + "-" + car.getCarType() + "has been added");
		return "car/list";
	}

}
