<%@page import="com.example.ecom.model.Orderhist"%>
<%@page import="com.example.ecom.model.Customer"%>
<%@page import="com.example.ecom.model.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.example.ecom.model.Seller"%>
<%@page import="com.example.ecom.model.Admin"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Customer Details</title>
        <link rel="stylesheet" href="stylecart.css" />
    </head>
    	<%
    	Admin admi=(Admin)session.getAttribute("admin");
    	Customer s=(Customer)session.getAttribute("custinfo");
    	List<Orderhist> op=(List<Orderhist>)request.getAttribute("ordhistofcust");
    	%>
        <body style="background-image: url(images/shop.jpg)">         
        <div style="display: inline-block; justify-content: center; text-align: center; 
            border-top-left-radius: 20px; background-color: white; flex-direction: column; 
            border-top-right-radius: 20px; margin-left: auto; margin-right: auto; margin-bottom: auto; width: 1214px;">
            <h2>Welcome to SwiftMart, Admin <%=admi.getUsername()%></h2>
        </div>
        <div style="display: inline-block; justify-content: center; align-items: center; font-size: 22px; 
             background-color: white; flex-direction: column; 
             margin-left: auto; margin-right: auto; margin-bottom: auto; width: 1214px">
            <table style="margin-right: auto; margin-top: auto; border-spacing: 0px">
            <tr>
            <th style="justify-content: center; text-align: justify; padding: 5px; background-color: cyan; 
                border-top-left-radius: 20px; border-top-right-radius: 20px; border: 1px solid black">
                <a href="customerlist"style="color: black; text-decoration: none;">
                    <b><=</b>                    
                </a>
            </th>
            <th style="justify-content: center;text-align: justify;padding: 5px; background-color: black; 
                border-top-left-radius: 20px; border-top-right-radius: 20px; border: 1px solid black">
                <a href="customer_det_oh" style="color: yellow; text-decoration: none;">
                <b>Order History</b>
                </a>
            </th>
            <th style="justify-content: center;text-align: justify;padding: 5px; background-color: #c0c0c0; 
                border-top-left-radius: 20px; border-top-right-radius: 20px; border: 1px solid black">
                <a href="customer_det_ct" style="color: black; text-decoration: none;">
                <b>Cart</b>
                </a>
            </th>
            </tr>
            </table>
            <div style="margin-bottom: auto; justify-content: center;text-align: justify;padding: 5px;
                 background-color: black; color: yellow; width: 1204px ">
                 <section class="cart-items">
                <%                    
                    if(op.isEmpty()){
                %>
                    No objects present now
                <%
                    }else{                
                        for(Orderhist x: op) {
                        	int oid=x.getId();
                            String p_name=x.getProductname();
                            String p_pd=x.getProductdesc();
                            Double p_price=x.getProductprice();
                            int bqty=x.getBqty();                        
                            String s_name=x.getSellername();
                            Double cost=p_price*bqty;
                            String dt=x.getDatetime();
                            Double taken=x.getTaken();
                            Double ref=x.getRefunded();
                            String statusw=x.getOrderstatus();
                            String statusmessage="";
                            if(statusw.equals("completed")){
                            	if(ref>0.0)
                            		statusmessage="Refunded";
                            	else
                            		statusmessage="Transaction done";
                            }
                            else if(statusw.equals("cancelled")){
                            	statusmessage="Cancelled";
                            }
                            else if(statusw.equals("tfailed") && ref>0){
                            	statusmessage="Transaction failed";
                            }
                            else if(statusw.equals("appeal")||statusw.equals("cnc")){
                            	statusmessage="Cancel Requested";
                            }
                            else if(statusw.equals("ongoing")){
                            	statusmessage="Ongoing Transaction";
                            }
                            else{
                            	statusmessage="";
                            }
                    %>
                    <div class="cart-item">
    			        <img src="<%=x.getOimg()%>" alt="Order <%=oid%>" />
    			        
    			        <div class="cart-name-price">
    			          <h2><%=p_name%></h2>
    			          <p class="price">₹<%=cost%></p>
    			        </div>
    			
	    			        <div class="cart-description">
	    			          <p><%=p_pd%></p>
	    			          <p class="seller-info">Seller: <%=s_name%></p>
	    			          </div>
	    			          <div class="cart-description">
	    			          <p class="stock-info">Quantity: <%=bqty%></p>
	    			          <p class="stock-info">Price: ₹<%=p_price%></p>
	    			        	</div>
	    			        <div class="cart-description">
	    			          <p class="stock-info">Date and Time:<br>
	    			           <%=dt%>
	    			           </p>
	    			        </div>
	    			        <div class="cart-description">
	    			          <p class="stock-info">Customer : <%=s.getName()%></p>
	    			          <p class="stock-info">Customer mail: <%=s.getEmail()%></p>
	    			          <p class="stock-info">Customer Id: <%=s.getId()%></p>
	    			        	</div>   
	                   		<div class="cart-description">
	   				          <p class="stock-info"><b><%=statusmessage%></b></p>
	   				        </div>
                        </div>
                        <%
                        }}
                    	%>
                </section>
            </div>
        </div>
        <script>			    
			    setInterval(function() {
			        location.reload();
			    }, 5000);
			</script>
        </body>    
</html>