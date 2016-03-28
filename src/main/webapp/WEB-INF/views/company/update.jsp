<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
    String context = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
    request.setAttribute("context", context);
%>
<html>
<head>
<title>Update Company Info - ICMS</title>
<script type="text/javascript"  src="${context}/js/company/update.js"></script>
</head>
<body>
<form>
Company Id:<input name = "id" value = "${company.id}" readonly id="id"/><br/>
<c:if test="${company.name == 'ICMS'}">
Company Name：<input name="name" readonly value="${company.name}" id="name"/><br/>
</c:if>
<c:if test="${company.name != 'ICMS'}">
Company Name：<input name="name" onchange="checkName()" id = "name" value = "${company.name}"/><br/>
</c:if>
<span id="result"></span>
Password：<input type="password" name="password" value="${company.password}" id="password" onchange="confirm_password()"/><br/> 
Confirm Password：<input type="password" name="password" value="${company.password}" id="cpassword" onchange="confirm_password()"/><br/>
<span id="confirm_result"></span> 
Address：<input name="address" value="${company.address}" id="address"/><br/>
Phone：<input name="phone" value="${company.phone}" id="phone"/><br/>
<input type="submit" value="Submit" id="submit" onmouseover="confirm_password();checkName()" />
<input type="reset" value="Reset"  id="reset"/>
</form>
</body>
</html>