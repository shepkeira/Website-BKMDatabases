<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Shipment/ Payment page</title>
</head>
<body>
<%@ include file="header.jsp" %>
<!--  Showing the total of the order and then showing the options -->
<h1 class="center">BMK ONLINE CHECKOUT</h1>
<!--  The beginning portion where it displays for user to select payment methods -->
<form>
<div>
<table> 
	<tr><th>Payment Methods</th>
		<tr><td><input type="radio" name="credit" value="Credit" >Credit Card</td></tr>
		<tr><td><input type="radio" name="debit" value="debit" >Debit Card</td></tr>
		<tr><td><input type="radio" name="paypal" value="paypal" >Paypal</td></tr>
		<tr><td><input type="radio" name="bitcoin" value="bitcoin" >Bitcoin</td></tr>
</table>
<br>
</div>
<!--  Shipment select with the radio button so only one option is chosen -->
<div>
<table> 
	<tr><th>Black Friday Discount! All shipping is now on us. Select your preferred carrier.</th></tr>
	<tr><th>Shipping Method</th><th>Estimated Delivery</th><th>Price</th></tr>
		<tr><td><input type="radio" name="ship" value="Canada Post" >Canada Post</td> <td>8-16 Business Day(s)</td><td>$00.00</td></tr>
		<tr><td><input type="radio" name="ship" value="UPS" >UPS Ground </td> <td>4-8 Business Day(s)</td><td>$00.00</td></tr>
		<tr><td><input type="radio" name="ship" value="Fed Ex" >FedEx</td> <td>0-1 Business Day(s)</td><td>$00.00</td></tr>
		<tr><td><input type="radio" name="ship" value="In Store Pick Up" >Pick Up in Store</td> <td>1-2 Business Day(s)</td><td>Free</td></tr>
</table>
</div>
</form>
</body>


<% 
	out.println("<h2 class=\"alighRight\"> Subtotal: $" + session.getAttribute("subTotal") + " </h2>");
	//Missing if conditions to determine what values to add when diff options are selected
	
	out.println("<h2><a href=\"showcart.jsp\">Go back to cart</a></h2>");

	out.println("<h2><a href=\"checkout.jsp\">Check Out</a></h2>");
	%>

<style>
h1 { 
	text-align: center 
}
.alignRight {
	text.align: right
	 }
body {	font-family: arial, sans-serif;
		background-image: url("https://images.pexels.com/photos/1363876/pexels-photo-1363876.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940");
		background-color: #cccccc;color: #ffffff
	}
a 	{	font-family: arial, sans-serif;color: #ffffff
	}
table {	font-family: arial, sans-serif;
		border-collapse: collapse;
		width: 100%;
	}
thead {background-color: #5D001E;}
tr:nth-child(even) {background-color: #151143;}
tr:nth-child(odd) {background-color: #9A1750;}
td, th {border: 1px solid #000000;
		text-align: left;
		padding: 8px;
		}
tr:hover{
			background-color: #E3E2DF;
			color: #5D001E;"
		}
table.inside tr:nth-child(even) {background-color: #9A1750;}
table.inside tr:nth-child(odd) {background-color: #5D001E;}
table.inside tr:hover {background-color: #E3E2DF;
			  			color: #5D001E;
						}
</style>

</html> 
