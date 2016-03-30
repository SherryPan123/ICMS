package com.database.icms.service;

import org.hibernate.service.spi.ServiceException;

import com.database.icms.domain.Car;

public interface CarService {

	//保存由表单生成的车信息
	void saveCarForm(Car car);

	Car loadByPlateNumber(Integer companyId, String plateNumber) throws ServiceException;

	Car loadByCarType(Integer companyId, String carType) throws ServiceException;

}
