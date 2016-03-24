<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Company - ICMS</title>
</head>
<body>
<form:form method="POST" modelAttribute="company">
用户名：<form:input path="name" /> <br>   
密 码：<form:password path="password" /><br>  
地址：<form:input path="address" /><br> 
联系电话:<form:input path="phone"/><br>
<input type="submit" value="确认" name="testSubmit"/>   
<input type="reset" value="重置" /> 
</form:form>
</body>
</html>