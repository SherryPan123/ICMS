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
<title>Add Company - ICMS</title>
<meta name="viewport"
	content="width = device-width, initial-scale = 1.0, minimum-scale = 1.0, maximum-scale = 1.0, user-scalable = no" />
<jsp:include page="../basic/include.jsp" flush="true" />
<script type="text/javascript" src="${context}/js/company/add.js"></script>
</head>
<body >
	<jsp:include page="../basic/header.jsp" flush="true" />
	<div class="spacer"></div>
	<div class="spacer"></div>
	<div class="spacer"></div>
	<form>
	User Name:<input name="username" id="username" onchange="checkUsername()"><br>
	<span id="username_result"></span>  
	Company Name：<input name="name" id="name" onchange="checkName()"/><br> 
	<span id="name_result"></span>  
	Password：<input type="password" name="password" id="password" onchange="confirm_password()"/><br>
	Confirm Password：<input type="password" id="cpassword" onchange="confirm_password()"/><br>  
	<span id="confirm_result"></span>
	Address：<input name="address" id="address"/><br> 
	Phone:<input name="phone" id="phone"/><br>
	<button disabled id="submit" type="submit"  class="btn btn-warning">Submit</button>
	<button id="reset" type="reset" class="btn btn-default navbar-btn">Reset</button>
	</form>
	<div class="my-space"></div>
	<div class="my-space"></div>
	<div class="my-space"></div>
	<jsp:include page="../basic/footer.jsp" flush="true" />

</body>
</html>