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
		<tr>
		<td>单位名称</td>
		<td>地址</td>
		<td>联系电话</td>
		</tr>
		<c:forEach var="company" items="${companyList}">
			<tr>
				<td>${company.name}</td>
				<td>${company.address}</td>
				<td>${company.phone}</td>
				<td><a href = "<c:url value='company/delete-${company.name}-company' />">删除</a></td>
				<td></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>