package com.database.icms.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.database.icms.domain.Car;
import com.database.icms.domain.Company;
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
			@RequestParam( value="plateNumber",required = false ) String plateNumber ,
			@RequestParam( value="type",required = false ) String type ,
			@RequestParam(value="startTime",required=false) String startTimeString ,
			@RequestParam(value="endTime",required=false) String endTimeString ,
			@RequestParam( value="isEdit" ,defaultValue="0") Integer isEdit
	) throws ParseException
	{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date startTime = null,endTime=null ;
		if(startTimeString!=null && !startTimeString.isEmpty())
			startTime = sdf.parse(startTimeString);
		if(startTimeString!=null && !startTimeString.isEmpty())
			startTime = sdf.parse(startTimeString);
		int totalPage ;
		ModelAndView mav = new ModelAndView("fare/list") ;
		//获取当前公司
		if(companyId==0) 
			companyId = companyService.getSessionCompany().getId();	
//		String companyName = companyService.getSessionCompany().getName();
//		System.out.println("当前公司Id: "+companyId);
//		System.out.println("当前公司name: "+companyName);
		mav.addObject("page",page) ;
		mav.addObject("max",max) ;
		try{
		
		List<Fare> fareList = new ArrayList<Fare>() ;
		int flag = 1;
		if(companyId!=1){
			if(plateNumber!=null && !plateNumber.isEmpty()){
				Car car ;
				car = carService.loadByPlateNumber(companyId, plateNumber) ;
				if(car == null){
					flag = 0 ;
				}
			}
		}
		if(flag == 1){
				System.out.println(startTime);
				fareList = fareService.listDetail(companyId, plateNumber,type,startTime,endTime,
						(page - 1) * max, max);
				totalPage = (fareService.listAllDetailSize(companyId, plateNumber,type,startTime,endTime) + max - 1) / max;
				//totalPage  =(fareService.findAllFare().size() + max - 1) /max ;
				mav.addObject("fare",fareList) ;
				mav.addObject("totalPage",totalPage) ;
		}
		else{
			totalPage= 0 ;
		}
		mav.addObject("plateNumber",plateNumber) ;
		mav.addObject("type",type) ;
		mav.addObject("isEdit",isEdit) ;
		mav.addObject("startTime",startTime);
		mav.addObject("endTime",endTime);
		mav.addObject("companyId",companyId) ;
		}catch(ServiceException e){
			e.printStackTrace(); 
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
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date date = sdf.parse(dateString);
			Fare fare = new Fare() ;
			Car car = new Car();
			car = carService.loadByPlateNumber(companyId, plateNumber);
			fare.setExpense(expense);
			fare.setOperator(operator);
			fare.setDate(date);
			fare.setType(type);
			fare.setCar(car);
			fareService.save(fare) ;
			ModelAndView mav = new ModelAndView("redirect:/fare/list");
			mav.addObject("companyId",companyId);
			mav.addObject("plateNumber",plateNumber) ;
			return mav;
		}
		
	}
	//更新费用
	@RequestMapping(value="/update",method=RequestMethod.GET)
	public ModelAndView UpdateFare(
			@RequestParam(value="id",required=true)Integer id ,
			@RequestParam(value="companyId",defaultValue="0")Integer companyId,
			@RequestParam(value="expense",required=false)Double expense ,
			@RequestParam(value="operator",required=false)String operator,
			@RequestParam(value="date",required=false) String dateString ,
			@RequestParam(value="type",required=false) String type,
			@RequestParam(value="plateNumber",required=false) String plateNumber
			) throws ParseException
	{
		if(companyId==0){
			companyId=companyService.getSessionCompany().getId();
		}
		if (operator==null || operator.isEmpty()||plateNumber == null || plateNumber.isEmpty() || expense==null ||operator==null||operator.isEmpty()) {
			System.out.println(id);
			ModelAndView mav = new ModelAndView("fare/update");
			Fare fare = fareService.getFareById(id);
			mav.addObject("fare", fare);
			String tmp = fare.getDate().toString();
			String date = new String() ;
			for(int i = 0 ;i<tmp.length();i++){
				if(tmp.charAt(i)==' ') break ;
				date+=String.valueOf(tmp.charAt(i));
			}
			mav.addObject("date",date) ;
			System.out.println(fare.getId());
			System.out.println(fare.getOperator());
			return mav;
		}
		else{
			ModelAndView mav = new ModelAndView("redirect:/fare/list?isEdit=1") ;
			Fare fare_be_updated = fareService.getFareById(id);
			Car car = new Car();
			car = carService.loadByPlateNumber(companyId, plateNumber);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date date = sdf.parse(dateString);
			fare_be_updated.setCar(car);
			fare_be_updated.setDate(date);
			fare_be_updated.setExpense(expense);
			fare_be_updated.setOperator(operator);
			fare_be_updated.setType(type) ;
			fareService.update(fare_be_updated);
			return mav; 
		}
	}
	//删除费用
	
	@RequestMapping(value="/delete",method=RequestMethod.GET)
		public String deleteFareById(
				@RequestParam(value="id",required=true)Integer id 
				) {
		fareService.deleteFareById(id) ;
		return "redirect:/fare/list?isEdit=1";
	}
}