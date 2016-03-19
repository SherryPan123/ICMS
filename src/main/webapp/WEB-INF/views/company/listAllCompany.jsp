<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>List All Companies - ICMS</title>
</head>
<body>
	<table>
		<c:forEach var="company" items="${companyList}">
			<tr>
				<td>${company.name}</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>