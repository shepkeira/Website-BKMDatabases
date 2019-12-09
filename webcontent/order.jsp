<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>BKM Grocery Order Processing</title>
</head>
<body>
<%@ include file="header.jsp" %>
<% 
// Get customer id
String custId = request.getParameter("customerId");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

Boolean is_invalid = false;
try
    {
      // the String to int conversion happens here
      // Determine if valid customer id was entered
      int i = Integer.parseInt(custId);
   // Determine if there are products in the shopping cart
      Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	  if (!iterator.hasNext()){
		  throw new NumberFormatException();
	  }
    }
catch (NumberFormatException nfe)
    {
		// If either are not true, display an error message
		is_invalid = true;
    }


if (is_invalid){
	out.println("<h1>There was an error try again</h1>");
	//error page
} else {

// Make connection

String url = "jdbc:sqlserver://sql04.ok.ubc.ca;DatabaseName=db_kshepher;";
String uid = "kshepher";
String pw = "24900169";

// Save order information to database
//old stuff start
try (Connection con = DriverManager.getConnection(url, uid, pw);)
{

	
	// Save order information to database
	String stmtSQL = "INSERT INTO ordersummary (customerId, orderDate) VALUES (?, ?);";			
	PreparedStatement pstmt = con.prepareStatement(stmtSQL, Statement.RETURN_GENERATED_KEYS);
	pstmt.setString(1, custId);
	pstmt.setTimestamp(2, new java.sql.Timestamp(System.currentTimeMillis())); // shows time
	
	pstmt.executeUpdate();
	
	ResultSet keys = pstmt.getGeneratedKeys();
	keys.next();
	int orderId = keys.getInt(1);

	/*
	// Use retrieval of auto-generated keys.
	//PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);			
	ResultSet keys = pstmt.getGeneratedKeys();
	keys.next();
	int orderId = keys.getInt(1);
	*/

	// Insert each item into OrderProduct table using OrderId from previous INSERT

	// Update total amount for order record

	int amountTotal = 0;
		
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator3 = productList.entrySet().iterator();
	while (iterator3.hasNext())
	{ 
		Map.Entry<String, ArrayList<Object>> entry = iterator3.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String productId = (String) product.get(0);
        String price = (String) product.get(2);
		double pr = Double.parseDouble(price);
		//int qty = ( (Integer)product.get(3)).intValue();
		int qty = (Integer)product.get(3);
		amountTotal += pr * qty;
	}
		
	String stmtTotal = "UPDATE ordersummary SET totalAmount = ? WHERE orderId = ? ";
	PreparedStatement pstmtTotal = con.prepareStatement(stmtTotal);	
	pstmtTotal.setDouble(1, amountTotal);
	pstmtTotal.setInt(2, orderId);
	session.setAttribute("subTotal", amountTotal);
	pstmtTotal.executeUpdate();


	// Here is the code to traverse through a HashMap
	// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price

	PreparedStatement pstmt1 = con.prepareStatement("INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (" + orderId +", ?, ?, ?);");

	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext())
	{ 
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String productId = (String) product.get(0);
        String price = (String) product.get(2);
		double pr = Double.parseDouble(price);
		int qty = ( (Integer)product.get(3)).intValue();
		pstmt1.setString(1, productId);
		pstmt1.setString(2, Integer.toString(qty));
		pstmt1.setString(3, price);
		pstmt1.executeUpdate();
	}


	
	
// Print out order summary
		Statement stmtSum = con.createStatement();
		ResultSet rstSum = stmtSum.executeQuery("SELECT orderId, orderDate, customerId, totalAmount FROM ordersummary WHERE orderId = " + orderId + ";");
		
		out.println("<h1>Your BKM Order Summary</h1>");
		out.println("<p></p>");
		
		while (rstSum.next())
		{	
			String orderId2 = rstSum.getString(1);
			String orderDate = rstSum.getString(2);
			String customerId = rstSum.getString(3);
			String totalAmount = rstSum.getString(4);
			out.println("<table>");
			out.println("<tr>");
			out.println("<td>Order Id</td><td>Order Date</td><td>Customer Id</td><td>Total Amount</td></tr>");
			out.println("<tr><td>" + orderId2 + "</td>");
			out.println("<td>" + orderDate + "</td>");
			out.println("<td>" + rstSum.getString(3) + "</td>");
			out.println("<td>" + totalAmount + "</td>");
			out.println("</tr>");
			out.println("</table>");
			
		}
		
		
		out.println("<a href=\"index.jsp\">Return to shopping</a>");

// Clear cart if order placed successfully
    //String stmtClear = "DELETE FROM incart;";// WHERE orderId = ?;";
	//PreparedStatement pstmtClear = con.prepareStatement(stmtClear);
	//pstmtClear.setInt(1, orderId);
	//pstmtClear.executeUpdate();
	productList.clear();
	
}
catch (SQLException ex) 
{ 	
	//Close connection
	out.println(ex); 
}
//old stuff end

	/*
	// Use retrieval of auto-generated keys.
	PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);			
	ResultSet keys = pstmt.getGeneratedKeys();
	keys.next();
	int orderId = keys.getInt(1);
	*/

// Insert each item into OrderProduct table using OrderId from previous INSERT

// Update total amount for order record

// Here is the code to traverse through a HashMap
// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price

/*
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext())
	{ 
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String productId = (String) product.get(0);
        String price = (String) product.get(2);
		double pr = Double.parseDouble(price);pro
		int qty = ( (Integer)product.get(3)).intValue();
            ...
	}
*/

// Print out order summary

// Clear cart if order placed successfully
}
%>
</BODY>

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

</HTML>

