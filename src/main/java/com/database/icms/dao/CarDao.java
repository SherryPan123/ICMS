package com.database.icms.dao;

import java.util.List;

import com.database.icms.domain.Car;

public interface CarDao extends BasicDao<Car>{

	List<Car> findByPlateNumber(String plateNumber);

	List<Car> findByCarType(String carType);
	
}
