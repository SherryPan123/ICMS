package com.database.icms.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="conditions")
public class Conditions {
	
	@Id
	@Column(name = "id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id ;
	
	@ManyToOne
	@JoinColumn(name = "company_id" , referencedColumnName = "id")
	private Company company ;

	@ManyToOne
	@JoinColumn(name = "car_id" , referencedColumnName = "id")
	private Car car ;
	
	@ManyToOne
	@JoinColumn(name = "employee_id" , referencedColumnName = "id")
	private Employee employee ;
	
	@Column(name = "lendTime")
	private Date lendTime ;
	
	@Column(name = "returnTime")
	private Date returnTime ;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getLendTime() {
		return lendTime;
	}

	public void setLendTime(Date lendTime) {
		this.lendTime = lendTime;
	}

	public Date getReturnTime() {
		return returnTime;
	}

	public Car getCar() {
		return car;
	}

	public void setCar(Car car) {
		this.car = car;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public void setReturnTime(Date returnTime) {
		this.returnTime = returnTime;
	}
	
}
