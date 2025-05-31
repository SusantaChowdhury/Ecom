package com.example.ecom.service;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.ecom.model.Product;
import com.example.ecom.model.Seller;

public interface ProductRepo extends JpaRepository<Product, Integer> {
	Product findById(int id);
	List<Product> findByPerm(String perm);
	List<Product> findBySeller_IdAndPerm(int sellerId, String perm);
	List<Product> findBySellerAndPerm(Seller seller, String perm);
	Product findByIdAndNameAndPriceAndPd(int id, String name, double price, String pd);
	
	@Modifying
	@Query("UPDATE Product p SET p.quantity = p.quantity + :delta WHERE p.id = :id AND p.quantity + :delta >= 0")
	int safeUpdateQuantity(@Param("id")int id, @Param("delta")int delta);
	
	@Modifying
	@Query("UPDATE Product p SET p.quantity = p.quantity - :qty WHERE p.id = :productId AND p.perm = 'YES' AND p.quantity >= :qty AND :valueToCheck = (:qty * p.price)")
	int atomicBuyCheck(@Param("productId")int productId, @Param("qty")int qty, @Param("valueToCheck")double valueToCheck);

}
