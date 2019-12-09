<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body>

<%@ include file="header.jsp" %>

	<%@ include file="auth.jsp"%>
	<%@ page import="java.text.NumberFormat"%>
	<%@ include file="jdbc.jsp"%>

	<%
		String userName = (String) session.getAttribute("authenticatedUser");
	%>

	<%
		// TODO: Print Customer information

		String url = "jdbc:sqlserver://sql04.ok.ubc.ca;DatabaseName=db_kshepher;";
		String uid = "kshepher";
		String pw = "24900169";

		try (Connection con = DriverManager.getConnection(url, uid, pw);) { // do I need to do connection as a try with resources?

			String SQL = "SELECT * " + " FROM customer" + " Where userid = ?";

			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setString(1, userName);

			ResultSet rst = pstmt.executeQuery();
				
			out.println("<h1>BKM Customer Page</h1>");
			out.println("<h3>Your Info</h3>");
				
			if(rst.next()) {
				int id = rst.getInt("customerId");
				String firstName = rst.getString("firstName");
				String lastName = rst.getString("lastName");
				String email = rst.getString("email");
				String phonenum = rst.getString("phonenum");
				String address = rst.getString("address");
				String city = rst.getString("city");
				String state = rst.getString("state");
				String postalCode = rst.getString("postalCode");
				String country = rst.getString("country");
				String userId = userName;
				out.print("<table>");
				out.print("<tr>");
					out.print("<td>Id</td>");
					out.print("<td>" + id + "</td>");
				out.print("</tr>");
				out.print("<tr>");
					out.print("<td>First Name</td>");
					out.print("<td>" + firstName + "</td>");
				out.print("</tr>");
				out.print("<tr>");
					out.print("<td>Last Name</td>");
					out.print("<td>" + lastName + "</td>");
				out.print("</tr>");
				out.print("<tr>");
					out.print("<td>Email</td>");
					out.print("<td>" + email + "</td>");
				out.print("</tr>");
				out.print("<tr>");
					out.print("<td>Phone</td>");
					out.print("<td>" + phonenum + "</td>");
				out.print("</tr>");
				out.print("<tr>");
					out.print("<td>Address</td>");
					out.print("<td>" + address + "</td>");
				out.print("</tr>");
				out.print("<tr>");
					out.print("<td>City</td>");
					out.print("<td>" + city + "</td>");
				out.print("</tr>");
				out.print("<tr>");
					out.print("<td>State</td>");
					out.print("<td>" + state + "</td>");
				out.print("</tr>");
				out.print("<tr>");
					out.print("<td>Postal Code</td>");
					out.print("<td>" + postalCode + "</td>");
				out.print("</tr>");
				out.print("<tr>");
					out.print("<td>Country</td>");
					out.print("<td>" + country + "</td>");
				out.print("</tr>");
				out.print("<tr>");
					out.print("<td>User Id</td>");
					out.print("<td>" + userId + "</td>");
				out.print("</tr>");
				out.print("</table>");
				
				//<a href="createaccount.jsp">
				
				String url1 = "customerEdit.jsp?id=" + userName;
				out.print("<button onclick=\"window.location.href = \'" + url1 + "\';\">Edit Account Information</button>");
				//<button onclick=\"window.location.href = 'https://w3docs.com';">Click Here</button>
			}else {
				out.print("You are not logged in");
			}
			
			
			rst.close();
		} catch (Exception e) {
			out.print(e);
		}

		// Make sure to close connection
	%>

</body>

<style>
body {
	font-family: arial, sans-serif;
	background-image:
		url("https://images.pexels.com/photos/1363876/pexels-photo-1363876.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940");
	background-color: #cccccc;
	color: #ffffff
}

a {
	font-family: arial, sans-serif;
	color: #ffffff
}

table {
	font-family: arial, sans-serif;
	border-collapse: collapse;
	width: 100%;
}

thead {
	background-color: #5D001E;
}

tr:nth-child(even) {
	background-color: #151143;
}

tr:nth-child(odd) {
	background-color: #9A1750;
}

td, th {
	border: 1px solid #000000;
	text-align: left;
	padding: 8px;
}

tr:hover {
	background-color: #E3E2DF;
	color: #5D001E;
	"
}

table.inside tr:nth-child(even) {
	background-color: #9A1750;
}

table.inside tr:nth-child(odd) {
	background-color: #5D001E;
}

table.inside tr:hover {
	background-color: #E3E2DF;
	color: #5D001E;
}
</style>

</html>