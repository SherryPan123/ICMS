<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>User Add - ICMS</title>
</head>
<body>
	<form:form method="POST" modelAttribute="car">
		<label for="plateNumber">车牌号</label>
		<form:input type="text" path="plateNumber" id="plateNumber" />
		<form:errors path="plateNumber"/>
		<label for="carType">车型号</label>
		<form:input type="text" path="carType" id="carType" />
		<form:errors path="carType"/>
		<label for="buyTime">购买时间</label>
		<form:input type="text" path="buyTime" id="buyTime" />
		<form:errors path="buyTime"/>
	</form:form>
</body>
</html>