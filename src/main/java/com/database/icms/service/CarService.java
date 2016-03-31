package com.database.icms.service;

import com.database.icms.domain.Car;
import com.database.icms.domain.Company;

import java.util.*;

public interface CarService {

	//保存由表单生成的车信息
	void saveCarForm(Car car);
	
	//根据公司id分页获得当前公司车辆
	List<Car> getCarByCompany(Integer page,Integer pageSize,Company company);
	
	//根据公司id获得公司所有车
	List<Car> findAllCarByCompany(Company company);
	
	//根据输入的信息获得车
	List<Car> findCarByInfo(Integer page,Integer pageSize,String carType,String plateNumber,Company company);
}
