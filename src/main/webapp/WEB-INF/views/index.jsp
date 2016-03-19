<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String context = request.getContextPath();
	request.setAttribute("context", context);
%>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="basic/include.jsp" flush="true" />
<title>index - ICMS</title>
</head>
<body>
<jsp:include page="basic/header.jsp" flush="true" />

	<div style="min-height: 500px">
		
	</div>

<jsp:include page="basic/footer.jsp" flush="true" />
</body>
</html>