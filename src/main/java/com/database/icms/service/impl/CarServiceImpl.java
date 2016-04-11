package com.database.icms.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.database.icms.dao.CarDao;
import com.database.icms.domain.Car;
import com.database.icms.domain.Company;
import com.database.icms.service.CarService;
import com.database.icms.service.CompanyService;

@Service
@Transactional
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
	public List<Car> getCarByCompany(Integer page, Integer pageSize, Company company, Integer status)
			throws ServiceException {
		String sql;
		if (status == -1) {
			sql = "select * from car where company_id = " + company.getId() + " and (status=1 or status=0)";
		} else {
			sql = "select * from car where company_id = " + company.getId() + " and status = " + status;
		}
		try {
			return carDao.findByPageSql(page, pageSize, Car.class, sql, company);
		} catch (DataAccessException e) {
			throw new ServiceException(e.getMessage(), e.getCause());
		}
	}

	@Override
	@Transactional
	public List<Car> findAllCarByCompany(Company company, Integer status) throws ServiceException {
		String sql;
		if (status == -1) {
			sql = "select * from car where company_id = " + company.getId() + " and (status=1 or status=0)";
		} else {
			sql = "select * from car where company_id = " + company.getId() + " and status = " + status;
		}
		try {
			List<Car> carList = carDao.findBySql(sql, Car.class);
			return carList;
		} catch (DataAccessException e) {
			throw new ServiceException(e.getMessage(), e.getCause());
		}
	}

	@Override
	@Transactional
	public List<Car> findCarByInfo(Integer page, Integer pageSize, String carType, String plateNumber, Company company,
			Integer status) throws ServiceException {
		String sql;
		if (status == -1) {
			sql = "select * from car where company_id = " + company.getId() + " and (status = 1 or status=0)";
		} else {
			sql = "select * from car where company_id = " + company.getId() + " and status = " + status;
		}
		if(carType!="")sql = sql + " and carType like '%"+carType+"%'";
		if(plateNumber!="")sql = sql + " and plateNumber like '%"+plateNumber+"%'";
		//System.out.println(sql);
		try {
			return carDao.findByPageSql(page, pageSize, Car.class, sql);
		} catch (DataAccessException e) {
			throw new ServiceException(e.getMessage(), e.getCause());
		}
	}

	public Car loadByPlateNumber(Integer companyId, String plateNumber) throws ServiceException {
		try {
			List<Car> carList = carDao.findByPlateNumber(companyId, plateNumber);
			if (!carList.isEmpty() && carList.size() == 1) {
				return carList.get(0);
			}
			return null;
		} catch (DataAccessException e) {
			throw new ServiceException(e.getMessage(), e.getCause());
		}
	}

	@Override
	public Car loadByCarType(Integer companyId, String carType) throws ServiceException {
		try {
			List<Car> carList = carDao.findByCarType(companyId, carType);
			if (!carList.isEmpty() && carList.size() == 1) {
				return carList.get(0);
			}
			return null;
		} catch (DataAccessException e) {
			throw new ServiceException(e.getMessage(), e.getCause());
		}
	}

	@Override
	public void changeStatusToDelete(Integer car_id) throws ServiceException {
		try {
			Car car = carDao.findCarById(car_id);
			car.setStatus(2);
			carDao.update(car);
		} catch (DataAccessException e) {
			throw new ServiceException(e.getMessage(), e.getCause());
		}
	}

	@Override
	public Car findCarById(Integer id) throws ServiceException {
		try {
			return carDao.findCarById(id);
		} catch (DataAccessException e) {
			throw new ServiceException(e.getMessage(), e.getCause());
		}
	}

	@Override
	public void updateCar(Car car) throws ServiceException {
		try
		{
			carDao.update(car);
		}
		catch(DataAccessException e)
		{
			throw new ServiceException(e.getMessage(), e.getCause());
		}
		
	}

	@Override
	public Car findCarByPlateNumber(String plateNumber)throws ServiceException {
		try
		{
			return carDao.findCarByPlateNumber(plateNumber);
		}
		catch(DataAccessException e)
		{
			throw new ServiceException(e.getMessage(), e.getCause());
		}
	}

	@Override
	public void saveCar(Car car) throws ServiceException {
		try
		{
			carDao.save(car);
		}
		catch(DataAccessException e)
		{
			throw new ServiceException(e.getMessage(), e.getCause());
		}
		
	}

	@Override
	public void setCarLend(Integer carId) throws ServiceException {
		try {
			Car car = carDao.findCarById(carId);
			car.setStatus(0);
			carDao.update(car);
		} catch(DataAccessException e) {
			throw new ServiceException(e.getMessage(), e.getCause());
		}
	}

	@Override
	public void setCarReturn(Integer carId) {
		try {
			Car car = carDao.findCarById(carId);
			car.setStatus(1);
			carDao.update(car);
		} catch(DataAccessException e) {
			throw new ServiceException(e.getMessage(), e.getCause());
		}
	}

	@Override
	public List<Car> findAllCarByInfo(String carType, String plateNumber, Company company, Integer status)
			throws ServiceException {
		try
		{
			return carDao.findAllCarByInfo(carType,plateNumber,company,status);
		}
		catch(DataAccessException e)
		{
			throw new ServiceException(e.getMessage(), e.getCause());
		}
	}

}
