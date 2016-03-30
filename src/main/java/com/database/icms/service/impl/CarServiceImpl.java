package com.database.icms.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.database.icms.dao.CarDao;
import com.database.icms.domain.Car;
import com.database.icms.service.CarService;
import com.database.icms.service.CompanyService;

@Service
@Transactional
public class CarServiceImpl implements CarService {
	
	@Autowired
	CarDao carDao ;
	
	@Autowired
	CompanyService companyService;

	@Override
	public void saveCarForm(Car car) {
		car.setCompany(companyService.getSessionCompany());
		car.setStatus(0);  //0
		carDao.save(car);
	}

	@Override
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
	
}
