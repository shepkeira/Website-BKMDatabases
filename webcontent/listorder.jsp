<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>BKM Databases Order List</title>
</head>
<body>

<%@ include file="header.jsp" %>
<h1>Order List</h1>



<% 
try 
{	// Load driver class
	Class.forName("com.mysql.jdbc.Driver");
}
catch (java.lang.ClassNotFoundException e) 
{
	System.err.println("ClassNotFoundException: " +e);	
}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection

String url = "jdbc:sqlserver://sql04.ok.ubc.ca;DatabaseName=db_kshepher;";
String uid = "kshepher";
String pw = "24900169";

try (Connection con = DriverManager.getConnection(url, uid, pw);)
{
	// Write query to retrieve all order summary records

	PreparedStatement pstmtP = con.prepareStatement("SELECT productId, quantity, price FROM orderproduct WHERE orderId = ?");	

	Statement stmt = con.createStatement();
	ResultSet rst = stmt.executeQuery("SELECT orderId, orderDate, customerId, totalAmount FROM ordersummary");
	
	PreparedStatement pstmtName = con.prepareStatement("SELECT firstName, lastName FROM customer WHERE customerId = ?");
	
	// For each order in the ResultSet

	// Print out the order summary information
	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times
	// For each product in the order
		// Write out product information
	// Iterate through department list
	//uncomment
	out.println("<table>");
	out.println("<thead bgcolor= \"#5D001E\"><tr>");
	out.println("<th bgcolor= \"#5D001E\">Order Id</th> " + 
			"<th bgcolor= \"#5D001E\">Order Date</th>  "+ 
				"<th bgcolor= \"#5D001E\">Customer Id</th> "+ 
			"<th bgcolor= \"#5D001E\">Customer Name</th> " + 
				" <th bgcolor= \"#5D001E\">Total Amount</th>");
		out.println("</tr></thead>");
	while (rst.next())
	{	
		out.println("<tbody>");
		String orderId = rst.getString(1);
		String orderDate = rst.getString(2);
		String customerId = rst.getString(3);
		String totalAmount = rst.getString(4);
		pstmtName.setString(1, customerId);
		ResultSet rstName = pstmtName.executeQuery();
		rstName.next();
		String cname = rstName.getString(1) + " " + rstName.getString(2);
		
		
		out.println("<tr>");
		out.println("<td>" + orderId + "</td>" + " " + "<td>" + orderDate + "</td>" + " " 
							+ "<td>" + customerId + "</td>" +  " <td>"+ cname +"</td> " + "<td>$" + totalAmount +  "</td>" );
		out.println("</tr>");
		out.println("<tr><td colspan=\"5\">");
		
		pstmtP.setString(1, orderId);
		ResultSet rstProj = pstmtP.executeQuery();
		out.println("<table class=\"inside\">");
		out.println("<tr><td>	ProductId	</td>	<td>Quantity</td>	<td>Price</td></tr>");
		while(rstProj.next())
		{
			out.println("<tr>");
			String productId = rstProj.getString(1);
			String quantity = rstProj.getString(2);
			String price = rstProj.getString(3);
			out.println("<tr>");
			out.println("</tr>");
			out.println("<td> " + productId + " </td><td>" + quantity + " </td><td> $" + price + " </td>");
			out.println("</tr>");
		}
		out.println("</td></table>");
		rstProj.close();
		
	}	
	rst.close();
	out.println("</tbody></table>");
} 
catch (SQLException ex) 
{ 	
	//Close connection
	out.println(ex); 
}
%>
</body>

<style>

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