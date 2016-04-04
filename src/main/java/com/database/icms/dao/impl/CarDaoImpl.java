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

	@Override
	public Car findCarById(Integer id) {
		String hql = "from Car c where c.id=?";
		//System.out.println(hql);
		List<Car> carList = this.findByHql(hql,new Object[]{id});
		//System.out.println("end\t"+hql);
		if(carList!=null) return carList.get(0);
		else return null;
	}

	@Override
	public Car findCarByPlateNumber(String plateNumber) {
		String hql = "from Car c where c.plateNumber=?";
		List<Car> carList = this.findByHql(hql, new Object[]{plateNumber});
		System.out.println("search end");
		if(carList==null||carList.isEmpty())
		{
			return null; 
		}
		else 
		{
			return carList.get(0);
		}
	}
	
	
}
