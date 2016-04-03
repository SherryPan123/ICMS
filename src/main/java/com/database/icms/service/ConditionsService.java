package com.database.icms.service;

import java.sql.Date;
import java.util.List;

import org.hibernate.service.spi.ServiceException;
import org.springframework.stereotype.Service;

import com.database.icms.domain.Conditions;


@Service
public interface ConditionsService {

	List<Conditions> list(int first, Integer max) throws ServiceException;

	List<Conditions> listDetail(Integer companyId, Integer carId, Integer employeeId, Date lendTime, Date returnTime, int first,
			int max) throws ServiceException;

	void save(Conditions conditions) throws ServiceException;

	Conditions load(Integer id) throws ServiceException;

	void delete(Conditions conditions) throws ServiceException;

	Integer listAllDetailSize(Integer companyId, Integer carId, Integer employeeId, Date lendTime, Date returnTime) throws ServiceException;

	void update(Conditions conditions) throws ServiceException;

	List<Conditions> findByEmployee(Integer employeeId);

}
