package com.database.icms.service;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import com.database.icms.domain.Accident;

@Service
public interface AccidentService {

	List<Accident> listDetail(Integer companyId, String plateNumber,
			String driverId, Date startTime, Date endTime, int i, Integer max);

	Integer listAllDetailSize(Integer companyId, String plateNumber,
			String driverId, Date startTime, Date endTime);

	void save(Accident accident);

	Accident getAccidentById(Integer id);

	void update(Accident accident_be_updated);

	void deleteAccidentById(Integer id);

	List<Accident> findByEmployee(Integer id);

}
