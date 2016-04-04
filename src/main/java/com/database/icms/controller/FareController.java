package com.database.icms.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.database.icms.domain.Car;
import com.database.icms.domain.Fare;
import com.database.icms.service.CarService;
import com.database.icms.service.CompanyService;
import com.database.icms.service.FareService;

@Controller
@RequestMapping("/fare")
public class FareController {
	@Autowired 
	private FareService fareService ;
	@Autowired
	private CompanyService companyService ;
	@Autowired
	CarService carService ;
	@RequestMapping(value="list",method=RequestMethod.GET)
	public ModelAndView listAllFare(
			@RequestParam(value="companyId",defaultValue="0")Integer companyId,
			@RequestParam( defaultValue = "1") Integer page,
			@RequestParam( defaultValue = "50") Integer max,
			@RequestParam( value="name",required = false ) String name
	)
	{
		ModelAndView mav = new ModelAndView("fare/list") ;
		//获取当前公司
		if(companyId==0) 
			companyId = companyService.getSessionCompany().getId();	
//		String companyName = companyService.getSessionCompany().getName();
//		System.out.println("当前公司Id: "+companyId);
//		System.out.println("当前公司name: "+companyName);
		mav.addObject("page",page) ;
		mav.addObject("max",max) ;
		mav.addObject("name",name) ;
		mav.addObject("companyId",companyId) ;
		List<Fare> fareList = new ArrayList<Fare>() ;
		if(companyId == 1){
			fareList = fareService.findAllFareByPage(page,max) ;
			int totalPage  =(fareService.findAllFare().size() + max - 1) /max ;
			mav.addObject("fare",fareList) ;
			mav.addObject("totalPage",totalPage) ;
		}
		else if(companyId!=0){
			fareList = fareService.findCompanyFareByPage(companyId,page,max) ;
			int totalPage = (fareService.findAllFareByCompany(companyId).size())/max+1 ;
			mav.addObject("fare",fareList) ;
			mav.addObject("totalPage",totalPage);
		}
		return mav ;
	}
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public ModelAndView AddFare(
			@RequestParam(value="expense",required=false)Double expense ,
			@RequestParam(value="operator",required=false)String operator,
			@RequestParam(value="date",required=false) String dateString ,
			@RequestParam(value="type",required=false) String type,
			@RequestParam(value="plateNumber",required=false) String plateNumber
			) throws ParseException
	{
		System.out.println(expense) ;
		System.out.println(operator) ;
		System.out.println(dateString) ;
		System.out.println(type) ;
		System.out.println(plateNumber) ;
		Integer companyId= companyService.getSessionCompany().getId() ;
		if(operator==null||operator.isEmpty()||plateNumber==null||plateNumber.isEmpty()){
			ModelAndView mav = new ModelAndView("fare/add");
			mav.addObject("companyId",companyId) ;
			return mav ;
		}
		else{		
			System.out.println("1");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date date = sdf.parse(dateString);
			Fare fare = new Fare() ;
			Car car = new Car();
			car = carService.loadByPlateNumber(companyId, plateNumber);
			System.out.println(car.getId());
			System.out.println("2");
			fare.setExpense(expense);
			fare.setOperator(operator);
			fare.setDate(date);
			fare.setType(type);
			fare.setCar(car);
			System.out.println("3");
			fareService.save(fare) ;
			System.out.println("5");
			ModelAndView mav = new ModelAndView("redirect:/fare/list");
			return mav;
		}

	}
	
}
