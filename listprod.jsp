<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>BKM Databases </title>
</head>
<body>
<%@ include file="header.jsp" %>
<h1>Search for the products you want to buy:</h1>

<% 
// Get product name to search for
String name = request.getParameter("productName");
String cat = request.getParameter("categoryName");
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection
String url = "jdbc:sqlserver://sql04.ok.ubc.ca;DatabaseName=db_kshepher;";
String uid = "kshepher";
String pw = "24900169";

try (Connection con = DriverManager.getConnection(url, uid, pw);)
{
	PreparedStatement pstmtCats = con.prepareStatement("SELECT DISTINCT categoryName FROM category;");
	ResultSet rstCats = pstmtCats.executeQuery();
	String options = "<option>All</option>";
	while(rstCats.next()) {
		options += "<option>" + rstCats.getString(1) + "</option>";
	}
	
	out.println("<form method=\"get\" action=\"listprod.jsp\"><select size=\"1\" name=\"categoryName\">" +
		options + "</select><input type=\"text\" name=\"productName\" size=\"50\">" +
		"<input type=\"submit\" value=\"Submit\"><input type=\"reset\" value=\"Reset\"> (Leave blank for all products)	</form>");
	
// Print out the ResultSet // was: PreparedStatement pstmt = con.prepareStatement("SELECT productId, productName, productPrice FROM product WHERE productName LIKE \'%" + name + "%\'");
PreparedStatement pstmt;
/*
SELECT product.prodctId, productName, COUNT(*)
FROM product JOIN (SELECT ProductId, COUNT(*) as num 
					FROM orderedProduct 
					GROUP BY ProductId) as Table1
ORDER BY Table1.num

*/


if (name == null && (cat == null || cat.equals("All"))) {
	//pstmt = con.prepareStatement("SELECT productId, productName, productPrice, product.categoryId  FROM product JOIN category ON product.categoryId = category.categoryId;");
	pstmt = con.prepareStatement("SELECT product.productId, productName, productPrice, product.categoryId, productImageURL  FROM (product JOIN category ON product.categoryId = category.categoryId) LEFT JOIN (SELECT ProductId, COUNT(*) as num FROM orderproduct GROUP BY ProductId) as Table1 ON Table1.productId = product.productId ORDER BY num DESC");
} else if (cat == null || cat.equals("All")) {
	pstmt = con.prepareStatement("SELECT product.productId, productName, productPrice, product.categoryId, productImageURL  FROM (product JOIN category ON product.categoryId = category.categoryId) LEFT JOIN (SELECT ProductId, COUNT(*) as num FROM orderproduct GROUP BY ProductId) as Table1 ON Table1.productId = product.productId WHERE productName LIKE \'%" + name + "%\' ORDER BY num DESC;");
} else if (name == null) {
	pstmt = con.prepareStatement("SELECT product.productId, productName, productPrice, product.categoryId, productImageURL  FROM (product JOIN category ON product.categoryId = category.categoryId) LEFT JOIN (SELECT ProductId, COUNT(*) as num FROM orderproduct GROUP BY ProductId) as Table1 ON Table1.productId = product.productId WHERE categoryName LIKE \'%" + cat + "%\' ORDER BY num DESC;");
} else {
	pstmt = con.prepareStatement("SELECT product.productId, productName, productPrice, product.categoryId, productImageURL FROM (product JOIN category ON product.categoryId = category.categoryId) LEFT JOIN (SELECT ProductId, COUNT(*) as num FROM orderproduct GROUP BY ProductId) as Table1 ON Table1.productId = product.productId WHERE productName LIKE \'%" + name + "%\' and categoryName LIKE \'%" + cat + "%\' ORDER BY num DESC;");
}
/*
if (name != null && cat != null && cat != "All"){
	pstmt = con.prepareStatement("SELECT productId, productName, productPrice, product.categoryId FROM product JOIN category ON product.categoryId = category.categoryId WHERE productName LIKE \'%" + name + "%\' and categoryName LIKE \'%" + cat + "%\';");
}else if (cat != null && cat != "All"){
	pstmt = con.prepareStatement("SELECT productId, productName, productPrice, product.categoryId  FROM product JOIN category ON product.categoryId = category.categoryId WHERE categoryName LIKE \'%" + cat + "%\';");
}else if (name != null){
	pstmt = con.prepareStatement("SELECT productId, productName, productPrice, product.categoryId  FROM product JOIN category ON product.categoryId = category.categoryId WHERE productName LIKE \'%" + name + "%\';");
}else{
	pstmt = con.prepareStatement("SELECT productId, productName, productPrice, product.categoryId  FROM product JOIN category ON product.categoryId = category.categoryId;");
}
*/
PreparedStatement pstmtCat = con.prepareStatement("SELECT categoryName FROM category WHERE categoryId = ?");
//pstmt.setString(1, name);
out.println("<p></p>");
out.println("<table class=\"table\">");
ResultSet rstProj = pstmt.executeQuery();
out.println("<tr>");
out.println("<td>Add to cart</td><td>Image</td><td>Id</td><td>Name</td><td>Price</td><td>Category</td>");
out.println("</tr>");


while (rstProj.next()) {
	out.println("<tr>");
	String productId = rstProj.getString(1);
	String productName = rstProj.getString(2);
	String price = rstProj.getString(3);
	String categoryId = rstProj.getString(4);
	String disImg = rstProj.getString(5);
	pstmtCat.setString(1, categoryId);
	ResultSet rstCat = pstmtCat.executeQuery();
	rstCat.next();
	String category = rstCat.getString(1);
	out.println("<td>" + "<a href=\"addcart.jsp?id=" + productId + "&name=" + productName + "&price=" + price + "\" style=\"display:block;\">Add To Cart</a> " 
							+"</td><td><img src=\""+ disImg +"\" width = \"100\"></td><td>"	+ productId + "</td>");
	out.println("<td><a href=\"product.jsp?id=" + productId+ "\" style=\"display:block;\">" + productName + "</a></td><td> $" + price + " </td><td>" + category + "</td>");
	out.println("</tr>");
}
out.println("</table>");
rstProj.close();

// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
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