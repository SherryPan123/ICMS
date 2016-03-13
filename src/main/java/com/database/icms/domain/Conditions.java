package com.database.icms.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
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
	private Car carId ;
	
	@ManyToOne
	private Employee employeeId ;
	
	@Column(name = "lendtime")
	private Date lendTime ;
	
	@Column(name = "returntime")
	private Date returnTime ;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Car getCarId() {
		return carId;
	}

	public void setCarId(Car carId) {
		this.carId = carId;
	}



	public Employee getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(Employee employeeId) {
		this.employeeId = employeeId;
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

	public void setReturnTime(Date returnTime) {
		this.returnTime = returnTime;
	}
	
	

}
