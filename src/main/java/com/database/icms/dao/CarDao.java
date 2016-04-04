package com.database.icms.dao;

import java.util.List;

import com.database.icms.domain.Car;

public interface CarDao extends BasicDao<Car>{

	List<Car> findByPlateNumber(Integer companyId, String plateNumber);

	List<Car> findByCarType(Integer companyId, String carType);
	
	Car findCarById(Integer id);
	
	//通过车牌号精确查找车辆
	Car findCarByPlateNumber(String plateNumber);
}
