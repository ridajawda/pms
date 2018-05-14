package com.pavan.model;

import java.util.Date;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "PROJECT")
public class ProjectBO {

	@Id
	@Column(name = "ID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(name = "PROJECT_TYPE")
	private String projectType;

	@Column(name = "PROJECT_NAME")
	private String name;

	@Column(name = "DESCRIPTION")
	private String description;

	@Column(name = "START_DATE")
	@DateTimeFormat(pattern = "dd-MM-yyyy")
	private Date startDate;

	@Column(name = "END_DATE")
	@DateTimeFormat(pattern = "dd-MM-yyyy")
	private Date endDate;

	@Column(name = "COST")
	private Float cost;

	@ManyToMany(mappedBy = "projects", fetch = FetchType.EAGER)
	private Set<EmployeeBO> employees;
	
	@ManyToMany(mappedBy = "projects", fetch = FetchType.EAGER)
	private Set<ClientBO> clients;
	
	@ManyToMany(mappedBy = "projects", fetch = FetchType.EAGER)
	private Set<ConsultantBO> consultants;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getProjectType() {
		return projectType;
	}

	public void setProjectType(String projectType) {
		this.projectType = projectType;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public Float getCost() {
		return cost;
	}

	public void setCost(Float cost) {
		this.cost = cost;
	}

	public Set<EmployeeBO> getEmployees() {
		return employees;
	}

	public void setEmployees(Set<EmployeeBO> employees) {
		this.employees = employees;
	}

	public Set<ClientBO> getClients() {
		return clients;
	}

	public void setClients(Set<ClientBO> clients) {
		this.clients = clients;
	}

	public Set<ConsultantBO> getConsultants() {
		return consultants;
	}

	public void setConsultants(Set<ConsultantBO> consultants) {
		this.consultants = consultants;
	}

}
