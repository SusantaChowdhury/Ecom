package com.example.ecom.service;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.ecom.model.Orderhist;

public interface OrderhistRepo extends JpaRepository<Orderhist, Integer> {
	List<Orderhist> findByCustid(int custid);
	Orderhist findById(int id);
}
