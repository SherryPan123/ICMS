package com.database.icms.dao;

import java.io.Serializable;
import java.util.List;

public interface BasicDao<T> {

	//根据ID加载实体
	T get(Class<T> entityClazz, Serializable id);
	
	//保存实体
	Serializable save(T entity);
	
	//更新实体
	void update(T entity);
	
	//保存或更新实体
	void saveOrUpdate(T entity);
	
	//删除实体
	void delete(T entity);
	
	//获取所有实体
	List<T> findAll(Class<T> entityClazz);
	
	//获取实体总数
	long findCount(Class<T> entityClazz);
	
	//通过HQL语句进行查询操作
	List<T> findByHql(String hql, Object... params);
	
	//通过HQL语句进行分页查询操作
	List<T> findByPageHql(int pageNo, int pageSize, String hql, Object... params);
	
	//通过SQL语句进行查询操作
	List<T> findBySql(String sql);
	
	//通过SQL语句进行分页查询操作
	List<T> findByPageSql(int pageNo, int pageSize, String sql, Object... params);
	
}