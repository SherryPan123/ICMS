package com.database.icms.dao;

import java.io.Serializable;
import java.util.List;

public interface BasicDao<T> {

	//����ID����ʵ��
	T get(Class<T> entityClazz, Serializable id);
	
	//����ʵ��
	Serializable save(T entity);
	
	//����ʵ��
	void update(T entity);
	
	//��������ʵ��
	void saveOrUpdate(T entity);
	
	//ɾ��ʵ��
	void delete(T entity);
	
	//��ȡ����ʵ��
	List<T> findAll(Class<T> entityClazz);

	//��ȡʵ������
	long findCount(Class<T> entityClazz);

	//ͨ��HQL�����в�ѯ����
	List<T> findByHql(String hql, Object... params);
	
	//ͨ��HQL�����з�ҳ��ѯ����
	List<T> findByPageHql(int pageNo, int pageSize, String hql, Object... params);

	//ͨ��SQL�����в�ѯ����
	List<T> findBySql(String sql);

	//ͨ��SQL�����з�ҳ��ѯ����
	List<T> findByPageSql(int pageNo, int pageSize, String sql, Object... params);
	
}