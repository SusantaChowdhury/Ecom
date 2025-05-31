package com.example.ecom.controller;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.ecom.model.Admin;
import com.example.ecom.model.Customer;
import com.example.ecom.model.Orderhist;
import com.example.ecom.model.Orderprod;
import com.example.ecom.model.Product;
import com.example.ecom.model.Seller;
import com.example.ecom.service.AdminRepo;
import com.example.ecom.service.CustomerRepo;
import com.example.ecom.service.OrderhistRepo;
import com.example.ecom.service.OrderprodRepo;
import com.example.ecom.service.ProductRepo;
import com.example.ecom.service.SellerRepo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

@Controller
public class AdminPageController {
	
	@Autowired
	private AdminRepo arepo;
	
	@Autowired
	private ProductRepo prepo;
	
	@Autowired
	private SellerRepo srepo;
	
	@Autowired
	private CustomerRepo crepo;
	
	@Autowired
	private OrderprodRepo orepo;
	
	@Autowired
	private OrderhistRepo ohrepo;
	
	@RequestMapping("/productlist")
	public String productlist(HttpServletRequest request, HttpSession session) {
		List<Product> prod_y_perm=prepo.findByPerm("YES");
		request.setAttribute("prod_y_perm", prod_y_perm);		
		return "productlist";
	}

	@RequestMapping("/Adminpage")
	public String Adminpage() {
		return "Adminpage";
	}

	@RequestMapping("/logoutadmin")
	public String logoutadmin() {
		return "logoutadmin";
	}
	
	@RequestMapping("/adminhome")
	public String adminhome(HttpSession session, HttpServletRequest request) {
		if(session.getAttribute("page")!=null) {
			session.setAttribute("page", null);			
		}
		if(session.getAttribute("sellerinfo")!=null) {
			session.setAttribute("sellerinfo", null);			
		}
		List<Seller> perm_seller=srepo.findByPerm("YES");
		request.setAttribute("perm_seller",perm_seller);		
		return "adminhome";
	}
	
	@RequestMapping("/passivesellers")
	public String passivesellers(HttpSession session, HttpServletRequest request) {
		if(session.getAttribute("page")!=null) {
			session.setAttribute("page", null);			
		}
		if(session.getAttribute("sellerinfo")!=null) {
			session.setAttribute("sellerinfo", null);			
		}
		List<Seller> nonperm_seller=srepo.findByPerm("NO");
		request.setAttribute("nonperm_seller",nonperm_seller);
		return "passivesellers";
	}
	
	@RequestMapping("/customerlist")
	public String customerlist(HttpSession session, HttpServletRequest request) {
		if(session.getAttribute("custinfo")!=null) {
			session.setAttribute("custinfo", null);			
		}
		List<Customer> allcust=crepo.findAll();
		request.setAttribute("allcust",allcust);
		return "customerlist";
	}
	
	@RequestMapping("/orderslist")
	public String orderslist(HttpServletRequest request) {
		List<Orderhist> allordhist=ohrepo.findAll();
		Collections.reverse(allordhist);
		request.setAttribute("allordhist",allordhist);
		return "orderslist";
	}
	
	@RequestMapping("/seller_det")
	public String seller_det(@RequestParam("sellr_id")int sid, @RequestParam("page")String retp, 
			HttpSession session, HttpServletRequest request) {
		Seller s=(Seller)srepo.findById(sid);
		session.setAttribute("sellerinfo", s);
		session.setAttribute("page", retp);
		return "redirect:/seller_det_sp";
	}
	
	@RequestMapping("/seller_det_sp")
	public String seller_det_sp(HttpSession session, HttpServletRequest request) {
		Seller s=(Seller)session.getAttribute("sellerinfo");
		List<Product> permprodfsid=(List<Product>)prepo.findBySellerAndPerm(s, "YES");
		request.setAttribute("permprodfsid", permprodfsid);
		return "seller_det_sp";
	}
	
	@RequestMapping("/seller_det_pp")
	public String seller_det_pp(HttpSession session, HttpServletRequest request) {
		Seller s=(Seller)session.getAttribute("sellerinfo");
		List<Product> nonpermprodfsid=(List<Product>)prepo.findBySellerAndPerm(s, "NO");
		request.setAttribute("nonpermprodfsid", nonpermprodfsid);
		return "seller_det_pp";
	}
	
	@RequestMapping("/seller_det_page")
	public String seller_det_page(HttpSession session) {
		Seller s=(Seller)session.getAttribute("sellerinfo");
		return "seller_det_page";
	}
	
	@Transactional
	@RequestMapping("/acceptcancel")
	public String acceptcancel(@RequestParam("orderhist_id")int ohid) {
		Orderhist ordhstobj=ohrepo.findById(ohid);
		Product p=prepo.findByIdAndNameAndPriceAndPd(ordhstobj.getProdid(),ordhstobj.getProductname(), ordhstobj.getProductprice(), ordhstobj.getProductdesc());
		if(p==null) {
			ordhstobj.setOrderstatus("cnc");
			ohrepo.save(ordhstobj);
			return "redirect:/orderslist";						
		}
		else {
			ordhstobj.setOrderstatus("cancelled");
			ordhstobj.setRefunded(ordhstobj.getTaken());
			ordhstobj.setTaken(0.0);
			prepo.safeUpdateQuantity(p.getId(), ordhstobj.getBqty());
			ohrepo.save(ordhstobj);
			return "redirect:/orderslist";
		}
	}
	
	@RequestMapping("/rejectcancel")
	public String rejectcancel(@RequestParam("orderhist_id")int ohid) {
		Orderhist ordhstobj=ohrepo.findById(ohid);
		ordhstobj.setOrderstatus("completed");
		ohrepo.save(ordhstobj);
		return "redirect:/orderslist";
	}
	
	@RequestMapping("/customer_det")
	public String customer_det(@RequestParam("cust_id")int cid, 
			HttpSession session, HttpServletRequest request) {
		Customer c=(Customer)crepo.findById(cid);
		session.setAttribute("custinfo", c);		
		return "redirect:/customer_det_oh";
	}
	
	@RequestMapping("/customer_det_oh")
	public String customer_det_oh(HttpSession session, HttpServletRequest request) {
		Customer c=(Customer)session.getAttribute("custinfo");
		List<Orderhist> ordhistofcust=(List<Orderhist>)ohrepo.findByCustid(c.getId());
		Collections.reverse(ordhistofcust);
		request.setAttribute("ordhistofcust", ordhistofcust);
		return "customer_det_oh";
	}
	
	@RequestMapping("/customer_det_ct")
	public String customer_det_ct(HttpSession session, HttpServletRequest request) {
		Customer c=(Customer)session.getAttribute("custinfo");
		List<Orderprod> cartofcust=(List<Orderprod>)orepo.findByCustomerId(c.getId());
		request.setAttribute("cartofcust", cartofcust);
		return "customer_det_ct";
	}
	
	@Transactional
	@RequestMapping("/Remsellerperm")
	public String Remsellerperm(@RequestParam("sellr_id")int sid) {
		List<Product> plist=(List<Product>)prepo.findBySeller_IdAndPerm(sid, "YES");
		Seller s=(Seller)srepo.findById(sid);
		for(Product x: plist) {
			x.setPerm("NO");
			prepo.save(x);
		}	
		s.setPerm("NO");
		srepo.save(s);
		return "redirect:/adminhome";
	}
	
	@Transactional
	@RequestMapping("/Givsellerperm")
	public String Givsellerperm(@RequestParam("sellr_id")int sid) {
		Seller s=(Seller)srepo.findById(sid);
		s.setPerm("YES");
		srepo.save(s);
		return "redirect:/passivesellers";
	}
	
	@Transactional
	@RequestMapping("/Remprodperm")
	public String Remprodperm(@RequestParam("prodid")int pid) {
		Product x=(Product)prepo.findById(pid);
		x.setPerm("NO");
		prepo.save(x);	
		return "redirect:/seller_det_sp";
	}
	
	@Transactional
	@RequestMapping("/Remadminprodperm")
	public String Remadminprodperm(@RequestParam("prodid")int pid) {
		Product x=(Product)prepo.findById(pid);
		x.setPerm("NO");
		prepo.save(x);	
		return "redirect:/productlist";
	}
	
	@Transactional
	@RequestMapping("/Giveprodperm")
	public String Giveprodperm(@RequestParam("prodid")int pid) {
		Product x=(Product)prepo.findById(pid);
		if(x.getSeller().getPerm().equals("YES")) {
			x.setPerm("YES");
			prepo.save(x);			
		}			
		return "redirect:/seller_det_pp";
	}
	
	@RequestMapping("/LoginAdmin")
	public String LoginAdmin(@RequestParam("admin_name")String aname,
			@RequestParam("admin_password")String apass, ModelMap model, 
			HttpSession session, HttpServletRequest request) 
	{
		Admin admi=arepo.findByUsername(aname);
		if(admi!=null) {
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(5);
			if (encoder.matches(apass, admi.getPassword())) {
		        session.setAttribute("admin", admi); 
		        return "redirect:/adminhome";
		    }
		}
		model.addAttribute("msg", "alfail");
		return "Adminpage";
	}

}
