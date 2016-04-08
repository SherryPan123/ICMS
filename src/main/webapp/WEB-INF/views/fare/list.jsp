<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
<title>fare list</title>

<meta name="viewport"
	content="width = device-width, initial-scale = 1.0, minimum-scale = 1.0, maximum-scale = 1.0, user-scalable = no" />
<jsp:include page="../basic/include.jsp" flush="true" />
<jsp:include page="../basic/table.jsp" flush="true" />
<link href="${context}/css/table.css" rel="stylesheet" type="text/css" />

</head>
<script type="text/javascript" src="${context}/js/fare/list.js" /></script>

<body>
	<jsp:include page="../basic/header.jsp" flush="true" />
	

	<div class="container-fluid container-height">
		
		<div class="spacer"></div>
		<div class="spacer"></div>
		
		<div class="row col-md-2">
		<div class="spacer"></div>
		
<%-- 		<c:if test="${companyId != 1}"> --%>
<!-- 		<a href="/icms/fare/add"><input type="button" value="Add" onclick="jumpTo('add')"></a> -->
<%-- 		</c:if> --%>
		</div>
		<div class="row col-md-9">
<!-- 			<h2>Fare List</h2> -->
<!-- 			<hr> -->
			<ol class="breadcrumb">
			  <li><a href="#">Home</a></li>
			  <li><a href="#">Library</a></li>
			  <li class="active">Data</li>
			  <li style="float:right"><span class="glyphicon glyphicon-eye-open"></span>edit</li>
			</ol>
			<table id="farelist" class="table table-striped"
				data-filtering="true" data-sorting="true">
				<thead>
					<tr>
						<th data-type="number">ID</th>
						<th>License plate number</th>
						<th>Car model</th>
						<th>Fare Type</th>
						<th>Operator</th>
						<th data-type="numeric">Money</th>
						<th data-breakpoints="xs md" data-type="date"
							data-format-string="YYYY-MM-DD">Time</th>
						<th data-breakpoints="xs md sm">Company</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="fare" items="${fare}">
						<tr>
							<td>${fare.id}</td>
							<td>${fare.car.plateNumber}</td>
							<td>${fare.car.carType}</td>
							<td>${fare.type}</td>
							<td>${fare.operator}</td>
							<td>${fare.expense}</td>
							<td>${fare.date}</td>
							<td>${fare.car.company.name}</td>
						</tr>
					</c:forEach>
				</tbody>
				<!--  分页 -->
			</table>
			<form class="form-inline">
				<input type="button" class="btn btn-default" value="First"
					id="First" onclick="pageGo(${page},${totalPage},'first')" /> <input
					type="button" class="btn btn-default" value="Final" id="Final"
					onclick="pageGo(${page},${totalPage},'final')" /> <label>No.</label><input
					id="currentPage" class="form-control" class="" value="${page}"
					onkeypress="if(event.keyCode==13)pageGo(${page},${totalPage},'go')" />
				<label>/${totalPage}IN TOTAL</label> <input type="button"
					class="btn btn-default" id="go" value="Go"
					onclick="pageGo(${page},${totalPage},'go')" /> <input
					type="button" class="btn btn-default" id="pre" value="Previous"
					onclick="pageGo(${page},${totalPage},'pre')" /> <input
					type="button" class="btn btn-default" id="next" value="Next"
					onclick="pageGo(${page},${totalPage},'next')" />
			</form>
		</div>
		<div class="row col-md-2">
		<div class="spacer"></div>
		</div>
		
		<div class="my-space"></div>
	<div class="my-space"></div>
	<div class="my-space"></div>
		
	</div>
	
	<jsp:include page="../basic/footer.jsp" flush="true" />

</body>
</html>