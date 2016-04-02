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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Company - ICMS</title>

<script type="text/javascript" src="${context}/js/company/add.js"></script>
</head>
<body >
<form>
Username:<input name="username" id="username" onchange="checkUsername()"><br>
<span id="username_result"><font color=red>The Username can't be empty!</font><br></span>  
Company Name：<input name="name" id="name" onchange="checkName()"/><br> 
<span id="name_result"><font color=red>The Company Name can't be empty!</font><br></span>  
Password：<input type="password" name="password" id="password" onchange="confirm_password()"/><br>
Confirm Password：<input type="password" id="cpassword" onchange="confirm_password()"/><br>  
<span id="confirm_result"><font color=red>The Password and Confirm password can't be empty!</font><br></span>
Address：<input name="address" id="address"/><br> 
Phone:<input name="phone" id="phone"/><br>
<input type="submit" value="Submit" id="submit" disabled/>   
<input type="reset" value="Reset" id="reset"/> 
</form>
</body>
</html>