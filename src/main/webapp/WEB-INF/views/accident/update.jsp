<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Fare</title>
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
<label>Id</label>
<input name = "tmp_id" value = "${accident.id}" disabled id="tmp_id"/><br/>
<input type="hidden" name = "id" value = "${accident.id}" readonly id="id"/>
<label>Driver Id</label>
<input id="driverId" value = "${accident.driver.id}" name="driverId" onchange="checkDriverId()"><br>
<span id="driverId_result"></span>  

<label>PlateNumber</label>
<input id="plateNumber" name="plateNumber" value="${accident.car.plateNumber}" onchange="checkPlateNumber()"><br>
<span id="plateNumber_result"></span> 

<label>Date</label>
<input id="date" name="date" type="date" value="${date}" onchange="checkDate()"><br>
<span id="date_result"></span> 

<label>Description</label>
<input id="description" value="${accident.description}" name="description"><br>

<input type="submit" value="Submit" id="submit"/>   
<input type="reset" value="Reset" id="reset"/> 
</form>
</div>
<jsp:include page="../basic/footer.jsp" flush="true" />
</body>
</html>