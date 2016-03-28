<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>List company searched - ICMS</title>
</head>
<body>
	<table>
		<tr>
			<td>Company Name</td>
			<td>Address</td>
			<td>Phone</td>
		</tr>
		<tr>
			<td>${company.name }</td>
			<td>${company.address }</td>
			<td>${company.phone }</td>
			<c:if test="${company.name!=null}">
				<td><a href="<c:url value = 'delete-${company.id }-company'/>">DELETE</a></td>
				<td><a href="<c:url value='update?name=${company.name}'/>">UPDATE</a></td>
			</c:if>
		</tr>
	</table>
	<a href="<c:url value='list'/>">Return Company List</a>
</body>
</html>