package com.database.icms.controller;

import javax.servlet.ServletException;
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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.annotation.ResponseBody;

import com.database.icms.domain.Car;
import com.database.icms.domain.Company;
import com.database.icms.service.CarService;
import com.database.icms.service.CompanyService;

import java.io.IOException;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

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
			@RequestParam(value = "searchPlateNumber", required = false) String searchPlateNumber,
			// 表示要查看何种类型的车辆，0代表不可用车辆，1代表可用车辆，-1代表可用与不可用车辆都看
			@RequestParam(value = "status", defaultValue = "-1") Integer status,
			// 0代表不需要被编辑,1代表需要被编辑
			@RequestParam(value = "isEdit", defaultValue = "0") Integer isEdit,
			// company_id用于管理员(ICMS)权限下查看各个公司
			@RequestParam(value = "company_id", required = false) Integer company_id
			)
	{
		ModelAndView mav = new ModelAndView();
		Company currentUser = companyService.getSessionCompany();
		Company aimCompany = null;

		mav.addObject("page", page);
		mav.addObject("max", max);
		if(carType==null || carType.isEmpty()) carType="";
		mav.addObject("carType", carType);
		if(searchPlateNumber==null || searchPlateNumber.isEmpty())searchPlateNumber="";
		mav.addObject("searchPlateNumber", searchPlateNumber);
		mav.addObject("status", status);

		// 管理员只能看页面，不能对页面进行增删改查
		if (currentUser.getUsername() != "ICMS")
			mav.addObject("isEdit", isEdit);
		else
			mav.addObject("isEdit", 0);

		// 如果当前用户是管理员，那么要查看的公司从company_id中来，如果不是那么要查看的公司就是当前公司
		if (currentUser.getUsername() == "ICMS") {
			aimCompany = companyService.getCompanyById(company_id);
			mav.addObject("company_id", company_id);
		} else {
			aimCompany = companyService.getSessionCompany();
			mav.addObject("company_id", aimCompany.getId());
		}

		if (carType == "" && searchPlateNumber == "") {
			Integer totalPage = (carService.findAllCarByCompany(aimCompany, status).size() + max - 1) / max;
			List<Car> carList = carService.getCarByCompany(page, max, aimCompany, status);
			mav.addObject("totalPage", totalPage);
			mav.addObject("cars", carList);
			mav.setViewName("car/list");
		} else {
			List<Car> carList = carService.findCarByInfo(page,max, carType, searchPlateNumber, aimCompany, status);
			Integer totalPage = (carList.size() + max - 1) / max;
			mav.addObject("totalPage", totalPage);
			mav.addObject("cars", carList);
			mav.setViewName("car/list");
		}
		return mav;
	}

	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public ModelAndView deleteCar(@RequestParam(value = "car_id") Integer car_id,
			@RequestParam(value = "company_id", required = false) Integer company_id,
			@RequestParam(value = "status") Integer status) {
		if (company_id == null) {
			Company currentUser = companyService.getSessionCompany();
			company_id = currentUser.getId();
		}
		ModelAndView mav = new ModelAndView(
				"redirect:/car/list?company_id=" + company_id + "&status=" + status + "&isEdit=1");
		carService.changeStatusToDelete(car_id);
		return mav;
	}

	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public ModelAndView updateCar(@RequestParam(value = "carType", required = false) String carType,
			@RequestParam(value = "carStatus", required = false) String carStatus,
			@RequestParam(value = "plateNumber", required = false) String plateNumber,
			@RequestParam(value = "buyTime", defaultValue = "2000-1-1") String buyTime,
			@RequestParam(value = "car_id") Integer car_id,
			@RequestParam(value = "company_id", required = false) Integer company_id,
			@RequestParam(value = "status") Integer status) throws ParseException {
		ModelAndView mav = new ModelAndView();
		mav.addObject("car_id", car_id);
		mav.addObject("status", status);
		if (company_id == null) {
			Company currentUser = companyService.getSessionCompany();
			company_id = currentUser.getId();
			mav.setViewName("car/update");
		}

		mav.addObject("company_id", company_id);
		Car car = carService.findCarById(car_id);
		if (carType == null || carType.isEmpty() || carStatus == null || plateNumber == null || plateNumber.isEmpty()
				|| buyTime == null) {
			mav.addObject("car", car);
		} else {
			Integer car_status;
			if (carStatus.equals("Available"))
				car_status = 1;
			else if (carStatus.equals("Not Available"))
				car_status = 0;
			else
				car_status = -1;

			// 设置时间
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date date = sdf.parse(buyTime);
			car.setBuyTime(date);

			car.setCarType(carType);
			car.setPlateNumber(plateNumber);
			car.setStatus(car_status);

			carService.updateCar(car);
			mav.setViewName("redirect:/car/list?isEdit=1&status=" + status);
		}
		return mav;
	}

	@RequestMapping(value = "/check")
	@ResponseBody
	protected String checkPlateNumberAvailable(String plateNumber, String id) throws ServletException, IOException {

		// 解决中文乱码
		plateNumber = new String(plateNumber.getBytes("iso-8859-1"), "utf-8");

		System.out.println(plateNumber);

		Car car = carService.findCarByPlateNumber(plateNumber);
		//System.out.println("*************"+id+"***********");
		String msg = null;
		if (id != null) {
			if (car == null || Integer.parseInt(id) == car.getId()) {
				msg = "The Plate Number is available!";
			} else {
				msg = "The Plate Number is not available!";
			}
		} else {
			if (car == null)
				msg = "The Plate Number is available!";
			else
				msg = "The Plate Number is not available!";
		}

		return msg;
	}

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public ModelAndView addCar(
			@RequestParam(value = "company_id", required = true) Integer company_id,
			@RequestParam(value = "plateNumber", required = false) String plateNumber,
			@RequestParam(value = "carType", required = false) String carType,
			@RequestParam(value = "buyTime", required = false) String buyTime,
			@RequestParam(value = "carStatus", required = false) Integer carStatus,
			@RequestParam(value = "pageStatus", required = true) Integer pageStatus,
			@RequestParam(value = "isEdit", required = true) Integer isEdit) throws ParseException {
		ModelAndView mav = new ModelAndView();
		mav.addObject("company_id", company_id);
		mav.addObject("pageStatus", pageStatus);
		mav.addObject("isEdit", isEdit);
		if ((carType == null || carType.isEmpty())
				&& ((carStatus == null) && (plateNumber == null || plateNumber.isEmpty()))) {
			mav.setViewName("car/add");
		} else {
			Car car = new Car();
			Company company = companyService.getCompanyById(company_id);
			car.setCompany(company);
			car.setStatus(carStatus);
			car.setCarType(carType);
			car.setPlateNumber(plateNumber);
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");
			Date date = sdf.parse(buyTime);
			car.setBuyTime(date);

			carService.saveCar(car);
			mav.setViewName("redirect:/car/list?isEdit=" + isEdit + "&status=" + pageStatus);
		}
		return mav;
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
