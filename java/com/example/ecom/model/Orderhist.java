package com.example.ecom.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PostLoad;

@Entity
public class Orderhist {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String productname;
	
	private String oimg;
	
	private Double productprice;
	
	private String productdesc;
	
	private String sellername;
	
	private String custname;
	
	private int prodid;
	
	private int selrid;
	
	private int custid;
	
	private int bqty;
	
	private String datetime;
	
	private String finaldatetime;
	
	private Double taken;
	
	private Double refunded;
	
	private String orderstatus; 
	
	public Orderhist() {
		
	}
	
	public Orderhist(String pname, Double pprice, String pdesc, String sname, String cname, int slrid, int custid, int bqty, Double take, Double refu, int pid) {
		this.productname=pname;
		this.productprice=pprice;
		this.productdesc=pdesc;
		this.sellername=sname;
		this.prodid=pid;
		this.selrid=slrid;
		this.custid=custid;
		this.custname=cname;
		this.bqty=bqty;
		this.taken=take;
		this.refunded=refu;
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		this.datetime=now.format(formatter);
		this.finaldatetime = now.plusMinutes(10).format(formatter);   //order is permanent after 10 minutes
		updateOrderStatus();		
	}
	
	@PostLoad
	public void updateOrderStatus() {
		String check=this.orderstatus;
		if(check==null) {
			this.orderstatus="ongoing";
		}
		else if(check.equals("ongoing")){ 
			
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	        LocalDateTime now = LocalDateTime.now();
	        LocalDateTime finalDT = LocalDateTime.parse(this.finaldatetime, formatter);
	        this.orderstatus = now.isBefore(finalDT) ? "ongoing" : "completed";
		}
    }

    public int getProdid() {
		return prodid;
	}

	public String getOrderstatus() {
		return orderstatus;
	}

	public void setOrderstatus(String orderstatus) {
		this.orderstatus = orderstatus;
	}
	
	public String getOimg() {
		return oimg;
	}

	public void setOimg(String oimg) {
		this.oimg = oimg;
	}

	public int getId() {
		return id;
	}

	public String getProductname() {
		return productname;
	}

	public Double getProductprice() {
		return productprice;
	}

	public String getProductdesc() {
		return productdesc;
	}

	public String getSellername() {
		return sellername;
	}

	public int getSelrid() {
		return selrid;
	}

	public int getCustid() {
		return custid;
	}

	public int getBqty() {
		return bqty;
	}

	public String getDatetime() {
		return datetime;
	}

	public String getCustname() {
		return custname;
	}

	public Double getTaken() {
		return taken;
	}

	public Double getRefunded() {
		return refunded;
	}

	public void setTaken(Double taken) {
		this.taken = taken;
	}

	public void setRefunded(Double refunded) {
		this.refunded = refunded;
	}

}
