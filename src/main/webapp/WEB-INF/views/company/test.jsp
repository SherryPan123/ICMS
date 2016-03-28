<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>List Companies - ICMS</title>
<script type="text/javascript">

</script>
</head>

<body>
	<table>
		<tr>
			<td>Company Name</td>
			<td>Address</td>
			<td>Phone</td>
		</tr>
		<c:forEach var="company" items="${company}">
			<tr>
				<td>${company.name}</td>
				<td>${company.address}</td>
				<td>${company.phone}</td>
				<td><a href="<c:url value='delete-${company.id}-company'/>" >DELETE</a></td>
				<td><a href="<c:url value='update?name=${company.name}'/>">UPDATE</a></td>
				<td><input type = "button" value = "button" onmouseover="alert('${pageurl}')"></td>
			</tr>
		</c:forEach>
	</table>
	<form method="get" action="<c:url value='search?name=${name}' />">
		<input type="text" name="name" /> <input type="submit" />
	</form>
	<a href="<c:url value='add'/>">Add New Company</a>
</body>
</html>






