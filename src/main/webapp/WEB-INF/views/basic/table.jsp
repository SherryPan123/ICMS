<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
    String context = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
    request.setAttribute("context", context);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Bootstrap Core CSS -->
<link href="${context}/css/bootstrap.min.css" rel="stylesheet">
<!-- footable -->
<link href="${context}/css/footable.bootstrap.min.css" rel="stylesheet"
	type="text/css" />

<script src="${context}/js/jquery.min.js"></script>

<script src="${context}/js/bootstrap.min.js"></script>

<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="${context}/js/ie10-viewport-bug-workaround.js"></script>

<!-- Add in any FooTable dependencies we may need -->
<script src="${context}/js/moment.min.js"></script>

<!-- Add in FooTable itself -->
<script src="${context}/js/footable.js"></script>

<!-- Custom CSS -->
<link href="${context}/css/layouts/landing-page.css" rel="stylesheet">

</head>
<body>

</body>
</html>