package com.pavan.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "CLIENT")
public class ClientBO {

	@Id
	@Column(name = "CLIENT_ID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(name = "NAME")
	private String name;

	@Column(name = "ADDRESS")
	private String address;

	@Column(name = "TELEPHONE")
	private String telephone;

	@Column(name = "EMAIL")
	private String email;

	@OneToMany(mappedBy = "clientBO",fetch = FetchType.EAGER)
	private List<ReviewBO> reviews;

	@ManyToMany(cascade = { CascadeType.ALL }, fetch = FetchType.EAGER)
	@JoinTable(name = "CLIENT_PROJECT", joinColumns = { @JoinColumn(name = "CLIENT_ID") }, inverseJoinColumns = {
			@JoinColumn(name = "PROJECT_ID") })
	Set<ProjectBO> projects;
		
	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

		
public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Set<ProjectBO> getProjects() {
		return projects;
	}

	public void setProjects(Set<ProjectBO> projects) {
		this.projects = projects;
	}

public List<ReviewBO> getReviews() {
		return reviews;
	}

	public void setReviews(List<ReviewBO> reviews) {
		this.reviews = reviews;
	}

public void add(ReviewBO review) {
		
		if (reviews ==null) {
			reviews = new ArrayList<ReviewBO>();
		}
		reviews.add(review);
		review.setClientBO(this);
	}

			
}
