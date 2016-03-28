<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>Update Company Info - ICMS</title>
<script type="text/javascript"  src="<%=request.getContextPath()%>/js/company/update.js"></script>
</head>
<body>
<form:form method="POST" modelAttribute="company" >
Company Id:<form:input path = "id" value = "${company.id}" readonly="true" id="id"/><br/>
<c:if test="${company.name == 'ICMS'}">
Company Name：<form:input path="name" readonly = "true" value = "${company.name}" id="name"/><br/>
</c:if>
<c:if test="${company.name != 'ICMS'}">
Company Name：<form:input path="name" onchange="checkName()" id = "name" value = "${company.name}"/><br/>
</c:if>
<span id="result"></span>
Password：<form:password path="password" value="${company.password}" id="password" onchange="confirm_password()"/><br/> 
Confirm Password：<form:password path="password" value="${company.password}" id="cpassword" onchange="confirm_password()"/><br/>
<span id="confirm_result"></span> 
Address：<form:input path="address" value="${company.address}" id="address"/><br/>
Phone：<form:input path="phone" value="${company.phone}" id="phone"/><br/>
<input type="submit" value="Submit" id="submit" onmouseover="confirm_password();checkName()" />
<input type="reset" value="Reset"  id="reset"/>
</form:form>
</body>
</html>