package com.database.icms.service.impl;

import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.database.icms.dao.AccidentDao;
import com.database.icms.domain.Accident;
import com.database.icms.service.AccidentService;

@Service
@Transactional
public class AccidentServiceImpl implements AccidentService{

	@Autowired
	AccidentDao accidentDao ;

	@Override
	public List<Accident> listDetail(Integer companyId, String plateNumber,
			String driverId, Date startTime, Date endTime, int i, Integer max) {
		try{
			return accidentDao.listDetail(companyId, plateNumber,driverId,startTime,endTime,i, max);
		}
		catch (DataAccessException e) {
            throw new ServiceException(e.getMessage(), e.getCause());
        }
	}

	@Override
	public Integer listAllDetailSize(Integer companyId, String plateNumber,
			String driverId, Date startTime, Date endTime) {
		try {
            return accidentDao.listAllDetailSize(companyId,plateNumber,driverId,startTime,endTime);
        } catch (DataAccessException e) {
            throw new ServiceException(e.getMessage(), e.getCause());
        }
	}

	@Override
	public void save(Accident accident) {
		try{
			accidentDao.save(accident) ;
		}catch(DataAccessException e){
			throw new ServiceException(e.getMessage(),e.getCause()) ;
		}
	}

	@Override
	public Accident getAccidentById(Integer id) {
		try{
			return accidentDao.getAccidentById(id);
		}catch(DataAccessException e){
			throw new ServiceException(e.getMessage(),e.getCause());
		}
	}
	@Override
	public void update(Accident accident_be_updated) {
		try{
			accidentDao.saveOrUpdate(accident_be_updated);
		}catch(DataAccessException e){
			throw new ServiceException(e.getMessage(),e.getCause()) ;
		}
	}

	@Override
	public void deleteAccidentById(Integer id) {
		try{
			Accident accident = accidentDao.getAccidentById(id) ;
			accidentDao.delete(accident);
		}catch(DataAccessException e){
			throw new ServiceException(e.getMessage(),e.getCause()) ;
		}
	}
}
