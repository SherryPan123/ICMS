package com.database.icms.dao;

import java.io.Serializable;
import java.util.List;

public interface BasicDao<T> {

	T get(Class<T> entityClazz, Serializable id);
	
	Serializable save(T entity);
	
	void update(T entity);
	
	void saveOrUpdate(T entity);
	
	void delete(T entity);
	
	List<T> findAll(Class<T> entityClazz);

	long findCount(Class<T> entityClazz);

	List<T> findByHql(String hql, Object... params);
	
	List<T> findByPageHql(int pageNo, int pageSize, String hql, Object... params);

	List<T> findBySql(String sql);

	List<T> findByPageSql(int pageNo, int pageSize, String sql, Object... params);
	
}