<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.example.ecom.model.Admin"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>LogOut</title>
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
            <th style="justify-content: center;text-align: justify;padding: 5px; background-color: #c0c0c0; 
                border-top-left-radius: 20px; border-top-right-radius: 20px; border: 1px solid black">
                <a href="orderslist" style="color: black; text-decoration: none;">
                <b>Orders</b>
                </a>
            </th>
            <th style="justify-content: center;text-align: justify;padding: 5px; background-color: black; 
                border-top-left-radius: 20px; border-top-right-radius: 20px; border: 1px solid black">
                <a href="logoutadmin" style="color: yellow; text-decoration: none;">
                <b>Logout</b>
                </a>
            </th>
            </tr>
            </table>
            <div style="margin-bottom: auto; justify-content: center; padding: 5px;
                 background-color: black; color: yellow; width: 1204px ">
                <form action="Logout" method="post" 
                      style="font-size: 15px;">   
                    <div style="align-items: center; margin-left: 250px">                       
                        <button type="submit" style="width: 200px; padding: 10px; background: yellow; color: black;
                                border: none; border-radius: 5px;"><b>Logout</b></button><br>                                           
                    </div>
                    </form>
            </div>
        </div>
    </body>
</html>
