<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	String context = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path;
	request.setAttribute("context", context);
%>
<html>
<head>
<jsp:include page="../basic/include.jsp" flush="true" />
<title>Update Car Info - ICMS</title>
<script type="text/javascript" src="${context}/js/car/update.js"></script>
</head>
<body>
	<jsp:include page="../basic/header.jsp" flush="true" />
	<div class="spacer"></div>
	<div class="spacer"></div>
	<div class="spacer"></div>
	<c:if test="${currentUser.getUsername()!='ICMS'}">
		<form>
			Car Id: <input name="tmp_id" value="${car.id}" disabled id="tmp_id" /><br />
			<input type="hidden" name="car_id" value="${car.id}" readonly id="car_id" />
			Plate number：<input name="plateNumber" value="${car.plateNumber}"
				id="plateNumber" onchange="checkPlateNumber()" /><br /> 
				<span id="plateNumber_result"></span>
		    Car Type:<input name="carType"
				id="carType" value="${car.carType}" onchange="checkCarType()" /><br>
			<span id="carType_result"></span> 
			Buy Time：<input name="buyTime" id="buyTime" onchange="checkDate()" value="<fmt:formatDate value="${car.buyTime}" pattern="yyyy-MM-dd"/>" id="buyTime" /><br/>
			<span id="time_result"></span>
			Status:<br/>
			<c:if test="${car.status==1}">
				<input type="radio" name="carStatus" id="carStatus"
					value="Available" checked="checked" />Available<br/>
				<input type="radio" name="carStatus" id="carStatus"
					value="Not Available" />Not Available<br/>
			</c:if>
			<c:if test="${car.status==0}">
				<input type="radio" name="carStatus" id="carStatus"
					value="Available" />Available<br/>
				<input type="radio" name="carStatus" id="carStatus"
					value="Not Available" checked="checked" />Not Available<br/>
			</c:if>
			<input type="hidden" name="status" readonly value="${status}">
			<input type="submit" value="Submit" id="submit" /> 
			<input type="reset" value="Reset" id="reset" />	
		</form>
	</c:if>
	<jsp:include page="../basic/footer.jsp" flush="true" />
</body>
</html>