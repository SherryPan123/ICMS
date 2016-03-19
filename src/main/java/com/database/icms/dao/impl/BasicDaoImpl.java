package com.database.icms.dao.impl;

import java.io.Serializable;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import com.database.icms.dao.BasicDao;

public class BasicDaoImpl<T> implements BasicDao<T> {

	private Class<?> entityClass;// T real type

	@Autowired
	@Qualifier("sessionFactory")
	private SessionFactory sessionFactory;
	
	protected Session getSession() {
		return this.sessionFactory.getCurrentSession();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public T get(Class<T> entityClazz, Serializable id) {
		return (T) this.getSession().get(entityClass, id);
	}

	@Override
	public Serializable save(T entity) {
		return this.getSession().save(entity);
	}

	@Override
	public void update(T entity) {
		this.getSession().update(entity);
	}
	
	@Override
	public void saveOrUpdate(T entity) {
		this.getSession().saveOrUpdate(entity);
	}

	@Override
	public void delete(T entity) {
		this.getSession().delete(entity);
	}

	@Override
	public List<T> findAll(Class<T> entityClazz) {
		return findByHql("select entity from" + entityClazz.getSimpleName() + "entity");
	}

	@Override
	public long findCount(Class<T> entityClazz) {
		List<?> l = findByHql("select count(*) from" + entityClazz.getSimpleName());
		if(l != null && l.size() == 1) {
			return (Long)l.get(0);
		}
		return 0;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<T> findByHql(String hql, Object... params) {
		Query query = this.getSession().createQuery(hql);
		for(int i = 0, len = params.length; i < len; i++) {
			query.setParameter(i, params[i]);
		}
		return (List<T>)query.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<T> findByPageHql(int pageNo, int pageSize, String hql, Object... params) {
		Query query = this.getSession().createQuery(hql);
		for(int i = 0, len = params.length; i < len; i++) {
			query.setParameter(i, params[i]);
		}
		query.setFirstResult((pageNo - 1) * pageSize).setMaxResults(pageSize);
		return (List<T>)query.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<T> findBySql(String sql) {
		Session session = this.getSession();
		SQLQuery query = session.createSQLQuery(sql);
		query.addEntity(entityClass);
		return (List<T>) query.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<T> findByPageSql(int pageNo, int pageSize, String sql, Object... params) {
		Session session = this.getSession();
		SQLQuery query = session.createSQLQuery(sql);
		query.addEntity(entityClass);
		query.setFirstResult((pageNo - 1) * pageSize).setMaxResults(pageSize);
		return (List<T>) query.list();
	}

}
