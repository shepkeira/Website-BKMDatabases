<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>BKM Databases - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<%
// Get product name to search for
// TODO: Retrieve and display info for the product
// String productId = request.getParameter("id");
	String productId = request.getParameter("id");

String sql = "SELECT productName, productPrice, productId, productImageURL, productImage, productDesc FROM product WHERE productId = " + productId;


try
{
	getConnection();
	ResultSet rslt = executeQuery(sql);
	
	// Set up warehouse inventory
	// Changed Query
	PreparedStatement pstmtStock = con.prepareStatement("Select P.warehouseId, W.warehouseName quantity FROM productinventory as P, warehouse as W WHERE productId = ? and (P.warehouseId = W.warehouseId)");
	pstmtStock.setString(1, productId);
	ResultSet stock = pstmtStock.executeQuery();
	
	
	while(rslt.next()) {
		// TODO: If there is a productImageURL, display using IMG tag
		out.println("<div class=\"row\">");
		out.println("<div class=\"column\">");
		if(rslt.getString(4) != null) {
			//"images/picture.jpg"
			out.println("<img src=\""+ rslt.getString(4) +"\" width=\"350\">");
		}
		// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
		if(rslt.getString(5) != null) {
		String disImg = "displayImage.jsp?id=" + rslt.getString(3);

		out.println("<img src=\""+ disImg +"\">");
		//response.sendRedirect(disImg);
		//String fwd = "<jsp:forward page=\"" + disImg + "\"/>";
		//out.println(fwd);
		}
		out.println("</div>");
		out.println("<div class=\"column\">");
		out.println("<h4>");
		out.println("Product Name: " + rslt.getString(1));
		out.println("<br>Product Id: " + productId);
		out.println("<br>Product Price: $" + rslt.getString(2));

		// TODO: Add links to Add to Cart and Continue Shopping
		String productName = rslt.getString(1);
		String price = rslt.getString(2);
		out.println("<br><br>");
		if(stock.next()) {
		out.println("<a href=\"addcart.jsp?id=" + productId + "&name=" + productName + "&price=" + price + "\" style=\"display:block;\">Add To Cart</a> ");
		out.println("<br>");
		} else { 
			out.println("<p> out of stock </p>");
		}
		out.println("<a href=\"listprod.jsp\">Continue Shopping</a>");
		out.println("</h4>");
		out.println("<br>");
	}
		
		
		out.println("<table>");
		out.println("<tr><th> In Stock at: </th></tr>");
		out.println("<tr><th> Warehouse ID </th><th> Location </th></tr>");
		out.println("<tr><td>"+ stock.getInt(1) + "</td><td>" + stock.getString(2) + "</td></tr>");
		if(stock.next()) {
			out.println("<tr><td>"+ stock.getInt(1) + "</td><td>" + stock.getString(2) + "</td></tr>");
			while(stock.next()) { 
				out.println("<tr><td>"+ stock.getInt(1) + "</td><td>" + stock.getString(2) + "</td></tr>");
				}
		} else {
			out.print("<tr><td> Out of stock. Resupplying... </tr></td>");
		}
		out.println("</table>");

	
		// Display review in the lower sections
				
		// Update to show all reviews of the product
		PreparedStatement pstmt = con.prepareStatement("Select * From review Where productId = ?");
		pstmt.setString(1, productId);
		ResultSet reviews = pstmt.executeQuery(); 

		out.println("<br><br>");
		out.println("<table>");

		out.println("<tr><th> Reviews </th></tr>");
		if(reviews.next() == true) {
			out.println("<tr><th> Date </th><th> Rating </th><th> Comment </th></tr>");
			while(reviews.next()) { 
				out.println("<tr><td>" + reviews.getDate(3) + "</td><td>"+ reviews.getInt(2) + "</td><td>"
				+ reviews.getString(6) + "</td></tr>");
				}
		} else { 
			out.print("<tr><th> There are no reviews </th></tr>");
		}
		
		out.println("</table>");


		out.println("<br><h3>Review section: </h3>");
		out.println("<form method=\"post\" action=\"review.jsp\">");
		out.println("Rating (between 1-10): " + "<br>" + "<input type=\"number\" name=\"prodrating\" min=\"1\" max=\"10\">");
		out.println("<br>");
		out.println("<br>");
		out.println("<textarea name=\"reviewComment\" style=\"background-color:white; color: black\">Your review</textarea>");
		out.println("<br>");
		out.println("<input type=\"hidden\" name=\"userid\" value=\"" + session.getAttribute("authenticatedUser") + "\">");
		out.println("<input type=\"hidden\" name=\"prodid\" value=\"" + productId + "\">");
		out.println("<input type =\"submit\" value=\"Submit Review\">");
		// <input type="hidden" id="custId" name="custId" value="3487">
		out.println("</form>");
		out.println("</div");
		
		
}
catch (SQLException ex) {
	out.println(ex);
}
finally
{
	closeConnection();
}

%>

</body>
</html>

<style>

input {
	font-family: arial, sans-serif;
	color: black
 }
 
textarea {
 width: 400px;
 height: 100px;
 background-color: black;
 font-size: 1em;
 font-family: arial, sans-serif;
 border: 0.5px solid black;
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
* {
  box-sizing: border-box;
}

/* Create two equal columns that floats next to each other */
.column {
  float: left;
  width: 50%;
  padding: 10px;
}

/* Clear floats after the columns */
.row:after {
  content: "";
  display: table;
  clear: both;
}
</style>
<%
/*
		if(stock.next() == false) {
			out.print("<p> Warehouse database offline. Stand by... </p>");
		} else { 
			out.println("<table>");
			out.println("<tr><th> Warehouse ID </th><th> Quantity </th></tr>");
			while(stock.next()) { 
				out.println("<tr><td>"+ stock.getInt(2) + "</td><td>" + stock.getInt(3) + "</td></tr>");
				}
			out.println("</table>");
		}
		*/
	
		// the insertion into database isn't running and is not returning anything from the queries
		/* PreparedStatement house = con.prepareStatement("Select * FROM warehouse");
		ResultSet whouse = house.executeQuery();
		if(whouse.next()) {
			out.println("<table>");
			out.println("<tr><th> Warehouse ID </th><th> Quantity </th></tr>");
			out.println("<tr><td>"+ whouse.getString(1) + "</td><td>" + whouse.getString(2) + "</td></tr>");
			while(whouse.next()) { 
				out.println("<tr><td>"+ whouse.getString(1) + "</td><td>" + whouse.getString(2) + "</td></tr>");
				}
			out.println("</table>");
		} else {
			out.print("<p> Warehouses none... </p>");
		} */
		/*
		if(whouse.next() == false) {
			out.print("<p> Warehouses none... </p>");
		} else {
			out.println("<table>");
			out.println("<tr><th> Warehouse ID </th><th> Quantity </th></tr>");
			while(whouse.next()) { 
				out.println("<tr><td>"+ whouse.getString(1) + "</td><td>" + whouse.getString(2) + "</td></tr>");
				}
			out.println("</table>");
			
		} 
		*/
		%>