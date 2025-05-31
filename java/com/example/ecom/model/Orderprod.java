package com.example.ecom.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class Orderprod {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@ManyToOne(optional = false) 
	@JoinColumn(name = "productid", nullable = false)
    private Product product;
	
	@ManyToOne(optional = false) 
	@JoinColumn(name = "custid", nullable = false)
    private Customer customer;
	
	private int qty;
	
	public Orderprod() {
		
	}
	
	public Orderprod(Customer c, Product p) {
		this.customer=c;
		this.product=p;
		this.qty=1;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public int getQty() {
		return qty;
	}

	public void setQty(int qty) {
		this.qty = qty;
	}
	
	public void incQtybyOne() {
		if(this.qty+1<=this.getProduct().getQuantity()) {
			this.qty+=1;
		}
	}
	
	public void decQtybyOne() {
		if(this.qty-1>0) {
			this.qty-=1;
		}		
	}
}
