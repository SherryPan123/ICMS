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

import com.database.icms.domain.Fare;
import com.database.icms.service.ConditionsService;
import com.database.icms.service.FareService;

@Controller
public class GraphController {

	@Autowired
	private ConditionsService conditionsService;
	
	@Autowired
	private FareService fareService;

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
		

		List<Double> fakuan = new ArrayList<Double> ();//2016-1-1 -- 2016-1-31
		List<Double> jiayou = new ArrayList<Double> ();//2016-2-1 -- 2016-2-29
		List<Double> weixiu = new ArrayList<Double> ();//2016-3-1 -- 2016-3-31
		
		//1 月
		cal.set(year, 0, 1, 0, 0);
		cal.set(Calendar.MONTH, 0);
		cal.set(Calendar.DAY_OF_MONTH, 1);
		Date tmp = cal.getTime();
		Date startTime = changeToFormat(tmp);
		cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
		tmp = cal.getTime();
		Date endTime = changeToFormat(tmp);
		List<Fare> fareList = fareService.listDetailGraph(companyId, "违章罚款", startTime, endTime);
		Double totalSum = 0.0;
		Double sum = 0.0;
		for (Fare fare : fareList) {
			sum += fare.getExpense();
		}
		totalSum += sum;
		fakuan.add(sum);
		fareList = fareService.listDetailGraph(companyId, "加油", startTime, endTime);
		sum = 0.0;
		for (Fare fare : fareList) {
			sum += fare.getExpense();
		}
		totalSum += sum;
		jiayou.add(sum);
		fareList = fareService.listDetailGraph(companyId, "维修", startTime, endTime);
		sum = 0.0;
		for (Fare fare : fareList) {
			sum += fare.getExpense();
		}
		totalSum += sum;
		weixiu.add(sum);
		
		//2 月
		cal.set(year, 1, 1, 0, 0);
		cal.set(Calendar.MONTH, 1);
		cal.set(Calendar.DAY_OF_MONTH, 1);
		tmp = cal.getTime();
		startTime = changeToFormat(tmp);
		cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
		tmp = cal.getTime();
		endTime = changeToFormat(tmp);
		fareList = fareService.listDetailGraph(companyId, "违章罚款", startTime, endTime);
		sum = 0.0;
		for (Fare fare : fareList) {
			sum += fare.getExpense();
		}
		totalSum += sum;
		fakuan.add(sum);
		fareList = fareService.listDetailGraph(companyId, "加油", startTime, endTime);
		sum = 0.0;
		for (Fare fare : fareList) {
			sum += fare.getExpense();
		}
		totalSum += sum;
		jiayou.add(sum);
		fareList = fareService.listDetailGraph(companyId, "维修", startTime, endTime);
		sum = 0.0;
		for (Fare fare : fareList) {
			sum += fare.getExpense();
		}
		totalSum += sum;
		weixiu.add(sum);
		
		//3 月
		cal.set(year, 2, 1, 0, 0);
		cal.set(Calendar.MONTH, 2);
		cal.set(Calendar.DAY_OF_MONTH, 1);
		tmp = cal.getTime();
		startTime = changeToFormat(tmp);
		cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
		tmp = cal.getTime();
		endTime = changeToFormat(tmp);
		fareList = fareService.listDetailGraph(companyId, "违章罚款", startTime, endTime);
		sum = 0.0;
		for (Fare fare : fareList) {
			sum += fare.getExpense();
		}
		totalSum += sum;
		fakuan.add(sum);
		fareList = fareService.listDetailGraph(companyId, "加油", startTime, endTime);
		sum = 0.0;
		for (Fare fare : fareList) {
			sum += fare.getExpense();
		}
		totalSum += sum;
		jiayou.add(sum);
		fareList = fareService.listDetailGraph(companyId, "维修", startTime, endTime);
		sum = 0.0;
		for (Fare fare : fareList) {
			sum += fare.getExpense();
		}
		totalSum += sum;
		weixiu.add(sum);
		
		//4 月
		cal.set(year, 3, 1, 0, 0);
		cal.set(Calendar.MONTH, 3);
		cal.set(Calendar.DAY_OF_MONTH, 1);
		tmp = cal.getTime();
		startTime = changeToFormat(tmp);
		cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
		tmp = cal.getTime();
		endTime = changeToFormat(tmp);
		fareList = fareService.listDetailGraph(companyId, "违章罚款", startTime, endTime);
		sum = 0.0;
		for (Fare fare : fareList) {
			sum += fare.getExpense();
		}
		totalSum += sum;
		fakuan.add(sum);
		fareList = fareService.listDetailGraph(companyId, "加油", startTime, endTime);
		sum = 0.0;
		for (Fare fare : fareList) {
			sum += fare.getExpense();
		}
		totalSum += sum;
		jiayou.add(sum);
		fareList = fareService.listDetailGraph(companyId, "维修", startTime, endTime);
		sum = 0.0;
		for (Fare fare : fareList) {
			sum += fare.getExpense();
		}
		totalSum += sum;
		weixiu.add(sum);
		
		System.out.println("违章罚款:");
		for (Double fa : fakuan) {
			System.out.println(fa+",");
		}
		System.out.println("加油:");
		for (Double fa : jiayou) {
			System.out.println(fa+",");
		}
		System.out.println("维修:");
		for (Double fa : weixiu) {
			System.out.println(fa+",");
		}

		//平均值
		System.out.println("平均值:");
		List<Double> avg = new ArrayList<Double> ();
		for (int i = 0; i < 4; i++) {
			System.out.println((fakuan.get(i) + jiayou.get(i) + weixiu.get(i)) / 4.0+",");
			avg.add((fakuan.get(i) + jiayou.get(i) + weixiu.get(i)) / 4.0);
		}

		//百分比
		List<Double> percent = new ArrayList<Double> ();
		if (totalSum > 0) {
			percent.add((fakuan.get(0)+fakuan.get(1)+fakuan.get(2)+fakuan.get(3)) / totalSum);
			percent.add((jiayou.get(0)+jiayou.get(1)+jiayou.get(2)+jiayou.get(3)) / totalSum);
			percent.add((weixiu.get(0)+weixiu.get(1)+weixiu.get(2)+weixiu.get(3)) / totalSum);
		}
		
		mav.addObject("fakuan", fakuan);
		mav.addObject("jiayou", jiayou);
		mav.addObject("weixiu", weixiu);
		mav.addObject("avg", avg);
		mav.addObject("percent", percent);
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
