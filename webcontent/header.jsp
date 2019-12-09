<H1 align="center"><a href="index.jsp">BKM Databases</a></H1>   
<H3 align="center"><a href="listorder.jsp">List All Orders</a> 
<a href="listprod.jsp">List Products</a>
<a href="showcart.jsp">Show Cart</a></H3> 
<%
if(session.getAttribute("authenticatedUser") != null) { 
	out.println("<h3 align=\"center\">Logged in as: " + session.getAttribute("authenticatedUser") + "</a></h3>"); 
	out.println("<h4 align=\"center\"><a href=\"logout.jsp\">Log out</a></h4>");

} else { 
	out.println("<h3 align=\"center\">Browsing as guest</a></h3>"); 
	out.println("<h4 align=\"center\"><a href=\"login.jsp\">Login</a></h4>");
	
}
%>
<hr>

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