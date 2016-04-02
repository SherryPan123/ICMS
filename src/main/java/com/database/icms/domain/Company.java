package com.database.icms.domain;

import java.util.List;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.CascadeType;

import org.hibernate.validator.constraints.NotEmpty;

@Entity
@Table(name = "company")
public class Company {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@NotEmpty
	@Column(name = "name")
	private String name;

	@NotEmpty
	@Column(name = "username", unique = true)
	private String username;

	@NotEmpty
	@Column(name = "password")
	private String password;

	@Column(name = "address")
	private String address;

	@Column(name = "phone")
	private String phone;

	@ManyToOne
	private Role role;

	@OneToMany(targetEntity = Employee.class, mappedBy = "company")
	@Cascade(value={CascadeType.DELETE_ORPHAN,CascadeType.SAVE_UPDATE,CascadeType.ALL})//用于级联删除
	private Set<Employee> employees;

	@OneToMany(targetEntity = Car.class, mappedBy = "company")
	@Cascade(value={CascadeType.DELETE_ORPHAN,CascadeType.SAVE_UPDATE,CascadeType.ALL})//用于级联删除
	private Set<Car> cars;

	@OneToMany(targetEntity = Conditions.class,mappedBy = "company")
	@Cascade(value={CascadeType.DELETE_ORPHAN,CascadeType.SAVE_UPDATE,CascadeType.ALL})//用于级联删除
	private List<Conditions> conditionsList;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public Set<Employee> getEmployees() {
		return employees;
	}

	public void setEmployees(Set<Employee> employees) {
		this.employees = employees;
	}

	public Set<Car> getCars() {
		return cars;
	}

	public void setCars(Set<Car> cars) {
		this.cars = cars;
	}

	public List<Conditions> getConditionsList() {
		return conditionsList;
	}

	public void setConditionsList(List<Conditions> conditionsList) {
		this.conditionsList = conditionsList;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public Company() {

	}

	public Company(String name, String password, String address, String phone) {
		this.setAddress(address);
		this.setPassword(password);
		this.setName(name);
		this.setPhone(phone);
	}

	@Override
	public String toString() {
		return "id:"+id+"\tusername:"+username+"\tname:\t" + name + "\npassword:\t" + password + "\naddress:\t" + address + "\nphone:\t" + phone;
	}
	
}
