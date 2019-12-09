<!DOCTYPE html>
<html>
<head>
        <title>BKM Grocery Main Page</title>
</head>
<body>
<h1 align="center">Welcome to BKM Databases</h1>

<h2 align="center"><a href="login.jsp">Login</a></h2>

<h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>

<h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

<h2 align="center"><a href="customer.jsp">Customer Info</a></h2>

<h2 align="center"><a href="admin.jsp">Administrators</a></h2>

<h2 align="center"><a href="logout.jsp">Log out</a></h2>

<%
// TODO: Display user name that is logged in (or nothing if not logged in)	
if(session.getAttribute("authenticatedUser") != null) { 
	out.println("<h3 align=\"center\">Logged in as: " + session.getAttribute("authenticatedUser") + "</a></h3>"); 
} else { 
	out.println("<h3 align=\"center\">Browsing as guest</a></h3>"); 
	
}

%>
</body>
</head>

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
