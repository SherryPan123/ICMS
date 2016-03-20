package com.database.icms.domain;

import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

@Entity
@Table(name = "employee")
public class Employee {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@NotEmpty
	@Column(name = "employeeId")
	private String employeeId;
	
	@NotEmpty
	@Column(name = "name")
	private String name;
	
	@NotEmpty
	@Column(name = "sex")
	private String sex;
	
	@NotEmpty
	@Column(name = "phone")
	private String phone;
	
	@Email
	private String email;
	
	@ManyToOne
	private Company company;

	@OneToMany(targetEntity = Accident.class,mappedBy = "driver")
	private Set<Accident> accident ;
	
	@OneToMany(targetEntity = Conditions.class,mappedBy = "employee")
	private Set<Conditions> conditions ;
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(String employeeId) {
		this.employeeId = employeeId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Company getCompany() {
		return company;
	}

	public void setCompany(Company company) {
		this.company = company;
	}

	public Set<Accident> getAccident() {
		return accident;
	}

	public void setAccident(Set<Accident> accident) {
		this.accident = accident;
	}

	public Set<Conditions> getConditions() {
		return conditions;
	}

	public void setConditions(Set<Conditions> conditions) {
		this.conditions = conditions;
	}
	
}
