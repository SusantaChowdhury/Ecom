<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Admin Login</title>
    </head>
    <body style="background-image: url(images/shop.jpg)">
        <h1 style="text-align: center; margin-top: 0; margin-bottom: 0; color: yellow; background: black">
            Welcome to SwiftMart
        </h1>
        <table style="margin-left: auto; margin-top: 0; margin-bottom: 0">
        	<tr>
            <th style="align-content: center; background-color: black; border: 1px solid black; border-radius: 20px">
                <a href="/" style="color: white; text-decoration: none;">
                    <b>Home</b>                    
                </a>
            </th>
            <th style="align-content: center; background-color: black; border: 1px solid black; border-radius: 20px">
                <a href="aboutus" style="color: white; text-decoration: none;">
                <b>About Us</b>
                </a>
            </th>
            <th style="align-content: center; background-color: black; border: 1px solid black; border-radius: 20px">
                <a href="contactus" style="color: white; text-decoration: none;">
                <b>Contact Us</b>
                </a>
            </th>
            <th style="align-content: center; background-color: black; border: 1px solid black; border-radius: 20px">
                <a href="Adminpage" style="color: yellow; text-decoration: none;">
                <b>Admin</b>
                </a>
            </th>
            </tr>
        </table>
        <div style="display: flex; justify-content: center; align-items: center; font-size: 32px; 
             padding: 20px 40px; border-radius: 20px; background-color: white; flex-direction: column; 
                 margin-left: auto; margin-right: auto; margin-top: 40px; margin-bottom: auto; width: 800px">
            <h2>Admin Login</h2>
            <form action="LoginAdmin" method="post">
            <input type="text" name="admin_name" placeholder="Username" required 
                   style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ccc; border-radius: 5px;">
            <input type="password" name="admin_password" placeholder="Password" required 
                   style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ccc; border-radius: 5px;">
            <button type="submit" style="width: 100%; padding: 10px; background: #28a745; color: white; border: none; border-radius: 5px; cursor: pointer;">Login</button>
            <%
            String getm=String.valueOf(request.getAttribute("msg"));
            if(getm!=null){
                if(getm.equals("alfail")){
            %>
            <p style="font-family: Arial, sans-serif; color: red; font-size: 16px;"> 
                Wrong username or password
            </p>
            <%
                }
            }
            %>
        </form>         
        </div>
    </body>        
</html>
