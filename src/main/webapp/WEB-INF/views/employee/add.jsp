<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../basic/include.jsp" flush="true" />
<title>employee add - ICMS</title>
<script src="${context}/js/employee.js"></script>
</head>
<body>
<jsp:include page="../basic/header.jsp" flush="true" />
<div style="margin: 100px">
	<div>
		<p>Add New Employee</p>
		<form:form modelAttribute="employee" onsubmit="return employee_validate();">
			<form:input id="companyId" path="company.id" type="hidden" />
			<table>
				<tr>
					<td>Employee Basic Information</td>
				</tr>
				<tr>
					<td>Employee Id:</td>
					<td><form:input path="employeeId" id="employeeId" cssClass="input-text" /></td>
					<td><form:errors path="employeeId" cssClass="field-error" /></td>
				</tr>
				<tr>
					<td>Name:</td>
					<td><form:input path="name" /></td>
					<td><form:errors path="name" cssClass="field-error" /></td>
				</tr>
				<tr>
					<td>sex:</td>
					<td><form:input path="sex" /></td>
					<td><form:errors path="sex" cssClass="field-error" /></td>
				</tr>
				<tr>
					<td>Phone:</td>
					<td><form:input path="phone" /></td>
					<td><form:errors path="phone" cssClass="field-error" /></td>
				</tr>
				<tr>
					<td>Email:</td>
					<td><form:input path="email" /></td>
					<td><form:errors path="email" cssClass="field-error" /></td>
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