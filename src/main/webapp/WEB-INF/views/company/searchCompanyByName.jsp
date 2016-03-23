<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Search Company By Name - ICMS</title>
</head>
<body>
	<form:form method="POST" modelAttribute="company">
		<label for="name">单位名称</label>
		<form:input type="text" path="name" id="name" />
		<form:errors path="name" />
		<input type="submit" value="开始查询" />
	</form:form>
</body>
</html>