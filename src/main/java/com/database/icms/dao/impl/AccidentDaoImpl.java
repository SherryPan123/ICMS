package com.database.icms.dao.impl;

import java.util.Date;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Property;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.database.icms.dao.AccidentDao;
import com.database.icms.domain.Accident;
import com.database.icms.domain.Fare;

@Repository
public class AccidentDaoImpl extends BasicDaoImpl<Accident> implements AccidentDao{

	@Override
	public List<Accident> listDetail(Integer companyId, String plateNumber,
			String driverId, Date startTime, Date endTime, int i, Integer max) {
		// TODO Auto-generated method stub
		Criteria crit = this.getSession().createCriteria(Accident.class) ;
		if (companyId != -1)  {
			crit.createAlias("car","car");
			crit.createAlias("car.company","company");
			if(companyId!=1){
				crit.add(Restrictions.eq("company.id", companyId));
			}
		}
		if (plateNumber != null && !plateNumber.isEmpty()){
			crit.add(Restrictions.eq("car.plateNumber",plateNumber)) ;
		}
		if (driverId != null){
			System.out.println("employeeId: "+driverId);
			crit.add(Restrictions.eq("driver.id",driverId)) ;
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
		crit.setFirstResult(i);
		crit.setMaxResults(max);
		crit.addOrder(Property.forName("id").desc());
		System.out.println("2");
		@SuppressWarnings("unchecked")
		List<Accident> accidentList = (List<Accident>)crit.list();
		System.out.println("3");
		return accidentList;
	}

	@Override
	public Integer listAllDetailSize(Integer companyId, String plateNumber,
			String driverId, Date startTime, Date endTime) {
		// TODO Auto-generated method stub
		List<Accident> accidentList = listDetail(companyId, plateNumber,driverId,  startTime,endTime ,0, Integer.MAX_VALUE);
		return accidentList.size();
	}

	@Override
	public Accident getAccidentById(Integer id) {
		// TODO Auto-generated method stub
		String hql = "from Accident a where a.id = ? ";
		List<Accident> accidentList = this.findByHql(hql, new Object[]{id});
		if( null != accidentList && accidentList.size() == 1 ) return accidentList.get(0);
		else return null;
	}


}
