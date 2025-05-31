package com.example.ecom.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.ecom.model.Customer;
import com.example.ecom.model.Orderhist;
import com.example.ecom.model.Orderprod;
import com.example.ecom.model.Product;
import com.example.ecom.service.CustomerRepo;
import com.example.ecom.service.OrderhistRepo;
import com.example.ecom.service.OrderprodRepo;
import com.example.ecom.service.ProductRepo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

@Controller
public class CustomerController {
	
	@Autowired
	private CustomerRepo crepo;
	
	@Autowired
	private ProductRepo prepo;
	
	@Autowired
	private OrderprodRepo orepo;
	
	@Autowired
	private OrderhistRepo ordhist;

	@RequestMapping("/customer_login")
	public String customer_login() {
		return "customer_login";
	}
	
	@RequestMapping("/register_customer")
	public String register_customer() {
		return "register_customer";
	}
	
	@RequestMapping("/logout_customer")
	public String logout_customer() {
		return "logout_customer";
	}
	
	@RequestMapping("/customerhome")
	public String customerhome(HttpServletRequest request, HttpSession session) {
		List<Product> prod_y_perm=prepo.findByPerm("YES");
		request.setAttribute("prod_y_perm", prod_y_perm);		
		return "customerhome";
	}
	
	public boolean validEmail(String mail) {
	    if (mail == null || mail.isEmpty()) {
	        return false;
	    }

	    // Allowed email domains
	    String[] allowedDomains = {"gmail.com", "rediffmail.com", "yahoomail.com"};

	    // Split the email into two parts: local part and domain part
	    int atIndex = mail.lastIndexOf('@');
	    if (atIndex <= 0 || atIndex == mail.length() - 1) {
	        return false; // Invalid if @ is missing, at the start, or end
	    }

	    String localPart = mail.substring(0, atIndex);
	    String domainPart = mail.substring(atIndex + 1);

	    // Check if domain is in the allowed list
	    boolean isDomainValid = false;
	    for (String domain : allowedDomains) {
	        if (domain.equalsIgnoreCase(domainPart)) {
	            isDomainValid = true;
	            break;
	        }
	    }

	    if (!isDomainValid) {
	        return false;
	    }

	    return localPart.matches("^[A-Za-z0-9._%+-]+$");
	}
	
	@GetMapping("/product-qty")
	@ResponseBody
	public Map<Integer, Integer> getProductQuantities() {
	    List<Product> products = prepo.findByPerm("YES");
	    Map<Integer, Integer> qtyMap = new HashMap<>();
	    for (Product p : products) {
	        qtyMap.put(p.getId(), p.getQuantity());
	    }
	    return qtyMap;
	}
	
	@RequestMapping("/custcart")
	public String custcart(HttpSession session, HttpServletRequest request) {
		int cid=((Customer)session.getAttribute("customer")).getId();
		List<Orderprod> cartprods=orepo.findByCustomerIdAndProductPermYes(cid);
		request.setAttribute("cartprods", cartprods);		
		return "custcart";
	}
	
	@RequestMapping("/Addcart")
	public String Addcart(@RequestParam("product_id")int pid,HttpSession session) {
		Customer c=(Customer)session.getAttribute("customer");
		Orderprod check_o=orepo.findByProductIdAndCustomerId(pid, c.getId());
		if(check_o==null) {
			Product p=prepo.findById(pid);
			Orderprod o=new Orderprod(c,p);
			orepo.save(o);				
		}
		else {
			check_o.incQtybyOne();
			orepo.save(check_o);
		}
	    return "redirect:/customerhome";
	}
	
	// Single buying on front page
	@Transactional
	@RequestMapping("/Buynowsingle")
	public String Buynowsingle(@RequestParam("product_id")int pid,HttpSession session) {
		Customer c=(Customer)session.getAttribute("customer");
		Product p=(Product)prepo.findById(pid);
		int updated = prepo.atomicBuyCheck(pid, 1, p.getPrice());
		Orderhist ordhstobj;
		if(updated==1) {
			ordhstobj=ordhist.save(new Orderhist(p.getName(), p.getPrice(), p.getPd(), p.getSeller().getName(), c.getName(), p.getSeller().getId(), c.getId(), 1,p.getPrice(),0.0,p.getId()));
		}
		else {
			ordhstobj=ordhist.save(new Orderhist(p.getName(), p.getPrice(), p.getPd(), p.getSeller().getName(), c.getName(), p.getSeller().getId(), c.getId(), 1,0.0,p.getPrice(),p.getId()));
		}
		//image path from database
        String dbImagePath = "C:\\Users\\RG\\Desktop\\college_proj\\Ecom\\src\\main\\webapp"+p.getImgp();

        // Desired destination folder
        String destDir = "C:\\Users\\RG\\Desktop\\college_proj\\Ecom\\src\\main\\webapp\\ordimages";

        // New file name
        String newFileName ="oimg" + ordhstobj.getId() + "." +p.getImgp().substring(p.getImgp().lastIndexOf(".") + 1);

        // Define source and target paths
        Path sourcePath = Paths.get(dbImagePath);
        Path targetPath = Paths.get(destDir, newFileName);

        // Copy the file (replace if exists)
        try {
			Files.copy(sourcePath, targetPath, StandardCopyOption.REPLACE_EXISTING);
		} catch (IOException e) {
			return "redirect:/custordrhist";
		}
        ordhstobj.setOimg("/ordimages/"+newFileName);
        ordhist.save(ordhstobj);
		return "redirect:/custordrhist";
	}
	
	@Transactional
	@RequestMapping("/Buynowset")
	public String Buynowset(@RequestParam("cust_id")int cid,HttpSession session) {
		List<Orderprod> cl=orepo.findByCustomerId(cid);
		Customer c=(Customer)session.getAttribute("customer");
		Orderhist ordhstobj;
		for(Orderprod x: cl) {			
			Product p=x.getProduct();
			int updated = prepo.atomicBuyCheck(p.getId(), x.getQty(), (x.getQty()*p.getPrice()));
			if(updated==1) {
				ordhstobj=ordhist.save(new Orderhist(p.getName(), p.getPrice(), p.getPd(), p.getSeller().getName(), c.getName(), p.getSeller().getId(), c.getId(), x.getQty(),(p.getPrice()*x.getQty()),0.0,p.getId()));
				orepo.delete(x);
			}
			else {
				ordhstobj=new Orderhist(p.getName(), p.getPrice(), p.getPd(), p.getSeller().getName(), c.getName(), p.getSeller().getId(), c.getId(), x.getQty(),0.0,(p.getPrice()*x.getQty()),p.getId());
				ordhstobj=ordhist.save(ordhstobj);
			}
			//image path from database
	        String dbImagePath = "C:\\Users\\RG\\Desktop\\college_proj\\Ecom\\src\\main\\webapp"+p.getImgp();

	        // Desired destination folder
	        String destDir = "C:\\Users\\RG\\Desktop\\college_proj\\Ecom\\src\\main\\webapp\\ordimages";

	        // New file name
	        String newFileName ="oimg" + ordhstobj.getId() + "." +p.getImgp().substring(p.getImgp().lastIndexOf(".") + 1);

	        // Define source and target paths
	        Path sourcePath = Paths.get(dbImagePath);
	        Path targetPath = Paths.get(destDir, newFileName);

	        // Copy the file (replace if exists)
	        try {
				Files.copy(sourcePath, targetPath, StandardCopyOption.REPLACE_EXISTING);
			} catch (IOException e) {
				return "redirect:/custordrhist";
			}
	        ordhstobj.setOimg("/ordimages/"+newFileName);
	        ordhist.save(ordhstobj);
		}
		return "redirect:/custordrhist";
	}
	
	@RequestMapping("/custordrhist")
	public String custordrhist(HttpServletRequest request ,HttpSession session) {
		Customer c=(Customer)session.getAttribute("customer");
		List<Orderhist> p=(List<Orderhist>)ordhist.findByCustid(c.getId());
		Collections.reverse(p);
		request.setAttribute("ordhist",p);		
		return "custordrhist";
	}
	
	@RequestMapping("/cancelord")
	public String cancelord(@RequestParam("orderhist_id")int ohid) {
		Orderhist ordhstobj=ordhist.findById(ohid);
		ordhstobj.setOrderstatus("appeal");
		ordhist.save(ordhstobj);
		return "redirect:/custordrhist";
	}
	
	@RequestMapping("/Addprodcartval")
	public String Addprodcartval(@RequestParam("order_id")int oid ) {
		Orderprod check_o=(Orderprod)orepo.findById(oid);
		check_o.incQtybyOne();
		orepo.save(check_o);
	    return "redirect:/custcart";
	}
	
	@RequestMapping("/Subprodcartval")
	public String Subprodcartval(@RequestParam("order_id")int oid) {
		Orderprod check_o=(Orderprod)orepo.findById(oid);
		check_o.decQtybyOne();
		orepo.save(check_o);
	    return "redirect:/custcart";
	}
	
	@RequestMapping("/Delcart")
	public String Delcart(@RequestParam("order_id")int oid ) {
		orepo.deleteById(oid);
	    return "redirect:/custcart";
	}
	
	@RequestMapping("/RegisterCustomer")
	public String RegisterCustomer(@RequestParam("cust_name")String cname,
			@RequestParam("cust_mail")String cmail,@RequestParam("cust_password")String cpass,
			@RequestParam("cust_re_password")String confpass, ModelMap model ) 
	{
		if(cpass.equals(confpass)==false) {											//passwords don't match
			model.addAttribute("msg", "pfail");			
		}
		else if(crepo.existsByEmail(cmail)) {								//email already exists
			model.addAttribute("msg", "mxstfail");
		}
		else if(validEmail(cmail)== false) {
			model.addAttribute("msg", "emfail");		
		}
		else {
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(5);
			cpass=encoder.encode(cpass);
			Customer c=new Customer(cname,cmail, cpass);
			crepo.save(c); 			
			model.addAttribute("msg", "success");
		}
		return "register_customer";
	}
	
	@RequestMapping("/LoginCustomer")
	public String LoginCustomer(@RequestParam("cust_mail")String cmail,
			@RequestParam("cust_password")String cpass, ModelMap model,
			HttpSession session, HttpServletRequest request) 
	{
		Customer cust=crepo.findByEmail(cmail);
		if(cust!=null) {
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(5);
			if (encoder.matches(cpass, cust.getPassword())) {
				session.setAttribute("customer", cust); 
			    return "redirect:/customerhome";
			}
		}
		model.addAttribute("msg", "clfail");
		return "customer_login";		
	}
	
}