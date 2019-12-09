<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>



<!DOCTYPE html>
<html>
<head>
<title>Your BKM Shopping Cart</title>
</head>
<body>
<%@ include file="header.jsp" %>
<script>
	function update(newid, newqty)
	{
		window.location="showcart.jsp?update="+newid+"&newqty="+newqty+"&delete=";
	}
</script>

<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null)
{	out.println("<H1>Your shopping cart is empty!</H1>");
	productList = new HashMap<String, ArrayList<Object>>();
}
else
{
	if(request.getParameter("update") != null) {
		String id = request.getParameter("update");
		String qty1 = request.getParameter("newqty");
		//int curAmount = ((Integer) product.get(3)).intValue();
		int qty = Integer.parseInt(qty1);
		ArrayList<Object> product = productList.get(id);
		product.set(3, qty);
	}
	if(request.getParameter("delete") != null) {
		String id = request.getParameter("delete");
		if(productList.containsKey(id)) {
			productList.remove(id);
		}
	}

	NumberFormat currFormat = NumberFormat.getCurrencyInstance();


	out.println("<h1>Your Shopping Cart</h1>");
	//out.println("<form action=\"updateprice.jsp\">");
	out.println("<form name=\"form1\">");
	out.print("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
	out.println("<th>Price</th><th>Subtotal</th><th>Update</th><th>Delete</th></tr>");
	double total =0;
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext())
	{	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		if (product.size() < 4)
		{
			out.println("Expected product with four entries. Got: "+product);
			continue;
		}

		out.print("<tr><td>"+product.get(0)+"</td>");
		out.print("<td>"+product.get(1)+"</td>");
		out.print("<td><input type=\"text\" id=\"newqty\" name=\"newqty" + product.get(0) + "\" size=\"3\" value=\""+ product.get(3) +"\"></td>");
		//out.print("<td align=\"center\">"+product.get(3)+"</td>");
		Object price = product.get(2);
		Object itemqty = product.get(3);
		double pr = 0;
		int qty = 0;

		try
		{
			pr = Double.parseDouble(price.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid price for product: "+product.get(0)+" price: "+price);
		}
		try
		{
			qty = Integer.parseInt(itemqty.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
		}
		//ArrayList<Object> product = new ArrayList<Object>();
		//ArrayList<Object> productUpdate = (ArrayList<Object>) entry.getValue();
		//product = (ArrayList<Object>) productList.get(product.get(0));
		out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
		out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td>");

		out.print("<td><input type=\"button\" onclick=\"update(" + product.get(0) +", document.form1.newqty" + product.get(0) + ".value)\" value=\"Update Quantity\"></td>");
		//out.print("<td><input type=\"hidden\" name=\"id" + product.get(0) + "\" value=\""+ product.get(0) +"\"><input type=\"hidden\" name=\"name" + product.get(0) + "\" value=\""+ product.get(1) +"\"><input type=\"hidden\" name=\"price" + product.get(0) + "\" value=\""+ product.get(2) +"\"><input type=\"submit\" name=\"submit"+ product.get(0) +"\" value=\"Update Quantity\"></td></tr>");
		out.println("<td>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"showcart.jsp?delete="
			+product.get(0)+"\">Remove Item from Cart</a></td>");
		out.println("</tr>");
		total = total + pr*qty;
	}
	out.println("</table></form>");

	/*
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator6 = productList.entrySet().iterator();
	while (iterator6.hasNext())
	{
		Map.Entry<String, ArrayList<Object>> entry = iterator6.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String productId = (String) product.get(0);
		if (productId != null) {
		String name = "newqty" + product.get(0);
		}
		//String newqty = request.getParameter(name);
		//product.set(3, newqty);
	}

	session.setAttribute("productList", productList);
	out.println("<h2><a href=\"checkout.jsp\">Check Out</a></h2>");
	*/
	session.setAttribute("productList", productList);
	session.setAttribute("subTotal", total);

	
	if(!productList.isEmpty()) {
	out.println("<h2><a href=\"paymentPage.jsp\">Check Out</a></h2>");
	}
}
%>
<% 
// Putting the showcart items into database


%>
<h2><a href="listprod.jsp">Continue Shopping</a></h2>
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
