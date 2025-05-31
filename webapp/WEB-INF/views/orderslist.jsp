<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.example.ecom.model.Admin"%>
<%@page import="com.example.ecom.model.Orderhist"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Customers List</title>
        <link rel="stylesheet" href="stylecart.css" />
    </head>
        <%
    		Admin admi=(Admin)session.getAttribute("admin");
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
            <th style="justify-content: center; text-align: justify; padding: 5px; background-color: #c0c0c0; 
                border-top-left-radius: 20px; border-top-right-radius: 20px; border: 1px solid black">
                <a href="adminhome"style="color: black; text-decoration: none;">
                    <b>Active Sellers</b>                    
                </a>
            </th>
            <th style="justify-content: center;text-align: justify;padding: 5px; background-color: #c0c0c0; 
                border-top-left-radius: 20px; border-top-right-radius: 20px; border: 1px solid black">
                <a href="passivesellers" style="color: black; text-decoration: none;">
                <b>Sellers Pending Permission</b>
                </a>
            </th>
            <th style="justify-content: center;text-align: justify;padding: 5px; background-color: #c0c0c0; 
                border-top-left-radius: 20px; border-top-right-radius: 20px; border: 1px solid black">
                <a href="customerlist" style="color: black; text-decoration: none;">
                <b>Customers</b>
                </a>
            </th>
            <th style="justify-content: center;text-align: justify;padding: 5px; background-color: #c0c0c0; 
                border-top-left-radius: 20px; border-top-right-radius: 20px; border: 1px solid black">
                <a href="productlist" style="color: black; text-decoration: none;">
                <b>Selling Products</b>
                </a>
            </th>
            <th style="justify-content: center;text-align: justify;padding: 5px; background-color: black; 
                border-top-left-radius: 20px; border-top-right-radius: 20px; border: 1px solid black">
                <a href="orderslist" style="color: yellow; text-decoration: none;">
                <b>Orders</b>
                </a>
            </th>
            <th style="justify-content: center;text-align: justify;padding: 5px; background-color: #c0c0c0; 
                border-top-left-radius: 20px; border-top-right-radius: 20px; border: 1px solid black">
                <a href="logoutadmin" style="color: black; text-decoration: none;">
                <b>Logout</b>
                </a>
            </th>
            </tr>
            </table>
            <div style="margin-bottom: auto; justify-content: center;text-align: justify;padding: 5px;
                 background-color: black; color: yellow; width: 1204px ">
                 
                <%
                    List<Orderhist> op=(List<Orderhist>)request.getAttribute("allordhist");
                    if(op.isEmpty()){
                %>
                    No objects present now
                <%
                    }else{
                %>
                <section class="cart-items">
                <%
                    for(Orderhist x: op) {
                    	int oid=x.getId();
                        String p_name=x.getProductname();
                        String p_pd=x.getProductdesc();
                        Double p_price=x.getProductprice();
                        int p_id=x.getProdid();
                        int bqty=x.getBqty();
                        int c_id=x.getCustid();
                        int s_id=x.getSelrid();
                        String c_name=x.getCustname();
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
                        else if(statusw.equals("ongoing")){
                        	statusmessage="Ongoing";
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
			          <p class="seller-info">Seller-ID: <%=s_id%></p>
			          </div>
			          
			          <div class="cart-description">
			          <p>Customer ID: <%=c_id%></p>
			          <p class="seller-info">Customer: <%=c_name%></p>
			          </div>
			          
			          <div class="cart-description">
			          <p class="stock-info">Product-ID: <%=p_id%></p>
			          <p class="stock-info">Quantity: <%=bqty%></p>
			          <p class="stock-info">Price: ₹<%=p_price%></p>
			        </div>
			        <div class="cart-description">
			          <p class="stock-info">Date and Time:<br>
			           <%=dt%>
			           </p>
			        </div>     
                    <%
                    if(statusw.equals("appeal")){
                	%>
                	<div class="cart-description">
			          <div class="stock-info">
	                	<div class="cart-actions">
		                	<form action="acceptcancel" method="post">   
					            <input type="hidden" name="orderhist_id" value="<%=oid%>">
					            <button type="submit" class="qty-btn">Accept</button>                                          
					        </form>
					        <form action="rejectcancel" method="post">   
					            <input type="hidden" name="orderhist_id" value="<%=oid%>">
					            <button type="submit" class="rej-btn">Reject</button>                                          
					        </form>
	                	</div>
	                	</div>
                	</div>
                	<%
                    	}
                    else if(statusw.equals("cnc")){
                	%>
                	<div class="cart-description">
                	<p class="stock-info"><b>Can't be cancelled</b></p>
			          <div class="stock-info">
	                	<div class="cart-actions">		                	
					        <form action="rejectcancel" method="post">   
					            <input type="hidden" name="orderhist_id" value="<%=oid%>">
					            <button type="submit" class="rej-btn">Reject</button>                                          
					        </form>
	                	</div>
	                	</div>
                	</div>                	
                  	<%
                 		}
                    	else{
                   	%>
                   		<div class="cart-description">
				          <p class="stock-info"><b><%=statusmessage%></b></p>
				        </div>
                   	<%
                    		}
                    %>
                    </div>            	
                <%
                		}
                %>
                </section>
                <%
                	}
                %>
            </div>
        </div>
        <script>			    
			    setInterval(function() {
			        location.reload();
			    }, 5000);
			</script>
        </body>    
</html>