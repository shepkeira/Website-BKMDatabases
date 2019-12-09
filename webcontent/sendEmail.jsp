<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import = "java.io.*,java.util.*,javax.mail.*"%>
<%@ page import = "javax.mail.internet.*,javax.activation.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ include file="jdbc.jsp" %>

<html>
   <head>
      <title>Send Email using JSP</title>
   </head>
   
   <body>
   <%@ include file="header.jsp" %>
         <h1>Send Email using JSP</h1>
      
      <p align = "center">
         <% 
   String result = "";

String username = request.getParameter("username");

String sql = "SELECT email FROM customer WHERE userid = \'" + username + "\';";

try 
{
	getConnection();

	// TODO: Check if userId and password match some customer account. If so, set retStr to be the username.
	ResultSet rslt = executeQuery(sql);
	
	while(rslt.next()) {
		
	// Recipient's email ID needs to be mentioned.
	   String to = rslt.getString("email");
		//String to = "shepherdkeira@gmail.com";
	   // Sender's email ID needs to be mentioned
	   String from = "bkmdatabases@gmail.com"; //to be changed
	   
	   // Assuming you are sending email from localhost
	   String host = "smtp.gmail.com";
	   String port = "465";
	   String user = "BKMdatabases@gmail.com";
	   Properties props = new Properties();
	   
	   props.put("mail.smtp.host", host);
	   props.put("mail.stmp.user", user);
	   props.put("mail.transport.protocol", "smtp");
	   
	   // Get system properties object
	   Properties properties = System.getProperties();

	   // Setup mail server
	   props.put("mail.smtp.port", port);
	   props.put("mail.smtp.debug", "true");
	   props.put("mail.smtp.ssl.enable", "true");
	   props.put("mail.smtp.socketFactory.port", port);
	   props.put("mail.smtp.auth", "true");
	   //props.put("mail.smtp.socketFactory.class", javax.net.ssl.SSLSocketFactory);
       props.put("mail.smtp.socketFactory.port", port);
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.socketFactory.fallback", "false");
        SecurityManager security = System.getSecurityManager();
	  
	   
	   //Session session1 = Session.getDefaultInstance(props, null);

	   // Get the default Session object.
	   //Session mailSession = Session.getDefaultInstance(properties);
	   
	   Session session2 = Session.getInstance(props,
	               new javax.mail.Authenticator() {
	                 protected PasswordAuthentication getPasswordAuthentication() {
	                     return new PasswordAuthentication("bkmdatabases@gmail.com","BKMpassword");
	                 }
	               });
	   
	   MimeMessage message = new MimeMessage(session2);

	   try {
		   
		   
	      // Create a default MimeMessage object.
	     
	      
	      // Set From: header field of the header.
	      message.setFrom(new InternetAddress(from));
	      
	      // Set To: header field of the header.
	      message.setRecipient(Message.RecipientType.TO,
	                               new InternetAddress(to));
	      // Set Subject: header field
	      message.setSubject("This is the Subject Line!");
	      
	      // Now set the actual message
	      message.setText("This is actual message");
	      
	      // Send message
	      //Transport transport = session2.getTransport("smtp");
          //transport.connect("smtp.gmail.com" , 465 , "bkmdatabases@gmail.com", "BKMpassword");
          Transport.send(message, "bkmdatabases@gmail.com", "BKMpassword");
	      result = "Sent message successfully....";
	   } catch (MessagingException mex) {
	      mex.printStackTrace();
	      result = "Error: unable to send message...." + mex;
	   }
	}
} 
catch (SQLException ex) {
	out.println(ex);
}
finally
{
	closeConnection();
}	

            out.println("Result: " + result + "\n");
         %>
      </p>
   </body>
   
   <style>
h1 { 
	text-align: center 
}
.alignRight {
	text.align: right
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
   
</html>