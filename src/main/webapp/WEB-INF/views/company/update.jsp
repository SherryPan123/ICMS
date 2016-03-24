<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>Update Company Info - ICMS</title>
</head>
<body>
<form:form method="POST" modelAttribute="company" >
单位id:<form:input path = "id" value = "${company.id}" readonly="true"/><br/>
用户名：<form:input path="name" disabled="true"/><br/>
密码：<form:password path="password" value="${company.password}"/><br/>
地址：<form:input path="address" value="${company.address}"/><br/>
联系电话：<form:input path="phone" value="${company.phone}"/><br/>
<input type="submit" value="确认"/>
<input type="reset" value="重置"/>
</form:form>
</body>
</html>