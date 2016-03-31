package com.database.icms.service.impl;

import java.util.List;

import javax.transaction.Transactional;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.database.icms.dao.CarDao;
import com.database.icms.domain.Car;
import com.database.icms.domain.Company;
import com.database.icms.service.CarService;
import com.database.icms.service.CompanyService;

@Service
public class CarServiceImpl implements CarService {

	@Autowired
	CarDao carDao;

	@Autowired
	CompanyService companyService;

	@Autowired
	@Qualifier("sessionFactory")
	private SessionFactory sessionFactory;

	protected Session getSession() {
		return this.sessionFactory.getCurrentSession();
	}

	@Override
	public void saveCarForm(Car car) {
		car.setCompany(companyService.getSessionCompany());
		car.setStatus(0); // 0
		carDao.save(car);
	}

	@Override
	@Transactional
	public List<Car> getCarByCompany(Integer page, Integer pageSize, Company company) {
		String sql = "select * from car where company_id = "+company.getId();
		return carDao.findByPageSql(page, pageSize, Car.class, sql, company);
	}

	@Override
	@Transactional
	public List<Car> findAllCarByCompany(Company company) {
		String sql = "select * from car where company_id="+company.getId();
		List<Car> carList = carDao.findBySql(sql,Car.class);
		return carList;
	}

	@Override
	@Transactional
	public List<Car> findCarByInfo(Integer page, Integer pageSize, String carType, String plateNumber,Company company) {
		String sql = "select * from car where company_id = "
				+company.getId()+" and carType like %"+carType+"% and plateNumber like %"+plateNumber+"%";
		return carDao.findByPageSql(page, pageSize, Car.class, sql);
	}

}
