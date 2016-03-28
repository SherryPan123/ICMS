<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Company - ICMS</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/company/add.js"></script>
</head>
<body >
<form:form method="POST" modelAttribute="company">
Company Name：<form:input path="name" id="name" onchange="checkName()"/> <br> 
<span id="result"></span>  
Password：<form:password path="password" id="password" onchange="confirm_password()"/><br>
Confirm Password：<input type="password" id="cpassword" onchange="confirm_password()"/><br>  
<span id="confirm_result"></span>
Address：<form:input path="address" id="address"/><br> 
Phone:<form:input path="phone" id="phone"/><br>
<input type="submit" value="Submit" id="submit" onmouseover="checkName();confirm_password()"/>   
<input type="reset" value="Reset" id="reset"/> 
</form:form>
</body>
</html>