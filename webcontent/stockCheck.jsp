<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>

<% 
String url = "jdbc:sqlserver://sql04.ok.ubc.ca;DatabaseName=db_kshepher;";
String uid = "kshepher";
String pw = "24900169";

try (Connection con = DriverManager.getConnection(url, uid, pw);)
{
	// Get item number and its stock 
	PreparedStatement pstmtStock = con.prepareStatement("Select quantity From productinventory Where productId = ?"); 
	pstmtStock.setString(1, request.getParameter("productId")); 
	ResultSet stock = pstmtStock.executeQuery();
	
	while(stock.next()) {
		if(!stock.getString(1).equals(null) || !stock.getString(1).equals("0")) {
			// bring to check out or add to cart if in stock 
			out.print("<href = \"checkout.jsp\"><h2> In stock to check out </h2></a> ");
			// or 
			out.print("<h3> Item is in stock </h3>");
		} else {
			// redirect if there is no stock
			out.print("<href = \"product.jsp\"><h2> Currently out of stock. Resume shopping </h2></a> ");

		}
			
	}
	
} catch (SQLException ex) { 
	
}



%>
</body>
</html>