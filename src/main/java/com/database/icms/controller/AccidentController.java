package com.database.icms.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.database.icms.domain.Accident;
import com.database.icms.domain.Car;
import com.database.icms.domain.Fare;
import com.database.icms.service.AccidentService;
import com.database.icms.service.CarService;
import com.database.icms.service.CompanyService;

@Controller
@RequestMapping("/accident")
public class AccidentController {
	@Autowired
	CompanyService companyService ;
	@Autowired
	CarService carService ;
	@Autowired
	AccidentService accidentService ;
	@RequestMapping(value="list",method=RequestMethod.GET)
	public ModelAndView listAllAccident(
			@RequestParam(value="companyId",defaultValue="0")Integer companyId,
			@RequestParam(value="plateNumber" , required=false) String plateNumber,
			@RequestParam(value="employeeId",required=false) Integer employeeId,
			@RequestParam(value="startTime",required=false) String startTimeString ,
			@RequestParam(value="endTime",required=false) String endTimeString ,
			@RequestParam(value="isEdit",required=false) Integer isEdit ,
			@RequestParam(defaultValue="1") Integer page ,
			@RequestParam( defaultValue = "50") Integer max
	) throws ParseException
	{
		int totalPage ;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date startTime = null,endTime=null ;
		if(startTimeString!=null && !startTimeString.isEmpty())
			startTime = sdf.parse(startTimeString);
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
					accidentList = accidentService.listDetail(companyId, plateNumber,employeeId,startTime,endTime,
							(page - 1) * max, max);
					totalPage = (accidentService.listAllDetailSize(companyId, plateNumber,employeeId,startTime,endTime) + max - 1) / max;
					//totalPage  =(accidentService.findAllFare().size() + max - 1) /max ;
					mav.addObject("fare",accidentList) ;
					mav.addObject("totalPage",totalPage) ;
			}
			else{
				totalPage= 0 ;
			}
			mav.addObject("plateNumber",plateNumber) ;
			mav.addObject("employeeId",employeeId) ;
			mav.addObject("isEdit",isEdit) ;
			mav.addObject("startTime",startTime);
			mav.addObject("endTime",endTime);
			mav.addObject("companyId",companyId) ;
			}catch(ServiceException e){
				e.printStackTrace(); 
			}
		
		return mav ;
	}

}
