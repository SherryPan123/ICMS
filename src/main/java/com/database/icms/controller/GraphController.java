package com.database.icms.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.database.icms.service.ConditionsService;

@Controller
public class GraphController {

	@Autowired
	private ConditionsService conditionsService;

	@RequestMapping(value = "/graph", method = RequestMethod.GET)
	public ModelAndView showGraph(
			@RequestParam(value = "companyId", defaultValue="0") Integer companyId,
			@RequestParam(value = "year", defaultValue="-1") Integer year) {
		ModelAndView mav = new ModelAndView("graph");
		Calendar cal = new GregorianCalendar();
		if (year == -1) {
			year = Calendar.getInstance().get(Calendar.YEAR);
		}
		
		List<Integer> conditionsListThisYear = new ArrayList<Integer>();
		List<Integer> conditionsListLastYear = new ArrayList<Integer>();

		for (int i=0; i<=11; i++) {
			cal.set(year, i, 1, 0, 0);
			cal.set(Calendar.MONTH, i);
			cal.set(Calendar.DAY_OF_MONTH, 1);
			Date tmp = cal.getTime();
			Date startTime = changeToFormat(tmp);
			System.out.println("输出开始时间："+startTime.toString());
			cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
			
			tmp = cal.getTime();
			Date endTime = changeToFormat(tmp);
			System.out.println("输出结束时间："+endTime.toString());
			int size = conditionsService.listAllDetailSize(companyId, "", "", startTime, endTime);
			conditionsListThisYear.add(size);
			
			cal.set(year-1, i, 1, 0, 0);
			tmp = cal.getTime();
			startTime = changeToFormat(tmp);
			System.out.println("last year 开始时间："+startTime.toString());
			cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
			tmp = cal.getTime();
			endTime = changeToFormat(tmp);
			System.out.println("last year 结束时间："+endTime.toString());
			size = conditionsService.listAllDetailSize(companyId, "", "", startTime, endTime);
			conditionsListLastYear.add(size);
		}
		for(int i=0; i<conditionsListThisYear.size(); i++){
			System.out.println(conditionsListThisYear.get(i));
		}
		//cal.set(Calendar.MONTH, 0);
		//List<Conditions> conditionsList = conditionsService.listDetail(companyId, "", "", startDate, endDate, 0, Integer.MAX_VALUE);
		mav.addObject("conditionsListThisYear", conditionsListThisYear);
		mav.addObject("conditionsListLastYear", conditionsListLastYear);
		mav.addObject("year", year);
		return mav;
	}
	
	private Date changeToFormat(Date date) {
		Date tmp = new Date(0);
		tmp.setYear(date.getYear());
		tmp.setMonth(date.getMonth());
		tmp.setDate(date.getDate());
		tmp.setHours(0);
		return tmp;
	}
	
}
