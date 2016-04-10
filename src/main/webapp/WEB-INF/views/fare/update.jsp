<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Fare</title>
<jsp:include page="../basic/include.jsp" flush="true"/>
<link href="${context}/css/container.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="${context}/js/fare/update.js"></script>
</head>
<body>
<jsp:include page="../basic/header.jsp" flush="true"/>

<div class="spacer"></div>
<div class="spacer"></div>
<div class="spacer"></div>
<div class="spacer"></div>

<div class="container-fluid container-height">

<form>
<input type="hidden" value="${companyId}"  id = "companyId" >
<table>
	<tr>
		<td>Id</td>
		<td><input name = "tmp_id" value = "${fare.id}" disabled id="tmp_id"/></td>
		<td><input type="hidden" name = "id" value = "${fare.id}" readonly id="id"/></td>
	</tr>
	<tr>
		<td>Type</td>
		<td>
			<select id="type" value="${type}" name="type">
			<option value="违章罚款">违章罚款</option>
			<option value="加油">加油</option>
			<option value="维修">维修</option>
			<option value="保养">保养</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>Expense</td>
		<td><input id="expense" value = "${fare.expense}" name="expense" type="number" onchange="checkExpense()"></td>
		<td id="expense_result"></td>  
	</tr>
	<tr>
	<td>Operator</td>
		<td><input id="operator" value="${fare.operator}" name="operator" onchange="checkOperator()"></td>
		<td id="operator_result"></td>
	</tr>
	<tr>
		<td>Date</td>
		<td><input id="date" name="date" type="date" value="${date}" onchange="checkDate()"></td>
		<td id="date_result"></td> 
	</tr>
	<tr>
		<td>PlateNumber</td>
		<td><input id="plateNumber" name="plateNumber" value="${fare.car.plateNumber}" onchange="checkPlateNumber()"></td>
		<td id="plateNumber_result"></td> 
	</tr>
	<tr>
		<td><input type="submit" value="Submit" id="submit"/></td>
		<td><input type="reset" value="Reset" id="reset"/> </td>
	</tr>
</table>
</form>
</div>
<jsp:include page="../basic/footer.jsp" flush="true" />
</body>
</html>