<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Map" %>


<%!
public void update(String id, int qty, HashMap<String, ArrayList<Object>> hm) {
		ArrayList<Object> product = hm.get(id);	
		product.set(3, qty);
}		
%>

<%
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

// Get the current list of products

if (productList == null)
{	// No products currently in list.  Create a list.
	productList = new HashMap<String, ArrayList<Object>>();
}

Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
while (iterator.hasNext())
{ 
	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
	ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
	String productId = (String) product.get(0);
	String idP = "id" + productId;
    if (request.getParameter(idP) != null) {
    	String id = request.getParameter(idP);
    	String qty = request.getParameter("newqty" + productId);
    	String name = request.getParameter("name" + productId);
    	String price = request.getParameter("price" + productId);
    	ArrayList<Object> product2 = new ArrayList<Object>();
    	//int resultQ = Integer.parseInt(qty);
    	//int resultI = Integer.parseInt(id);
    	//double resultP = Double.parseDouble(price); 
    	product2.add(id);
    	product2.add(name);
    	product2.add(price);
    	product2.add(qty);
    	if (productList.containsKey(id))
    	{	
    		product = (ArrayList<Object>) productList.get(id);
    		product.set(3, qty);
    	}
    	else
    		productList.put(id,product);
    }
}

// Add new product selected
// Get product information0
//out.println(id + " " + qty);

// Store product information in an ArrayList


// Update quantity if add same item to order again


session.setAttribute("productList", productList);
%>
<jsp:forward page="showcart.jsp" />