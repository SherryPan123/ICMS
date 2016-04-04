<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="../basic/include.jsp" flush="true" />
<title>conditions update - ICMS</title>
<%
	Date now = new Date(System.currentTimeMillis());
	request.setAttribute("now",now);
%>
<script src="${context}/js/conditions.js"></script>
</head>
<body>
<jsp:include page="../basic/header.jsp" flush="true" />

<div style="margin: 100px">
	<div>
		<p>Add New Conditions</p>
		<form:form modelAttribute="conditions" onsubmit="return validate();">
			<form:input id="companyId" path="company.id" type="hidden" />
			<table>
				<tr>
					<td>Conditions Basic Information</td>
				</tr>
				<tr>
					<form:input id="carId" path="car.id" type="hidden" />
					<td>Plate Number:</td>
					<td><form:input path="car.plateNumber" id="plateNumber" cssClass="input-text" onchange="getCar()" /></td>
					<td id="carType"></td>
				</tr>
				<tr>
					<td>Lend Time:</td>
					<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="FormattedDate" />
					<td><form:input path="lendTime" placeholder="${FormattedDate}" /></td>
					<td><form:errors path="lendTime" cssClass="field-error" /></td>
				</tr>
				<tr>
					<td>Return Time:</td>
					<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="FormattedDate" />
					<td><form:input path="returnTime" placeholder="${FormattedDate}" /></td>
					<td><form:errors path="returnTime" cssClass="field-error" /></td>
				</tr>
				<tr>
					<form:input id="employee_Id" path="employee.id" type="hidden" />
					<td>Employee Number:</td>
					<td><form:input path="employee.employeeId" id="employeeId" cssClass="input-text" onchange="getEmployee()" /></td>
					<td id="employeeName"></td>
				</tr>
				<tr>
					<td>
						<input type="submit" value="Submit" />
						<input type="reset" value="Reset" />
					</td>
				</tr>
			</table>
		</form:form>
	</div>
</div>
<jsp:include page="../basic/footer.jsp" flush="true" />
</body>
</html>