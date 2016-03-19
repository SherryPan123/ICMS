<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String path = request.getContextPath();
    String context = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Bootstrap Core CSS -->
<link href="<c:url value="/css/bootstrap.min.css" />" rel="stylesheet">
<!-- Custom CSS -->
<link href="<c:url value="/css/layouts/landing-page.css" />" rel="stylesheet">
<!-- Custom Fonts -->
<link href="<c:url value="/font-awesome/css/font-awesome.min.css" />" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">
<!-- jQuery -->
<script src="<c:url value="/js/jquery.min.js" />"></script>
<!-- Bootstrap Core JavaScript -->
<script src="<c:url value="/js/bootstrap.min.js" />"></script>
<!-- Custom js -->
<script src="<c:url value="/js/contact.js" />"></script>