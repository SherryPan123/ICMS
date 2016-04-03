package com.database.icms.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.database.icms.domain.Fare;
import com.database.icms.service.CompanyService;
import com.database.icms.service.FareService;

@Controller
@RequestMapping("/fare")
public class FareController {
	@Autowired 
	private FareService fareService ;
	@Autowired
	private CompanyService companyService ;
	@RequestMapping(value="list",method=RequestMethod.GET)
	public ModelAndView listAllFare(
			@RequestParam(value="companyId",defaultValue="2")Integer companyId,
			@RequestParam( defaultValue = "1") Integer page,
			@RequestParam( defaultValue = "10") Integer max,
			@RequestParam( value="name",required = false ) String name
	)
	{
		ModelAndView mav = new ModelAndView("fare/list") ;
		//获取当前公司
		//if(companyId==0) 
			//companyService.getSessionCompany().getId();
		System.out.println("当前公司Id: "+companyId);
		mav.addObject("page",page) ;
		mav.addObject("max",max) ;
		mav.addObject("name",name) ;
		List<Fare> fareList = new ArrayList<Fare>() ;
		if(companyId == 1){
			fareList = fareService.findAllFareByPage(page,max) ;
			int totalPage  =(fareService.findAllFare().size() + max - 1) /max ;
			mav.addObject("fare",fareList) ;
			mav.addObject("totalPage",totalPage) ;
		}
		else{
			fareList = fareService.findCompanyFareByPage(companyId,page,max) ;
			int totalPage = (fareService.findAllFareByCompany(companyId).size())/max+1 ;
			mav.addObject("fare",fareList) ;
			mav.addObject("totalPage",totalPage);
			System.out.println("companyname:"+name);
		}
		return mav ;
	}
	
}
