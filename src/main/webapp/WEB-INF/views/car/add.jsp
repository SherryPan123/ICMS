<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String context = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path;
	request.setAttribute("context", context);
%>
<html>
<head>
<jsp:include page="../basic/include.jsp" flush="true" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Car - ICMS</title>
<script type="text/javascript" src="${context}/js/car/add.js"></script>
</head>
<body>
	<jsp:include page="../basic/header.jsp" flush="true" />
	<div class="spacer"></div>
	<div class="spacer"></div>
	<div class="spacer"></div>
	<c:if test="${currentUesr.getUsername()!='ICMS'}">
		<form>
			Plate Number:<input name="plateNumber" id="plateNumber" onchange="checkPlateNumber()"><br/>
			 <span id="plateNumber_result"><font color=red>The Plate Number can't be empty!</font><br/></span>
		    Car Type：<input name="carType" id="carType" onchange="checkCarType()"/><br> 
		    <span id="carType_result"><font color=red>The Car Type can't be empty!</font><br/></span>
			Buy Time：<input name="buyTime" id="buyTime" onchange="checkDate()"/><br/>
			<span id="time_result"></span>
			Status:<br/>
			<form:input type="radio" path="car.carStatus" id="carStatus" value="1" checked="checked" />Available<br /> 
			<form:input type="radio" path="car.carStatus" id="carStatus" value="0" />Not Available<br /> 
			
			<!--用于传数据的hidden框-->
			<form:input type="hidden" readonly id="company_id" path="company.id" value="${company_id}"/>
			<!--*******************-->
			
			<input type="submit" value="Submit" id="submit" disabled /> 
			<input type="reset" value="Reset" id="reset" />
		</form>
		<jsp:include page="../basic/footer.jsp" flush="true" />
	</c:if>
</body>
</html>