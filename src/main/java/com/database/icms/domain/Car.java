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

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Past;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "car")
public class Car {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@Size(max = 10,min=5)
	@Column(name="plateNumber",unique = true) 
	private String plateNumber ; 
	
	@Size(max = 40)
	@Column(name = "carType")
	@NotEmpty
	private String carType ;
	
	@ManyToOne
	private Company company ;
	
	@DateTimeFormat(pattern="yyyy.MM.dd")
    @Past @NotNull
	@Column(name = "buyTime")
	private Date buyTime ;
	
	@Column(name = "status")
	private Integer status ;//1代表可用，0代表不可用

	@OneToMany (targetEntity = Accident.class,mappedBy = "car")
	private Set<Accident> accident ;
	
	@OneToMany (targetEntity = Fare.class,mappedBy = "car")
	private Set<Fare> fare ;
	
	@OneToMany(targetEntity = Conditions.class,mappedBy = "car")
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

	public String getCarType() {
		return carType;
	}

	public void setCarType(String carType) {
		this.carType = carType;
	}

	public Set<Accident> getAccident() {
		return accident;
	}

	public void setAccident(Set<Accident> accident) {
		this.accident = accident;
	}

	public Set<Fare> getFare() {
		return fare;
	}

	public void setFare(Set<Fare> fare) {
		this.fare = fare;
	}

	public Set<Conditions> getConditions() {
		return conditions;
	}

	public void setConditions(Set<Conditions> conditions) {
		this.conditions = conditions;
	}
	
	@Override
	public String toString()
	{
		return "id:\t"+id+"\nplateNumber:\t"+plateNumber+"\ncarType:\t"+carType+"\nCompany:\n"+company.toString();
	}
}
