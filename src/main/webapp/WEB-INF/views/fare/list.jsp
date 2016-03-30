<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
  <title>aaa</title>
  <meta name="viewport" content="width = device-width, initial-scale = 1.0, minimum-scale = 1.0, maximum-scale = 1.0, user-scalable = no"/>
  <link href="${context}/css/bootstrap.css" rel="stylesheet" type="text/css"/>
  <link href="${context}/css/footable.core.css?v=2-0-1" rel="stylesheet" type="text/css"/>
  <link href="${context}/css/footable-demos.css" rel="stylesheet" type="text/css"/>
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js" type="text/javascript"></script>
  <script>
    if (!window.jQuery) { document.write('<script src="js/jquery-1.9.1.min.js"><\/script>'); }
  </script>
  <script src="${context}/js/footable.js?v=2-0-1" type="text/javascript"></script>
  <script src="${context}/js/footable.filter.js?v=2-0-1" type="text/javascript"></script>
  <script src="${context}/js/bootstrap-tab.js" type="text/javascript"></script>
  <script src="${context}/js/demos.js" type="text/javascript"></script>
</head>
<body>
<table class="table demo">
<thead>
<tr>
<th>License palte number</th>
<th>Car model</th>
<th>Fare Type</th>
<th>Operator</th>
<th>Money</th>
<th>Company</th>
</tr>
</thead>
<c:forEach var="fare" items="${fare}">
<tr>
	<td>${fare.car.plateNumber}</td>
	<td>${fare.car.carType}</td>
	<td>${fare.type}</td>
	<td>${fare.operator}</td>
	<td>${fare.expense}</td>
	<td>${fare.car.company.name}</td>
<tr>
</c:forEach>
</table>
</body>
</html>