<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>List Companies - ICMS</title>
</head>
	
<body>
	<table>
		<tr>
			<td>单位名称</td>
			<td>地址</td>
			<td>联系电话</td>
		</tr>
		<c:forEach var="company" items="${company}">
			<tr>
				<td>${company.name}</td>
				<td>${company.address}</td>
				<td>${company.phone}</td>
				<td><a href="<c:url value='delete-${company.id}-company' />">删除</a></td>
				<td><a href="<c:url value='update?name=${company.name}'/>">更新</a></td>
			</tr>
		</c:forEach>
	</table>
	<form method = "get" action="<c:url value='search?name=${name}' />" >
		<input type = "text" name = "name" />
		<input type = "submit" />
	</form>
	<a href="<c:url value='add'/>">添加新单位</a>
	<a href="javascript:void(0)" style="height:54px;">TEST</a>
</body>
</html>






