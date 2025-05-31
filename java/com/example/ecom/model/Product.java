package com.example.ecom.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class Product {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@ManyToOne(optional = false) 
	@JoinColumn(name = "seller_id", nullable = false)
    private Seller seller;
	
	private String name;
	
	private String imgp;
	
	private double price;
	
	private int quantity;
	
	private String pd;
	
	private String perm;
	
	public Product() {
	}
	
	public Product(Seller P_seller, String name, double price, String pd, int quantity) {
		this.seller=P_seller;
		this.name=name;
		this.price=price;
		this.pd=pd;		
		this.perm="NO";
		this.quantity=quantity;
	}

	public int getId() {
		return id;
	}

	public String getImgp() {
		return imgp;
	}

	public void setImgp(String imgp) {
		this.imgp = imgp;
	}

	public Seller getSeller() {
		return seller;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getPd() {
		return pd;
	}

	public void setPd(String pd) {
		this.pd = pd;
	}

	public String getPerm() {
		return perm;
	}

	public void setPerm(String perm) {
		this.perm = perm;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	    
}