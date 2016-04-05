package com.database.icms.dao;

import java.util.Date;
import java.util.List;

import com.database.icms.domain.Accident;

public interface AccidentDao extends BasicDao<Accident>{

	List<Accident> listDetail(Integer companyId, String plateNumber,
			Integer employeeId, Date startTime, Date endTime, int i, Integer max);

	Integer listAllDetailSize(Integer companyId, String plateNumber,
			Integer employeeId, Date startTime, Date endTime);

}
