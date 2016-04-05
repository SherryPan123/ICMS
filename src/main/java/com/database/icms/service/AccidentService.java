package com.database.icms.service;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import com.database.icms.domain.Accident;

@Service
public interface AccidentService {

	List<Accident> listDetail(Integer companyId, String plateNumber,
			Integer employeeId, Date startTime, Date endTime, int i, Integer max);

	Integer listAllDetailSize(Integer companyId, String plateNumber,
			Integer employeeId, Date startTime, Date endTime);

}
