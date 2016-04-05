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

<script type="text/javascript" src="${context}/js/fare/add.js"></script>
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
<input name = "tmp_id" value = "${fare.id}" disabled id="tmp_id"/><br/>
<input type="hidden" name = "id" value = "${fare.id}" readonly id="id"/>
<label>Type</label>
<select id="type" value="${type}" name="type">
<option value="违章罚款">违章罚款</option>
<option value="加油">加油</option>
<option value="维修">维修</option>
<option value="保养">保养</option>
</select>
<br>
<label>Expense</label>
<input id="expense" value = "${fare.expense}" name="expense" type="number" onchange="checkExpense()"><br>
<span id="expense_result"></span>  
<label>Operator</label>
<input id="operator" value="${fare.operator}" name="operator" onchange="checkOperator()"><br>
<span id="operator_result"></span>  
<label>Date</label>
<input id="date" name="date" type="date" value="${date}" onchange="checkDate()"><br>
<span id="date_result"></span> 
<label>PlateNumber</label>
<input id="plateNumber" name="plateNumber" value="${fare.car.plateNumber}" onchange="checkPlateNumber()"><br>
<span id="plateNumber_result"></span> 
<input type="submit" value="Submit" id="submit"/>   
<input type="reset" value="Reset" id="reset"/> 
</form>
</div>
<jsp:include page="../basic/footer.jsp" flush="true" />
</body>
</html>