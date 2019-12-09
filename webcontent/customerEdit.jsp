<!DOCTYPE html>
<html>
<head>
<title>Create BKM Account</title>
</head>
<body>

<%@ include file="header.jsp" %>
<%@ include file="jdbc.jsp" %>

<%

try 
{
	getConnection();
	String id = request.getParameter("id");
	String SQL = "SELECT * " + " FROM customer" + " Where userid LIKE \'" + id + "\';";
	ResultSet rst = executeQuery(SQL);
	
	while(rst.next()) {
		String firstName = rst.getString("firstName");
		String lastName = rst.getString("lastName");
		String email = rst.getString("email");
		String phonenum = rst.getString("phonenum");
		String address = rst.getString("address");
		String city = rst.getString("city");
		String state = rst.getString("state");
		String postalCode = rst.getString("postalCode");
		String country = rst.getString("country");
		String userId = rst.getString("userid");
		String pass = rst.getString("password");
		String userNum = rst.getString("customerId");	
	
		out.println("<form name=\"MyForm\" method=\"post\" action=\"updateAccount.jsp\">");
		out.println("<input type = \"hidden\" name = \"id\" value = \"" + rst.getString("customerId") + "\" />");
		out.println("<table style=\"display:inline\">");
		out.println("<tr><td>First Name</td><td><input type=\"text\" name=\"First\" value=\"" + firstName + "\" size=10 maxlength=40></td></tr>");
		out.println("<tr><td>Last Name</td><td><input type=\"text\" name=\"Last\" value=\"" + lastName + "\" size=10 maxlength=40></td></tr>");
		out.println("<tr><td>Email</td><td><input type=\"text\" name=\"Email\" value=\"" + email + "\" size=10 maxlength=50></td></tr>");
		out.println("<tr><td>Phone Number</td><td><input type=\"text\" name=\"phone\" value=\"" + phonenum + "\" size=10 maxlength=20></td></tr>");
		out.println("<tr><td>Address</td><td><input type=\"text\" name=\"add\" value=\"" + address + "\" size=10 maxlength=50></td></tr>");
		out.println("<tr><td>City</td><td><input type=\"text\" name=\"City\" value=\"" + city + "\" size=10 maxlength=40></td></tr>");
		out.println("<tr><td>State or Province</td><td><input type=\"text\" name=\"state\" value=\"" + state + "\" size=10 maxlength=20></td></tr>");
		out.println("<tr><td>Postal Code</td><td><input type=\"text\" name=\"postal\" value=\"" + postalCode + "\" size=10 maxlength=20></td></tr>");
		out.println("<tr><td>Country</td><td><input type=\"text\" name=\"country\" value=\"" + country + "\" size=10 maxlength=40></td></tr>");
		out.println("<tr><td>User Name</td><td><input type=\"text\" name=\"user\" value=\"" + userId + "\" size=10 maxlength=20></td></tr>");
		out.println("<tr><td>Password</td><td><input type=\"text\" name=\"pass\" value=\"" + pass + "\" size=10 maxlength=30></td></tr>");
		out.println("</table>");
		out.println("<input class=\"submit\" type=\"submit\" name=\"Submit\" value=\"Update\"></form>");
		
	}
	
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