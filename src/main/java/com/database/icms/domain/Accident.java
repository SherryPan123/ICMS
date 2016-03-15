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
@Table(name = "accident")
public class Accident {
	
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer id ;
	
	@ManyToOne(targetEntity=Car.class)
	@JoinColumn(name = "car" , referencedColumnName = "id")
	private Car car ;
	
	@ManyToOne(targetEntity=Employee.class)
	@JoinColumn(name = "driver" , referencedColumnName = "id")
	private Employee driver ;
	
	@Column(name = "time")
	private Date time ;
	
	@Column(name = "description")
	private String description ;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Car getCar() {
		return car;
	}

	public void setCar(Car car) {
		this.car = car;
	}

	public Employee getDriver() {
		return driver;
	}

	public void setDriver(Employee driver) {
		this.driver = driver;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	

	
	
	
}
