package com.database.icms.dao;

import java.util.List;

import com.database.icms.domain.Car;
import com.database.icms.domain.Company;

public interface CarDao extends BasicDao<Car>{

	List<Car> findByPlateNumber(Integer companyId, String plateNumber);

	List<Car> findByCarType(Integer companyId, String carType);

	Integer[] findCarIdByCarInfo(String carInfo);

	Car findCarById(Integer id);

	//通过车牌号精确查找车辆
	Car findCarByPlateNumber(String plateNumber);
	
	List<Car>findAllCarByInfo(String carType, String plateNumber, Company company, Integer status);
}
