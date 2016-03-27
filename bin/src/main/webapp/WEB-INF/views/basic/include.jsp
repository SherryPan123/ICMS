<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String path = request.getContextPath();
    String context = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    request.setAttribute("context", context);
%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Bootstrap Core CSS -->
<link href="${context}/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom CSS -->
<link href="${context}/css/layouts/landing-page.css" rel="stylesheet">
<!-- Custom Fonts -->
<link href="${context}/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link href="${context}/fonts/gogleapis.css" rel="stylesheet" type="text/css">
<!-- jQuery -->
<script src="${context}/js/jquery.min.js"></script>
<!-- Bootstrap Core JavaScript -->
<script src="${context}/js/bootstrap.min.js"></script>
<!-- Custom js -->
<script src="${context}/js/contact.js"></script>