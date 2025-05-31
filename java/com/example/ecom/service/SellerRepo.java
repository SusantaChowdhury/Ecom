package com.example.ecom.service;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.ecom.model.Seller;

public interface SellerRepo extends JpaRepository<Seller, Integer> {
	List<Seller> findByPerm(String perm);
	boolean existsByEmail(String email);
	Seller findByEmail(String email);
	Seller findById(int id);
}
