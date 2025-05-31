package com.example.ecom.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class Seller {

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
    @Column(unique = true)
	private String email;
	
	private String password;
	
	private String docs;
	
	private String perm;

	public Seller() {
	}
	
	public Seller(String name,String email,String password) {
		this.name=name;
		this.email=email;
		this.password=password;
		this.perm="NO";
	}
	
	public String getPerm() {
		return perm;
	}

	public String getDocs() {
		return docs;
	}

	public void setDocs(String docs) {
		this.docs = docs;
	}

	public void setPerm(String perm) {
		this.perm = perm;
	}

	public String getPassword() {
		return password;
	}

	public int getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

}
