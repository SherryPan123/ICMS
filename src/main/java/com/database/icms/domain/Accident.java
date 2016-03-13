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
@Table(name = "accident")
public class Accident {
	
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer id ;
	
	@ManyToOne
	private Car carId ;
	
	@ManyToOne
	private Employee driverId ;
	
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

	
	public Car getCarId() {
		return carId;
	}

	public void setCarId(Car carId) {
		this.carId = carId;
	}
	
	
	public Employee getDriverId() {
		return driverId;
	}

	public void setDriverId(Employee driverId) {
		this.driverId = driverId;
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
