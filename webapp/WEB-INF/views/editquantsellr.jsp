<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.example.ecom.model.Seller"%>
<%@page import="com.example.ecom.model.Product"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>SelrPrdQntChng</title>
    </head>
    
        <%
        Seller c=(Seller)session.getAttribute("seller");
        String sellrname=c.getName();
        String sellrperm=c.getPerm();
        if(sellrperm.equals("NO")){
        %>
        <body>  
        <h1>Welcome to SwiftMart, <%=sellrname%></h1>
        <h2>Your request to do business is being evaluated. Contact with admin.</h2>
        <form action="Logout" method="post" style="font-size: 15px;">   
            <div style="align-items: center; margin-left: 250px">                       
                <button type="submit" style="padding: 10px; background: yellow; color: black;
                        border: none; border-radius: 5px;"><b>Logout</b></button><br>                                           
            </div>
        </form>
        </body>
        <%
        }else{
        %>
        <body style="background-image: url(images/shop.jpg)">         
        <div style="display: inline-block; justify-content: center; text-align: center; 
            border-top-left-radius: 20px; background-color: white; flex-direction: column; 
            border-top-right-radius: 20px; margin-left: auto; margin-right: auto; margin-bottom: auto; width: 1214px;">
            <h2>Welcome to SwiftMart, <%=sellrname%></h2>
        </div>
        <div style="display: inline-block; justify-content: center; align-items: center; font-size: 22px; 
             background-color: white; flex-direction: column; 
             margin-left: auto; margin-right: auto; margin-bottom: auto; width: 1214px">
            <table style="margin-right: auto; margin-top: auto; border-spacing: 0px">
            <tr>
            <th style="justify-content: center; text-align: justify; padding: 5px; background-color: cyan; 
                border-top-left-radius: 20px; border-top-right-radius: 20px;">
                <a href="sellerhome"style="color: black; text-decoration: none;">
                    <b><=</b>                    
                </a>
            </th>
            <th style="justify-content: center;text-align: justify;padding: 5px; background-color: black; 
                border-top-left-radius: 20px; border-top-right-radius: 20px; border: 1px solid black">
                <a href="editquantsellr" style="color: yellow; text-decoration: none;">
                <b>Add Quantity</b>
                </a>
            </th>
            </tr>
            </table>
            <div style="margin-bottom: auto; justify-content: center;text-align: justify;padding: 5px;
                 background-color: black; color: yellow; width: 1204px ">
                <%
                	Product x=(Product)session.getAttribute("prod_edit_quant");
                    if(x==null){
                %>
                    No ob
                <%
                    }
                    else{
                    	
                    	int p_id=x.getId();
                        String p_name=x.getName();
                        String p_pd=x.getPd();
                        Double p_price=x.getPrice();
                        int p_quant=x.getQuantity();
                        String pth=x.getImgp();
                %>
                <form action="editaddquantsellr" method="post" style="align-items: center; margin-left: 250px; font-size: 15px">
                        <br>
                        Product Image<br>
                        <img alt="productimage" src="<%=pth%>" width="100" height="100"><br>
                        Product Name<br>
                        <div style="width: 200px">
                        <%=p_name %>
                        </div><br>
                        Product Price(in Rs.)<br>
                        <div style="width: 200px">
                        <%=p_price %>
                        </div><br>
                        Product Description<br>
                         <div style="width: 200px">
                         <%=p_pd %>
                         </div><br>
                        Product Quantity(in whole numbers)<br>
                        <div style="width: 200px">
                         <%=p_quant %>
                         </div><br>
                         Add Product Quantity(in whole numbers)<br>
                         <input type="hidden" name="prod_id" value="<%=p_id%>">
                        <input type="text" name="addprod_quant" placeholder="Add number of new products" required 
                        style="width: 200px; padding: 10px; margin: 10px 0; border: 1px solid #ccc; border-radius: 5px;"><br>
                        <button type="submit" style="width: 200px; padding: 10px; background: yellow; color: black;
                        border: none; border-radius: 5px;">Add Quantity</button><br>                 
                    </form>
                    	<%
                            String getm=String.valueOf(request.getAttribute("msg"));                            
                            if(getm.equals("Success"))
                            {                                
                        %>
                            <p> 
                             Successfully added the quantity   
                            </p>
                        <%
                                }
                                else if(getm.equals("null")){}
                                else{
                        %>
                            <p style="font-family: Arial, sans-serif; color: red; font-size: 16px;"> 
                                <%= getm %>
                            </p>
                        <%                                
                            }
                        %>
            </div>            
        </div>
        </body>    
        <%
       			}
			}
		 %>
</html>