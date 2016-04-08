package com.database.icms.dao.impl;

import java.util.Date;
import java.util.List;

import org.apache.poi.util.SystemOutLogger;
import org.hibernate.Criteria;
import org.hibernate.criterion.Property;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.database.icms.dao.FareDao;
import com.database.icms.domain.Company;
import com.database.icms.domain.Fare;

@Repository
public class FareDaoImpl extends BasicDaoImpl<Fare> implements FareDao {

	@Override
	public Fare getFareById(Integer id) {
		// TODO Auto-generated method stub
		String hql = "from Fare f where f.id = ? ";
		List<Fare> fareList = this.findByHql(hql, new Object[]{id});
		if( null != fareList && fareList.size() == 1 ) return fareList.get(0);
		else return null;
	}

	@Override
	public List<Fare> listDetail(Integer companyId, String plateNumber,
			String type ,Date startTime,Date endTime ,int first, Integer max) {
		// TODO Auto-generated method stub
		Criteria crit = this.getSession().createCriteria(Fare.class) ;
		if (companyId != -1)  {
			crit.createAlias("car","car");
			crit.createAlias("car.company","company");
			if(companyId!=1){
				crit.add(Restrictions.eq("company.id", companyId));
			}
		}
		System.out.println("1");
		if (plateNumber != null && !plateNumber.isEmpty()){
			crit.add(Restrictions.eq("car.plateNumber",plateNumber)) ;
		}
		if (type != null && !type.isEmpty()){
			System.out.println(type);
			crit.add(Restrictions.eq("type",type)) ;
		}
		if (startTime != null ){
			System.out.println(startTime);
			crit.add(Restrictions.ge("date",startTime)) ;
		}
		else{
			System.out.println("start date is null") ;
		}
		if (endTime != null ){
			System.out.println(endTime);
			crit.add(Restrictions.le("date",endTime)) ;
		}
		else{
			System.out.println("end date is null") ;
		}
		crit.setFirstResult(first);
		crit.setMaxResults(max);
		crit.addOrder(Property.forName("id").desc());
		System.out.println("2");
		@SuppressWarnings("unchecked")
		List<Fare> fareList = (List<Fare>)crit.list();
		System.out.println("3");
		return fareList;
	}

	@Override
	public List<Fare> list(int first, Integer max) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Integer listAllDetailSize(Integer companyId, String plateNumber,String type,Date startTime,Date endTime) {
		// TODO Auto-generated method stub
		List<Fare> fareList = listDetail(companyId, plateNumber,type,  startTime,endTime ,0, Integer.MAX_VALUE);
		return fareList.size();
	}
	
}
