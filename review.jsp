<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import = "java.io.*,java.util.*,javax.mail.*"%>
<%@ page import = "javax.mail.internet.*,javax.activation.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>BKM Databases Review Page</title>
</head>
<body>

<%

String review = request.getParameter("reviewComment");

String id = request.getParameter("prodid");

String userid = request.getParameter("userid");

String prodrating = request.getParameter("prodrating");

String url = "jdbc:sqlserver://sql04.ok.ubc.ca;DatabaseName=db_kshepher;";
String uid = "kshepher";
String pw = "24900169";

// Testing for variable passing. Completed.
/* out.println("The review is: " + review);
out.println("\n The authenticatedUser is: "  + session.getAttribute("authenticatedUser"));
out.println("\nThe product Id is: "  + id);
out.println("\nThe user ID is: " + userid); */

if (session.getAttribute("authenticatedUser") == null) {
	out.println("<h2 class = \"center\"> Please sign in before submitting a review </h2>");
	out.println("<br>");
	out.println("<a href = \"login.jsp\" class = \"a\"> Sign in here </a>");
} else {

try (Connection con = DriverManager.getConnection(url, uid, pw);){
	// This is product ID
	
	// Get authenticated user and their ID
	//String userId = session.getAttribute("authenticatedUser");
	
	PreparedStatement pstmtUser = con.prepareStatement("Select customerId FROM customer WHERE userId = ?");
	pstmtUser.setString(1, (String) session.getAttribute("authenticatedUser"));
	ResultSet rkt = pstmtUser.executeQuery();
	String userId = "";
	while(rkt.next()){ 
		userId = rkt.getString(1); 
	}	
	
	// Used for testing of output correctness out.print("<h3>" + prodrating + id + review + userId + "</h3>" );

	
	PreparedStatement pstmt = 
	con.prepareStatement("INSERT INTO review(reviewRating, reviewDate, customerId, productId, reviewComment) Values (?, ?, ?, ?, ?)"); 

	pstmt.setString(1, prodrating); // First set the rating, didn't set anything for autoincrementing values
	pstmt.setTimestamp(2, new java.sql.Timestamp(System.currentTimeMillis())); // shows time
	pstmt.setString(3, userId);
	pstmt.setString(4, id); 
	pstmt.setString(5, review); 
	
	pstmt.executeUpdate();
	
	out.print("<h3> Thank you " + session.getAttribute("authenticatedUser") + " for your review. </h3>");
	out.print("<br>");
	out.print("<a href = \"product.jsp?id= " + id + "\"> Back to product page. </a>");		
			
} catch (SQLException ex) {
	out.println(ex);
}
finally
{
	closeConnection();
}
}
%>

</body>

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
</style>
</html>