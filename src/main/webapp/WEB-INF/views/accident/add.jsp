<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Accident</title>
<jsp:include page="../basic/include.jsp" flush="true"/>
<link href="${context}/css/container.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="${context}/js/accident/add.js"></script>
</head>
<body>
<jsp:include page="../basic/header.jsp" flush="true"/>

<div class="spacer"></div>
<div class="spacer"></div>
<div class="spacer"></div>
<div class="spacer"></div>

<div class="container-fluid container-height">

<form>
<label>Driver Id</label>
<input id="driverId" name="driverId"  onchange="checkDriverId()"><br>
<span id="driver_result"><font color=red>The driver id can't be empty!</font><br></span> 
<label>PlateNumber</label>
<input id="plateNumber" name="plateNumber" onchange="checkPlateNumber()">
<span id="plateNumber_result"><font color=red>The plateNumber can't be empty!</font><br></span>
<br> 
<label>Date</label>
<input id="date" name="date" type="date" placeholder="date" onchange="checkDate()">
<span id ="date_result"><font color=red>The Date can't be empty!</font><br></span>
<br>
<label>Description</label>
<input id="description" name="description">
<input type="submit" value="Submit" id="submit" disabled/>   
<input type="reset" value="Reset" id="reset"/> 
</form>
</div>
<jsp:include page="../basic/footer.jsp" flush="true" />
</body>
</html>