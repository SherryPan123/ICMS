package com.database.icms.domain;

import java.util.*; 

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


@Entity
@Table(name = "fare")
public class Fare
{
	@Id
	@Column(name = "id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id ;
	
	@ManyToOne
	private Car carId ;
	
	@Column(name = "expense")
	private Integer expense ;
	
	@Column(name = "type")
	private String type ;
	
	@Column(name = "date")
	private Date time ;
	
	@Column(name = "operator")
	private String Operator ;

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

	public Integer getExpense() {
		return expense;
	}

	public void setExpense(Integer expense) {
		this.expense = expense;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getOperator() {
		return Operator;
	}

	public void setOperator(String operator) {
		Operator = operator;
	}
	
	
	
}