package com.database.icms.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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

import com.database.icms.domain.Accident;
import com.database.icms.domain.Car;
import com.database.icms.domain.Employee;
import com.database.icms.service.AccidentService;
import com.database.icms.service.CarService;
import com.database.icms.service.CompanyService;
import com.database.icms.service.EmployeeService;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

@Controller
@RequestMapping("/accident")
public class AccidentController {
	@Autowired
	CompanyService companyService ;
	@Autowired
	CarService carService ;
	@Autowired
	AccidentService accidentService ;
	@Autowired
	EmployeeService employeeService;
	@RequestMapping(value="list",method=RequestMethod.GET)
	public ModelAndView listAllAccident(
			@RequestParam(value="companyId",defaultValue="0")Integer companyId,
			@RequestParam(value="plateNumber" , required=false) String plateNumber,
			@RequestParam(value="driverId",required=false) String driverId,
			@RequestParam(value="startTime",required=false) String startTimeString ,
			@RequestParam(value="endTime",required=false) String endTimeString ,
			@RequestParam(value="isEdit",defaultValue="0") Integer isEdit ,
			@RequestParam(defaultValue="1") Integer page ,
			@RequestParam( defaultValue = "50") Integer max
	) throws ParseException
	{
		int totalPage ;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date startTime = null,endTime=null ;
		if(startTimeString!=null && !startTimeString.isEmpty())
			startTime = sdf.parse(startTimeString);
		if(endTimeString!=null && !endTimeString.isEmpty())
			endTime = sdf.parse(endTimeString);
		ModelAndView mav = new ModelAndView("accident/list") ;
		if(companyId==0){
			companyId = companyService.getSessionCompany().getId();
		}
		mav.addObject("page",page);
		mav.addObject("max",max);
		
		try{
			
			List<Accident> accidentList = new ArrayList<Accident>() ;
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
					accidentList = accidentService.listDetail(companyId, plateNumber,driverId,startTime,endTime,
							(page - 1) * max, max);
					totalPage = (accidentService.listAllDetailSize(companyId, plateNumber,driverId,startTime,endTime) + max - 1) / max;
					//totalPage  =(accidentService.findAllFare().size() + max - 1) /max ;
					mav.addObject("accidentList",accidentList) ;
					mav.addObject("totalPage",totalPage) ;
			}
			else{
				totalPage= 0 ;
			}
			Accident accident = new Accident();
			mav.addObject("accident",accident);
			mav.addObject("plateNumber",plateNumber) ;
			mav.addObject("driverId",driverId) ;
			mav.addObject("isEdit",isEdit) ;
			mav.addObject("startTime",startTime);
			mav.addObject("endTime",endTime);
			mav.addObject("companyId",companyId) ;
			}catch(ServiceException e){
				e.printStackTrace(); 
			}
		
		return mav ;
	}
	@RequestMapping(value="add",method=RequestMethod.GET)
	public ModelAndView AddAccident(
			@RequestParam(value="companyId",defaultValue="0") Integer companyId,
			@RequestParam(value="driverId",required=false) String driverId ,
			@RequestParam(value="plateNumber",required=false)  String plateNumber,
			@RequestParam(value="description",required=false) String description ,
			@RequestParam(value="date",required=false) String dateString
			) throws ParseException
	{
		if(companyId == 0)
			companyId= companyService.getSessionCompany().getId() ;
		if(plateNumber == null || plateNumber.isEmpty() || driverId == null ||driverId.isEmpty()||dateString==null||dateString.isEmpty()){
			ModelAndView mav = new ModelAndView("accident/add") ;
			mav.addObject("companyId",companyId);
			return mav ;
		}
		else{
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date date = sdf.parse(dateString);
			Accident accident = new Accident() ;
			Car car = new Car();
			car = carService.loadByPlateNumber(companyId, plateNumber);
			Employee driver= new Employee() ;
			driver = employeeService.loadByEmployeeId(companyId, driverId) ;
			accident.setCar(car);
			accident.setDate(date);
			accident.setDescription(description);
			accident.setDriver(driver);
			accidentService.save(accident) ;
			ModelAndView mav = new ModelAndView("redirect:/accident/list");
			mav.addObject("companyId",companyId);
			return mav;
		}
	}
	
	//更新事故信息
		@RequestMapping(value="/update",method=RequestMethod.GET)
		public ModelAndView UpdateAccident(
				@RequestParam(value="id",required=true)Integer id ,
				@RequestParam(value="companyId",defaultValue="0")Integer companyId,
				@RequestParam(value="driverId",required=false) String driverId ,
				@RequestParam(value="date",required=false) String dateString ,
				@RequestParam(value="description",required=false) String description ,
				@RequestParam(value="plateNumber",required=false) String plateNumber
				) throws ParseException
		{
			if(companyId==0){
				companyId=companyService.getSessionCompany().getId();
			}
			if (driverId==null||driverId.isEmpty()||plateNumber == null || plateNumber.isEmpty()||dateString==null||dateString.isEmpty()) {
				System.out.println(id);
				ModelAndView mav = new ModelAndView("accident/update");
				Accident accident = accidentService.getAccidentById(id);
				mav.addObject("accident", accident);
				String tmp = accident.getDate().toString();
				String date = new String() ;
				for(int i = 0 ;i<tmp.length();i++){
					if(tmp.charAt(i)==' ') break ;
					date+=String.valueOf(tmp.charAt(i));
				}
				mav.addObject("date",date) ;
				System.out.println(accident.getId());
				return mav;
			}
			else{
				ModelAndView mav = new ModelAndView("redirect:/accident/list?isEdit=1") ;
				Accident accident_be_updated = accidentService.getAccidentById(id);
				Car car = new Car();
				car = carService.loadByPlateNumber(companyId, plateNumber);
				Employee driver = new Employee();
				driver=employeeService.loadByEmployeeId(companyId, driverId) ;
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Date date = sdf.parse(dateString);
				accident_be_updated.setCar(car);
				accident_be_updated.setDate(date);
				accident_be_updated.setDescription(description);
				accident_be_updated.setDriver(driver);
				accidentService.update(accident_be_updated);
				

				return mav; 
			}
		}
		@RequestMapping(value="delete",method=RequestMethod.GET)
		String deleteAccident(
				@RequestParam(value="id",required=true) Integer id 
				)
		{
			accidentService.deleteAccidentById(id) ;
			return "redirect:/accident/list?isEdit=1" ;
		}
		
		//add Accident(Json方式)
		@RequestMapping(value="/addJSON",method=RequestMethod.POST)
		@ResponseBody
		public String addPostJson(@Valid @ModelAttribute Accident accident ,BindingResult result)
		throws SystemException
		{
			Gson gson=new Gson();
			JsonObject jo = new JsonObject() ;
			try{
				if(result.hasErrors()){
					System.out.println("error");
					jo.addProperty("success",false) ;
					return gson.toJson(jo) ;
				}
				else{
					accidentService.save(accident);
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
