package com.example.ecom.service;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.ecom.model.Customer;

public interface CustomerRepo extends JpaRepository<Customer, Integer> {
	Customer findById(int id);
	boolean existsByEmail(String email);
	Customer findByEmail(String email);
}
