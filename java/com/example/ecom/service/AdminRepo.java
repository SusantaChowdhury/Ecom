package com.example.ecom.service;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.ecom.model.Admin;

public interface AdminRepo extends JpaRepository<Admin, String> {
	Admin findByUsername(String username);
}
