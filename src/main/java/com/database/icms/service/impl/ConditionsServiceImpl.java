package com.database.icms.service.impl;

import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.database.icms.dao.CarDao;
import com.database.icms.dao.ConditionsDao;
import com.database.icms.dao.EmployeeDao;
import com.database.icms.domain.Conditions;
import com.database.icms.service.ConditionsService;

@Service
@Transactional
public class ConditionsServiceImpl implements ConditionsService {

	@Autowired
	ConditionsDao conditionsDao;

	@Autowired
	CarDao carDao;

	@Autowired
	EmployeeDao employeeDao;

	@Override
	public List<Conditions> list(int first, Integer max) throws ServiceException {
		try {
            return conditionsDao.list(first, max);
        } catch (DataAccessException e) {
            throw new ServiceException(e.getMessage(), e.getCause());
        }
	}

	@Override
	public List<Conditions> listDetail(Integer companyId, String carInfo, String employeeInfo, Date lendTime, Date returnTime,
			int first, int max) throws ServiceException {
		try {
			Integer[] carId = carDao.findCarIdByCarInfo(carInfo);
			Integer[] employeeId = employeeDao.findEmployeeIdByEmployeeInfo(employeeInfo);
			if (null == carId || null == employeeId) return null;
			System.out.println("car.size = " + carId.length);
			System.out.println("employee.size = " + employeeId.length);
            return conditionsDao.listDetail(companyId, carId, employeeId, lendTime, returnTime, first, max);
        } catch (DataAccessException e) {
            throw new ServiceException(e.getMessage(), e.getCause());
        }
	}

	@Override
	public void save(Conditions conditions) throws ServiceException {
		try {
			conditionsDao.saveOrUpdate(conditions);
		} catch (DataAccessException e) {
			throw new ServiceException(e.getMessage(), e.getCause());
		}
	}

	@Override
	public Conditions load(Integer id) throws ServiceException {
		try {
			return conditionsDao.get(Conditions.class, id);
		} catch (DataAccessException e) {
			throw new ServiceException(e.getMessage(), e.getCause());
		}
	}

	@Override
	public void delete(Conditions conditions) throws ServiceException {
		try {
			conditionsDao.delete(conditions);
		} catch (DataAccessException e) {
			throw new ServiceException(e.getMessage(), e.getCause());
		}
	}

	@Override
	public Integer listAllDetailSize(Integer companyId, String carInfo, String employeeInfo, Date lendTime,
			Date returnTime) throws ServiceException {
		try {
			Integer[] carId = carDao.findCarIdByCarInfo(carInfo);
			Integer[] employeeId = employeeDao.findEmployeeIdByEmployeeInfo(employeeInfo);
            return conditionsDao.listAllDetailSize(companyId, carId, employeeId, lendTime, returnTime);
        } catch (DataAccessException e) {
            throw new ServiceException(e.getMessage(), e.getCause());
        }
	}

	@Override
	public void update(Conditions conditions) throws ServiceException {
		try {
			conditionsDao.update(conditions);
		} catch (DataAccessException e) {
            throw new ServiceException(e.getMessage(), e.getCause());
        }
	}

	@Override
	public List<Conditions> findByEmployee(Integer employeeId) {
		try {
			return conditionsDao.findByEmployee(employeeId);
		} catch (DataAccessException e) {
            throw new ServiceException(e.getMessage(), e.getCause());
        }
	}
	
}
