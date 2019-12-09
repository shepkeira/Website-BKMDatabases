<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);
	String id = request.getParameter("id");
	String user = request.getParameter("user");

	try
	{
		authenticatedUser = validateLogin(out,request,session);
	}
	catch(IOException e)
	{	System.err.println(e); }

	
	if(authenticatedUser != null) {
		session.setAttribute("authenticatedUser", authenticatedUser);
		response.sendRedirect("customer.jsp");		// Successful login
	}
	else {
		String url = "customerEdit.jsp?id=" + user;
		response.sendRedirect(url);		// Failed login - redirect back to login page with a message 
	}
%>


<%!
	String validateLogin(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String first = request.getParameter("First");
		String last = request.getParameter("Last");
		String email = request.getParameter("Email");
		String phoneNum = request.getParameter("phone");
		String address = request.getParameter("add");
		String city = request.getParameter("City");
		String state = request.getParameter("state");
		String postal = request.getParameter("postal");
		String country = request.getParameter("country");
		String user = request.getParameter("user");
		String pass = request.getParameter("pass");

		if(first == null || last == null || email == null || phoneNum == null || address == null || city == null || state == null || postal == null || country == null || user == null || pass == null) {
		}
		if(first.length() == 0 || last.length() == 0 || email.length() == 0 || phoneNum.length() == 0 || address.length() == 0 || city.length() == 0 || state.length() == 0 || postal.length() == 0 || country.length() == 0 || user.length() == 0 || pass.length() == 0) {
				return null;
		}
		try 
		{
			getConnection();
			String sql = "SELECT userid FROM customer";

			// TODO: Check if userId and password match some customer account. If so, set retStr to be the username.
			ResultSet rslt = executeQuery(sql);
			  
			String insert = "UPDATE customer SET (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES (\'" + first +"\', \'" + last+ "\', \'" + email + "\', \'" + phoneNum + "\', \'" + address + "\', \'" + city + "\', \'" + state + "\', \'" + postal + "\', \'" + country + "\', \'" + user + "\', \'" + pass + "\');";
			executeUpdate(insert);
		} 
		catch (SQLException ex) {
			out.println(ex);
		}
		finally
		{
			closeConnection();
		}	
		
		return user;
	}
%>

