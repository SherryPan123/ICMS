package com.database.icms.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.database.icms.domain.Car;
import com.database.icms.service.CarService;

@Controller
@RequestMapping("/car")
public class CarController {

	@Autowired
	private CarService carService;
	
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String addCar(ModelMap model) {
		Car car = new Car();
		model.addAttribute("car", car);
		return "car/add";
	}
	
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String saveCar(@Valid Car car, BindingResult result, ModelMap model) {
		if(result.hasErrors()) {
			return "car/add";
		}
		carService.saveCarForm(car);
		model.addAttribute("success", "Car " + car.getPlateNumber() + "-" + car.getCarType() + "has been added");
		return "car/list";
	}
	
}
