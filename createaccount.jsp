<!DOCTYPE html>
<html>
<head>
<title>Create BKM Account</title>
</head>
<body>

<div style="margin:0 auto;text-align:center;display:inline">
<%@ include file="header.jsp" %>
<h3>Please Login to System</h3>

<%
// Print prior error login message if present
if (session.getAttribute("loginMessage") != null)
	out.println("<p>"+session.getAttribute("loginMessage").toString()+"</p>");
/*

	out.println("<form method=\"get\" action=\"listprod.jsp\"><select size=\"1\" name=\"categoryName\">" +
		options + "</select><input type=\"text\" name=\"productName\" size=\"50\">" +
		"<input type=\"submit\" value=\"Submit\"><input type=\"reset\" value=\"Reset\"> (Leave blank for all products)	</form>");
*/
%>

<br>
<form name="MyForm" method=post action="validateAccount.jsp">
<table style="display:inline">
<tr>
	<td>First Name</td>
	<td><input type="text" name="First"  size=10 maxlength=40></td>
</tr>
<tr>
	<td>Last Name</td>
	<td><input type="text" name="Last"  size=10 maxlength=40></td>
</tr>
<tr>
	<td>Email</td>
	<td><input type="text" name="Email" size=10 maxlength=50></td>
</tr>
<tr>
	<td>Phone Number</td>
	<td><input type="text" name="phone"  size=10 maxlength=20></td>
</tr>
<tr>
	<td>Address</td>
	<td><input type="text" name="add"  size=10 maxlength=50></td>
</tr>
<tr>
	<td>City</td>
	<td><input type="text" name="city"  size=10 maxlength=40></td>
</tr>
<tr>
	<td>State or Province</td>
	<td><input type="text" name="state"  size=10 maxlength=20></td>
</tr>
<tr>
	<td>Postal Code</td>
	<td><input type="text" name="postal"  size=10 maxlength=20></td>
</tr>
<tr>
	<td>Country</td>
	<td><input type="text" name="country"  size=10 maxlength=40></td>
</tr>
<tr>
	<td>User Name</td>
	<td><input type="text" name="user"  size=10 maxlength=20></td>
</tr>
<tr>
	<td>Password</td>
	<td><input type="text" name="pass"  size=10 maxlength=30></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit" value="Create">
</form>

</div>

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