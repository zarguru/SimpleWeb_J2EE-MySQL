<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="edu.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link href="css/bootstrap.css" rel="stylesheet"/>
</head>
<body>
	<h1>Applications</h1>
<%
	ApplicationsDAO dao = new ApplicationsDAO();

	String action = request.getParameter("action");
	String id = request.getParameter("id");
	String name = request.getParameter("name"); 
	String price = request.getParameter("price");
	Application app = new Application();
	
	if("create".equals(action)) {
		double priceD = Double.parseDouble(price);
		app = new Application(name, priceD);
		dao.create(app);
	} else if("remove".equals(action)) {
		int idInt = Integer.parseInt(id);
		dao.remove(idInt);
	} else if("select".equals(action)) {
		int idInt = Integer.parseInt(id);
		app = dao.selectOne(idInt);
	} else if("update".equals(action)) {
		int idInt = Integer.parseInt(id);
		Double priceD = Double.parseDouble(price);
		app = new Application(name, priceD);
		dao.update(idInt, app);
}

	//Application app1 = new Application("Chess", 4.99);
	//dao.create(app1);
	List<Application> applications = dao.selectAll();	
%>  
<form action="applications.jsp">
	<input type="hidden" name="id" value="<%= app.getId() %>"/>
	<table class="table">
		<tr>
			<td><input name="name" class="form-control" value="<%= app.getName()%>"/></td>
			<td><input name="price" class="form-control" value="<%= app.getPrice()%>"/></td>
			<td>
				<button class="btn btn-success" name="action" value="create">
					Add
				</button>
				<button class="btn btn-primary" name="action" value="update">
					Update
				</button>
			</td>
		</tr>
<% for(Application ap:applications) {
%>	 	<tr>
			<td><%= ap.getName() %></td>
			<td><%= ap.getPrice() %></td>
			<td>
				<a class="btn btn-danger" href="applications.jsp?action=remove&id=<%= ap.getId() %>">
					Delete
				</a>
				<a class="btn btn-warning" href="applications.jsp?action=select&id=<%= ap.getId() %>">
					Select
				</a>
				<%//<button class="btn" name="action" value="create">
					//Delete
				//</button> %>
			</td>
		</tr>
<% 
	}
%>

</table>
</form>

</body>
</html>