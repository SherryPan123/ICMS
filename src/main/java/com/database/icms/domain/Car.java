package com.database.icms.domain;

import java.util.Date;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "car")
public class Car {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@Column(name="plateNumber",unique = true) 
	private String plateNumber ; 
	
	@Column(name = "carType")
	private String carType ;
	
	@ManyToOne
	private Company company ;
	
	@Column(name = "buyTime")
	private Date buyTime ;
	
	@Column(name = "status")
	private Integer status ;

	@OneToMany (targetEntity = Accident.class)
	private Set<Accident> accident ;
	
	@OneToMany (targetEntity = Fare.class)
	private Set<Fare> fare ;
	
	@OneToMany(targetEntity = Conditions.class)
	private Set<Conditions> conditions ;
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getPlateNumber() {
		return plateNumber;
	}

	public void setPlateNumber(String plateNumber) {
		this.plateNumber = plateNumber;
	}

	public Company getCompany() {
		return company;
	}

	public void setCompany(Company company) {
		this.company = company;
	}

	public Date getBuyTime() {
		return buyTime;
	}

	public void setBuyTime(Date buyTime) {
		this.buyTime = buyTime;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
	
	
	
}
