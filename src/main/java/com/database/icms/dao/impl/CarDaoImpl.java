package com.database.icms.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.database.icms.dao.CarDao;
import com.database.icms.domain.Car;

@Repository
public class CarDaoImpl extends BasicDaoImpl<Car> implements CarDao{

	@Override
	public List<Car> findByPlateNumber(String plateNumber) {
		String hql = "from Car c where c.plateNumber like ? order by c.id asc";
		plateNumber = "%" + plateNumber + "%";
		return this.findByHql(hql, new Object[] { plateNumber });
	}

	@Override
	public List<Car> findByCarType(String carType) {
		String hql = "from Car c where c.carType like ? order by c.id asc";
		carType = "%" + carType + "%";
		return this.findByHql(hql, new Object[] { carType });
	}
	
}
