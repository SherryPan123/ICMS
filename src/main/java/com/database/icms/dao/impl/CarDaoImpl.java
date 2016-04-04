package com.database.icms.dao.impl;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
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
	public Integer[] findCarIdByCarInfo(String carInfo) {
		Criteria crit = this.getSession().createCriteria(Car.class);
		if (null != carInfo) {
			carInfo = "%" + carInfo + "%";
			crit.add(Restrictions.or(Restrictions.like("carType", carInfo), Restrictions.like("plateNumber", carInfo)));
		}
		@SuppressWarnings("unchecked")
		List<Car> carList = (List<Car>)crit.list();
		Integer[] carId = null;
		if (carList.size() > 0) {
			carId = new Integer[carList.size()];
			int cnt = 0;
			for (Car car : carList) {
				carId[cnt++] = car.getId();
			}
		}
		return carId;
	}
	
}
