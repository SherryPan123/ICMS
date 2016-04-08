package com.database.icms.service.impl;

import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.database.icms.dao.FareDao;
import com.database.icms.domain.Fare;
import com.database.icms.service.FareService;

@Service
@Transactional
public class FareServiceImpl implements FareService{
	@Autowired
	FareDao fareDao ;
	@Override
	public List<Fare> findAllFareByPage( Integer pageNo ,Integer pageSize) {
		// TODO Auto-generated method stub
		return fareDao.findByPageHql(pageNo,pageSize,"from "+Fare.class.getSimpleName());
	}
	@Override
	public List<Fare> findAllFare(){
		return  fareDao.findAll(Fare.class);
	}
	
	@Override
	public List<Fare> findCompanyFareByPage(Integer companyId,Integer pageNo ,Integer pageSize)
	{
		//根据公司ID查询费用		
		String fare = Fare.class.getSimpleName() ;
		String hql = "from "+fare+" f where f.car.company.id = "+companyId; 
		return fareDao.findByPageHql(pageNo, pageSize, hql) ;
	}
	@Override
	public List<Fare> findAllFareByCompany(Integer companyId) {
		// TODO Auto-generated method stub
		String fare = Fare.class.getSimpleName() ;
		String hql = "from "+fare+" f where f.car.company.id = "+companyId;
		return fareDao.findByHql(hql);
	}
	@Override
	public void save(Fare fare) {
		// TODO Auto-generated method stub
		fareDao.save(fare);
	}
	@Override
	public Fare getFareById(Integer id) {
		return fareDao.getFareById(id);
	}
	@Override
	public void update(Fare fare_be_updated) {
		// TODO Auto-generated method stub
		fareDao.saveOrUpdate(fare_be_updated);
		
	}
	@Override
	public void deleteFareById(Integer id) {
		// TODO Auto-generated method stub
		Fare fare = fareDao.getFareById(id) ;
		fareDao.delete(fare);
	}
	@Override
	public List<Fare> listDetail(Integer companyId, String plateNumber,String type,Date startTime,Date endTime, int first,
			Integer max) {
		// TODO Auto-generated method stub
		try{
			return fareDao.listDetail(companyId, plateNumber,type,startTime,endTime,first, max);
		}
		catch (DataAccessException e) {
            throw new ServiceException(e.getMessage(), e.getCause());
        }
	}
	@Override
	public Integer listAllDetailSize(Integer companyId, String plateNumber,String type,Date startTime , Date endTime) {
		// TODO Auto-generated method stub
		try {
            return fareDao.listAllDetailSize(companyId,plateNumber,type,startTime,endTime);
        } catch (DataAccessException e) {
            throw new ServiceException(e.getMessage(), e.getCause());
        }
	}
}
