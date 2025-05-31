package com.example.ecom.service;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.ecom.model.Orderprod;

public interface OrderprodRepo extends JpaRepository<Orderprod, Integer> {
	Orderprod findByProductIdAndCustomerId(int productId, int customerId);
	List<Orderprod> findByCustomerId(int customerId);
	Orderprod findById(int id);
	@Query("SELECT o FROM Orderprod o WHERE o.customer.id = :cid AND o.product.perm = 'YES'")
	List<Orderprod> findByCustomerIdAndProductPermYes(@Param("cid") int cid);
}
