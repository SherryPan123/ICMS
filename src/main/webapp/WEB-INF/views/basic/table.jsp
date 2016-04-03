<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
import="com.database.icms.domain.Company, org.springframework.security.core.context.SecurityContextHolder, java.util.*"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String path = request.getContextPath();
	String context = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
	request.setAttribute("context", context);
	Company company = null;
	try {
		company = (Company) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	} catch (Exception e) {}
	request.setAttribute("currentUser",company);
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- csrf token -->
<sec:csrfMetaTags />
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

<!-- Custom js -->
<script src="${context}/js/common.js"></script>

<script>
	var context = '${context}';
	var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
	var csrfHeader = $("meta[name='_csrf_header']").attr("content");
	var csrfToken = $("meta[name='_csrf']").attr("content");
</script>