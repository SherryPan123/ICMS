package com.database.icms.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.SystemException;
import javax.validation.Valid;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.database.icms.domain.Car;
import com.database.icms.domain.Fare;
import com.database.icms.service.CarService;
import com.database.icms.service.CompanyService;
import com.database.icms.service.FareService;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

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
			@RequestParam( defaultValue = "10") Integer max,
			@RequestParam( value="searchPlateNumber",required = false ) String plateNumber ,
			@RequestParam( value="searchType",required = false ) String type ,
			@RequestParam(value="startTime",required=false) String startTimeString ,
			@RequestParam(value="endTime",required=false) String endTimeString ,
			@RequestParam( value="isEdit" ,defaultValue="0") Integer isEdit,
			@RequestParam(value="expense" , required=false) Double expense ,	
			@RequestParam(value="operator" ,required = false ) String operator,
			@RequestParam(value="date",required = false) Date date 
	) throws ParseException
	{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date startTime = null,endTime=null ;
		if(startTimeString!=null && !startTimeString.isEmpty())
			startTime = sdf.parse(startTimeString);
		if(endTimeString!=null && !endTimeString.isEmpty())
			endTime = sdf.parse(endTimeString);
		int totalPage ;
		ModelAndView mav = new ModelAndView("fare/list") ;
		//获取当前公司
		if(companyId==0) 
			companyId = companyService.getSessionCompany().getId();	
		mav.addObject("page",page) ;
		mav.addObject("max",max) ;
		try{
			List<Fare> fareList = new ArrayList<Fare>() ;
			fareList = fareService.listDetail(companyId, plateNumber,type,startTime,endTime,
					(page - 1) * max, max);
			totalPage = (fareService.listAllDetailSize(companyId, plateNumber,type,startTime,endTime) + max - 1) / max;
			mav.addObject("fareList",fareList) ;
			mav.addObject("totalPage",totalPage) ;
			if(null == fareList){
				totalPage= 0 ;
			}
			String company_name = companyService.getCompanyById(companyId).getName();
			Fare fare = new Fare();
			mav.addObject("fare",fare);
			mav.addObject("searchPlateNumber",plateNumber) ;
			mav.addObject("searchType",type) ;
			mav.addObject("isEdit",isEdit) ;
			mav.addObject("startTime",startTime);
			mav.addObject("endTime",endTime);
			mav.addObject("companyId",companyId) ;
			mav.addObject("date",date);
			mav.addObject("operator",operator) ;
			mav.addObject("expense",expense);
			mav.addObject("company_name", company_name);
		}catch(ServiceException e){
			e.printStackTrace(); 
		}
		System.out.println("++++++");
		return mav ;
	}
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public ModelAndView AddFare(
			@RequestParam(value="companyId",defaultValue="0") Integer companyId,
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
		if(companyId == 0)
			companyId= companyService.getSessionCompany().getId() ;
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
			mav.addObject("fare",fare);
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
		
		if (operator==null || operator.isEmpty()||plateNumber == null || plateNumber.isEmpty() || expense==null ) {
			System.out.println("id "+id);
			ModelAndView mav = new ModelAndView("fare/update");
			mav.addObject("companyId",companyId);
			Fare fare = fareService.getFareById(id);
			if(fare!=null){
				mav.addObject("fare", fare);
				String tmp = fare.getDate().toString();
				String date = new String() ;
				for(int i = 0 ;i<tmp.length();i++){
					if(tmp.charAt(i)==' ') break ;
					date+=String.valueOf(tmp.charAt(i));
				}
				mav.addObject("date",date) ;
			}
			return mav;
		}
		else{
			ModelAndView mav = new ModelAndView("redirect:/fare/list?isEdit=1") ;
			mav.addObject("companyId",companyId);
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
	
	//addJson(Json 方式添加费用)
	@RequestMapping(value="/addJSON",method=RequestMethod.POST )
	@ResponseBody
	public String addPostJson(@Valid @ModelAttribute Fare fare , BindingResult result)throws SystemException{
		Gson gson = new Gson() ;
		JsonObject jo = new JsonObject() ;
		try{
			if(result.hasErrors()){
				System.out.println("error");
				jo.addProperty("success",false) ;
				return gson.toJson(jo) ;
			}
			else{
//				System.out.println("fare:   "+fare.getDate());
//				System.out.println("fare:   "+fare.getCar().getPlateNumber());
				System.out.println("fare:   "+fare.getCar().getCarType());
				fareService.save(fare);
				jo.addProperty("success", true);
				return gson.toJson(jo) ;
			}
		}catch(ServiceException e){
			throw new SystemException(e.getMessage());
		}
	}
	//getFareJson
	@RequestMapping(value="/getFareInJson",method=RequestMethod.GET , produces = "text/html;charset=UTF-8")
	@ResponseBody 
	public String getCompanyInJson(@RequestParam(value="fareId") Integer fare_id ,HttpServletRequest request) throws ParseException {
		Gson gson = new Gson();
		JsonObject jo = new JsonObject();
		try{
			Fare fare = fareService.getFareById(fare_id) ;
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			jo.addProperty("success", true);
			jo.addProperty("id",fare.getId());
			jo.addProperty("plateNumber",fare.getCar().getPlateNumber());
			jo.addProperty("carType",fare.getCar().getCarType());
			jo.addProperty("type",fare.getType());
			jo.addProperty("operator",fare.getOperator());
			jo.addProperty("date", dateFormat.format(fare.getDate()).toString());
			jo.addProperty("company",fare.getCar().getCompany().getName());		
			jo.addProperty("expense", fare.getExpense());
			return gson.toJson(jo) ;
		}catch(ServiceException e){
			jo.addProperty("success", false);
			jo.addProperty("msg", e.getMessage());
			return gson.toJson(jo);
		}
	}
	
	//update Json方式
	@RequestMapping(value = "/submitJSON", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String submitPOSTJSON(@Valid @ModelAttribute Fare fare, BindingResult result) throws SystemException {
		Gson gson = new Gson() ;
		JsonObject jo = new JsonObject() ;
		try{
			if(result.hasErrors()){
				System.out.println("error");
				jo.addProperty("success",false) ;
				return gson.toJson(jo) ;
			}
			else{
				System.out.println(fare.getType());
				Fare update_fare = fareService.getFareById(fare.getId()) ;
				update_fare.setDate(fare.getDate());
				update_fare.setExpense(fare.getExpense());
				update_fare.setOperator(fare.getOperator());
				update_fare.setType(fare.getType());
				fareService.update(update_fare);
				jo.addProperty("success", true);
				return gson.toJson(jo) ;
			}
		}catch(ServiceException e){
			throw new SystemException(e.getMessage());
		}
	}
	@InitBinder
    public void initBinder(WebDataBinder binder) {
        CustomDateEditor editor = new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"), true);
        binder.registerCustomEditor(Date.class, editor);
    }
}