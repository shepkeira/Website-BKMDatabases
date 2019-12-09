<%@ page import= "java.util.*"%>
<%@ page import= "java.text.*" %>
<%@ page import="java.io.*"%>
<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>



<%// TODO: Include files auth.jsp and jdbc.jsp
 %>
<%@ include file="jdbc.jsp"%>
<%@ include file="auth.jsp"%>
<%@ include file="header.jsp" %>

<%
// TODO: Write SQL query that prints out total order amount by day
	
	SimpleDateFormat sDF = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
	
	String url = "jdbc:sqlserver://sql04.ok.ubc.ca;DatabaseName=db_kshepher;";
	String uid = "kshepher";
	String pw = "24900169";
	
	try(Connection con = DriverManager.getConnection(url, uid, pw);) {
		
		PreparedStatement pstmt1 = con.prepareStatement("SELECT CAST(orderDate AS DATE) AS orderNOtime, SUM(totalAmount) as total FROM ordersummary GROUP BY CAST(orderDate AS DATE) ORDER BY CAST(orderDate AS DATE);");  //\'2019-10-16 18:00:00\'");
		
		out.println("<h1>BKM Administrator Page</h1>");
		out.println("<h3>Orders and Totals from Site</h3>");
		
		out.print("<table class=\"table\">");
		
		ResultSet rstThing = pstmt1.executeQuery();
		
		out.println("<tr><th>OrderDate</th><th>Total Amount</th></tr>");
		
		
		while(rstThing.next()) {
			out.print("<tr>");
			String orderDate = rstThing.getString(1);
			String totalAmount = rstThing.getString(2);
			//out.println("<td>" + orderDate + " price=$" + totalAmount + "\" style=\"display:block;\">" + "</td>");
			out.println("<td>" + orderDate + "</td>");
			out.println("<td>$" + totalAmount + "</td>");
			out.println("</tr>");
		}
	out.print("</table>");

	} catch(SQLException ex) { 
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