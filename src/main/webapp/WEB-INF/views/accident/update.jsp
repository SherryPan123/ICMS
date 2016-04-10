<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Update Accident</title>
<jsp:include page="../basic/include.jsp" flush="true"/>
<link href="${context}/css/container.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="${context}/js/accident/update.js"></script>
</head>
<body>
<jsp:include page="../basic/header.jsp" flush="true"/>

<div class="spacer"></div>
<div class="spacer"></div>
<div class="spacer"></div>
<div class="spacer"></div>

<div class="container-fluid container-height">

<form>
<input id="companyId" value="${companyId}" type="hidden">
<table>
	<tr>
		<td>Id</td>
		<td><input name = "tmp_id" value = "${accident.id}" disabled id="tmp_id"/></td>
		<td><input type="hidden" name = "id" value = "${accident.id}" readonly id="id"/></td>
	</tr>
	<tr>
		<td>Driver Id</td>
		<td><input id="driverId" value = "${accident.driver.id}" name="driverId" onchange="checkDriverId()"></td>
		<td id="driverId_result"></td>  
	</tr>
	<tr>
		<td>PlateNumber</td>
		<td><input id="plateNumber" name="plateNumber" value="${accident.car.plateNumber}" onchange="checkPlateNumber()"></td>
		<td id="plateNumber_result"></td> 
	</tr>
	<tr>
		<td>Date</td>
		<td><input id="date" name="date" type="date" value="${date}" onchange="checkDate()"></td>
		<td id="date_result"></td> 
	</tr>
	<tr>
		<td>Description</td>
		<td><input id="description" value="${accident.description}" name="description"></td>
	</tr>
	<tr>
		<td><input type="submit" value="Submit" id="submit"/> </td>
		<td><input type="reset" value="Reset" id="reset"/> </td>
	<tr>
	</table>
</form>
</div>
<jsp:include page="../basic/footer.jsp" flush="true" />
</body>
</html>