package com.database.icms.service;

import org.hibernate.service.spi.ServiceException;

import com.database.icms.domain.Car;
import com.database.icms.domain.Company;

import java.util.*;

public interface CarService {

	// 保存由表单生成的车信息
	void saveCarForm(Car car);

	// 根据公司id分页获得当前公司车辆
	List<Car> getCarByCompany(Integer page, Integer pageSize, Company company, Integer status) throws ServiceException;

	// 根据公司id获得公司所有车
	List<Car> findAllCarByCompany(Company company, Integer status) throws ServiceException;

	// 根据输入的信息获得车(分页)
	List<Car> findCarByInfo(Integer page, Integer pageSize, String carType, String plateNumber, Company company,
			Integer status) throws ServiceException;

	// 根据输入的信息获得车(所有)
	List<Car> findAllCarByInfo(String carType, String plateNumber, Company company, Integer status)
			throws ServiceException;

	Car loadByPlateNumber(Integer companyId, String plateNumber) throws ServiceException;

	Car loadByCarType(Integer companyId, String carType) throws ServiceException;

	// 根据信息将车的状态改为已删除
	void changeStatusToDelete(Integer car_id) throws ServiceException;

	// 根据车id获得车
	Car findCarById(Integer id) throws ServiceException;

	// 更新车辆信息
	void updateCar(Car car) throws ServiceException;

	// 根据车牌号精确查找车
	Car findCarByPlateNumber(String plateNumber) throws ServiceException;

	// 保存汽车
	void saveCar(Car car) throws ServiceException;

	//标记车出借
	void setCarLend(Integer carId);
	
	//标记车可用
	void setCarReturn(Integer carId);

}
