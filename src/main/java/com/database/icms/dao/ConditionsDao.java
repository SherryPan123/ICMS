package com.database.icms.dao;

import java.sql.Date;
import java.util.List;

import com.database.icms.domain.Conditions;

public interface ConditionsDao extends BasicDao<Conditions> {

	List<Conditions> list(int first, int max);

	List<Conditions> listDetail(Integer companyId, Integer carId, Integer employeeId, Date startTime, Date endTime, int first,
			int max);

	Integer listAllDetailSize(Integer companyId, Integer carId, Integer employeeId, Date lendTime, Date returnTime);

	List<Conditions> findByEmployee(Integer employeeId);

}
