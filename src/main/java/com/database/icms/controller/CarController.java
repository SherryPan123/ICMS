package com.database.icms.controller;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.database.icms.domain.Car;
import com.database.icms.domain.Company;
import com.database.icms.service.CarService;
import com.database.icms.service.CompanyService;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

@Controller
@RequestMapping("/car")
public class CarController {

	@Autowired
	private CarService carService;

	@Autowired
	private CompanyService companyService;

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

	@RequestMapping(value = "/getCarInJson", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String getProblemInJson(@RequestParam("companyId") Integer companyId,
			@RequestParam("plateNumber") String plateNumber, HttpServletRequest request) {
		Gson gson = new Gson();
		try {
			Company company = companyService.getCompanyById(companyId);
			if (null == company) {
				JsonObject root = new JsonObject();
				root.addProperty("success", false);
				root.addProperty("msg", "Invalid Company Id");
				System.out.println(gson.toJson(root));
				return gson.toJson(root);
			}
			Car car = carService.loadByPlateNumber(companyId, plateNumber);
			if (null == car) {
				JsonObject root = new JsonObject();
				root.addProperty("success", false);
				root.addProperty("msg", "No Car Found");
				System.out.println(gson.toJson(root));
				return gson.toJson(root);
			}
			JsonObject root = new JsonObject();
			root.addProperty("success", true);
			root.addProperty("id", car.getId());
			root.addProperty("carType", car.getCarType());
			System.out.println(gson.toJson(root));
			return gson.toJson(root);

		} catch (ServiceException e) {
			JsonObject root = new JsonObject();
			root.addProperty("success", false);
			root.addProperty("msg", e.getMessage());
			System.out.println(gson.toJson(root));
			return gson.toJson(root);
		}
	}

}
