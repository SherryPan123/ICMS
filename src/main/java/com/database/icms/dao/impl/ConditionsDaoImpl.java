package com.database.icms.dao.impl;

import java.util.Date;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Property;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.database.icms.dao.ConditionsDao;
import com.database.icms.domain.Conditions;

@Repository
public class ConditionsDaoImpl extends BasicDaoImpl<Conditions> implements ConditionsDao{

	@Override
	public List<Conditions> list(int first, int max) {
		String hql = "from Conditions c order by c.id desc";
		return this.findByPageHql(first, max, hql);
	}

	@Override
	public List<Conditions> listDetail(Integer companyId, Integer[] carId, Integer[] employeeId, Date lendTime, Date returnTime,
			int first, int max) {
		Criteria crit = this.getSession().createCriteria(Conditions.class);
		if (-1 != companyId) {
			crit.add(Restrictions.eq("company.id", companyId));
		}
		if (null != carId) {
			crit.add(Restrictions.in("car.id", carId));
		}
		if (null != employeeId) {
			crit.add(Restrictions.in("employee.id", employeeId));
		}
		if (null != lendTime) {
			crit.add(Restrictions.le("lendTime", lendTime));
			crit.add(Restrictions.ge("returnTime", lendTime));
		}
		if (null != returnTime) {
			crit.add(Restrictions.le("lendTime", returnTime));
			crit.add(Restrictions.ge("returnTime", returnTime));
		}
		crit.setFirstResult(first);
		crit.setMaxResults(max);
		crit.addOrder(Property.forName("id").desc());
		@SuppressWarnings("unchecked")
		List<Conditions> conditionsList = (List<Conditions>)crit.list();
		return conditionsList;
	}

	@Override
	public Integer listAllDetailSize(Integer companyId, Integer[] carId, Integer[] employeeId, Date lendTime,
			Date returnTime) {
		List<Conditions> conditionsList = listDetail(companyId, carId, employeeId, lendTime, returnTime, 0, Integer.MAX_VALUE);
		return conditionsList.size();
	}

	@Override
	public List<Conditions> findByEmployee(Integer employeeId) {
		String hql = "from Conditions c where c.employee.id = ? order by c.id desc";
		return this.findByHql(hql, new Object[] { employeeId });
	}

}
