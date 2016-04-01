package com.database.icms.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.database.icms.dao.CarDao;
import com.database.icms.domain.Car;

@Repository
public class CarDaoImpl extends BasicDaoImpl<Car> implements CarDao{

	@Override
	public List<Car> findByPlateNumber(Integer companyId, String plateNumber) {
		String hql = "from Car c where c.company.id = ? and c.plateNumber = ? order by c.id asc";
		return this.findByHql(hql, new Object[] { companyId, plateNumber });
	}

	@Override
	public List<Car> findByCarType(Integer companyId, String carType) {
		String hql = "from Car c where c.company.id = ? and c.carType = ? order by c.id asc";
		return this.findByHql(hql, new Object[] { companyId, carType });
	}
	
}
