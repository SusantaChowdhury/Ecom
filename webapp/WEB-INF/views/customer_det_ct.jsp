<%@page import="com.example.ecom.model.Orderprod" %>
    <%@page import="com.example.ecom.model.Orderhist" %>
        <%@page import="com.example.ecom.model.Customer" %>
            <%@page import="com.example.ecom.model.Product" %>
                <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
                    <%@page import="com.example.ecom.model.Seller" %>
                        <%@page import="com.example.ecom.model.Admin" %>
                            <%@page import="java.util.List" %>
                                <!DOCTYPE html>
                                <html>

                                <head>
                                    <meta charset="UTF-8">
                                    <title>Customer Details</title>
                                    <link rel="stylesheet" href="stylecart.css" />
                                </head>
                                <% Admin admi=(Admin)session.getAttribute("admin"); Customer
                                    s=(Customer)session.getAttribute("custinfo"); List<Orderprod> op=(List<Orderprod>
                                        )request.getAttribute("cartofcust");
                                        %>

                                        <body style="background-image: url(images/shop.jpg)">
                                            <div style="display: inline-block; justify-content: center; text-align: center; 
            border-top-left-radius: 20px; background-color: white; flex-direction: column; 
            border-top-right-radius: 20px; margin-left: auto; margin-right: auto; margin-bottom: auto; width: 1214px;">
                                                <h2>Welcome to SwiftMart, Admin <%=admi.getUsername()%>
                                                </h2>
                                            </div>
                                            <div style="display: inline-block; justify-content: center; align-items: center; font-size: 22px; 
             background-color: white; flex-direction: column; 
             margin-left: auto; margin-right: auto; margin-bottom: auto; width: 1214px">
                                                <table
                                                    style="margin-right: auto; margin-top: auto; border-spacing: 0px">
                                                    <tr>
                                                        <th style="justify-content: center; text-align: justify; padding: 5px; background-color: cyan; 
                border-top-left-radius: 20px; border-top-right-radius: 20px; border: 1px solid black">
                                                            <a href="customerlist"
                                                                style="color: black; text-decoration: none;">
                                                                <b>
                                                                    <=< /b>
                                                            </a>
                                                        </th>
                                                        <th style="justify-content: center;text-align: justify;padding: 5px; background-color: #c0c0c0; 
                border-top-left-radius: 20px; border-top-right-radius: 20px; border: 1px solid black">
                                                            <a href="customer_det_oh"
                                                                style="color: black; text-decoration: none;">
                                                                <b>Order History</b>
                                                            </a>
                                                        </th>
                                                        <th style="justify-content: center;text-align: justify;padding: 5px; background-color: black; 
                border-top-left-radius: 20px; border-top-right-radius: 20px; border: 1px solid black">
                                                            <a href="customer_det_ct"
                                                                style="color: yellow; text-decoration: none;">
                                                                <b>Cart</b>
                                                            </a>
                                                        </th>
                                                    </tr>
                                                </table>
                                                <div style="margin-bottom: auto; justify-content: center;text-align: justify;padding: 5px;
                 background-color: black; color: yellow; width: 1204px ">
                                                    <section class="cart-items">
                                                        <% if(op.isEmpty()){ %>
                                                            No objects present now
                                                            <% }else{ double total=0.0; int nobuy=0; for(Orderprod x:
                                                                op) { int oid=x.getId(); String
                                                                p_name=x.getProduct().getName(); String
                                                                p_pd=x.getProduct().getPd(); Double
                                                                p_price=x.getProduct().getPrice(); int
                                                                avlqty=x.getProduct().getQuantity(); int
                                                                bqty=x.getQty(); String
                                                                s_name=x.getProduct().getSeller().getName(); String
                                                                s_mail=x.getProduct().getSeller().getEmail(); int
                                                                s_id=x.getProduct().getSeller().getId(); Double
                                                                cost=p_price*bqty; total+=cost; String
                                                                path=x.getProduct().getImgp(); %>
                                                                <div class="cart-item">
                                                                    <img src="<%=path%>" alt="Order <%=oid%>" />

                                                                    <div class="cart-name-price">
                                                                        <h2>
                                                                            <%=p_name%>
                                                                        </h2>
                                                                        <p class="price">Order Id<%=oid%>
                                                                        </p>
                                                                        <p class="price">₹<%=cost%>
                                                                        </p>
                                                                    </div>

                                                                    <div class="cart-description">
                                                                        <p>
                                                                            <%=p_pd%>
                                                                        </p>
                                                                        <p class="seller-info">Seller: <%=s_name%>
                                                                        </p>
                                                                        <p class="seller-info">Seller Id: <%=s_id%>
                                                                        </p>
                                                                        <p class="seller-info">Seller mail: <%=s_mail%>
                                                                        </p>
                                                                    </div>
                                                                    <div class="cart-description">
                                                                        <p class="seller-info">Customer:
                                                                            <%=x.getCustomer().getName()%>
                                                                        </p>
                                                                        <p class="seller-info">Customer Id:
                                                                            <%=x.getCustomer().getId()%>
                                                                        </p>
                                                                        <p class="seller-info">Customer mail:
                                                                            <%=x.getCustomer().getEmail()%>
                                                                        </p>
                                                                    </div>
                                                                    <div class="cart-description">
                                                                        <p class="stock-info">Available: <%=avlqty%>
                                                                        </p>
                                                                        <p class="stock-info">Price: ₹<%=p_price%>
                                                                        </p>
                                                                        <p class="stock-info">Buying Quantity: ₹
                                                                            <%=bqty%>
                                                                        </p>
                                                                    </div>

                                                                    <% if(avlqty==0){ String
                                                                        prodmsg="Cannot buy this item" ; %>
                                                                        <div class="cart-description">
                                                                            <p class="stock-info">
                                                                                <%=prodmsg%>
                                                                            </p>
                                                                        </div>

                                                                        <% } else if(bqty>avlqty){
                                                                            String prodmsg="Can't buy this quantity";
                                                                            %>
                                                                            <div class="cart-description">
                                                                                <p class="stock-info">
                                                                                    <%=prodmsg%>
                                                                                </p>
                                                                            </div>

                                                                            <% } else{ %>
                                                                                <div class="cart-description">
                                                                                    <p class="stock-info"> </p>
                                                                                </div>
                                                                                <% } %>

                                                                </div>
                                                                <%} } %>
                                                    </section>
                                                </div>
                                            </div>
                                            <script>
                                                setInterval(function () {
                                                    location.reload();
                                                }, 5000);
                                            </script>
                                        </body>

                                </html>