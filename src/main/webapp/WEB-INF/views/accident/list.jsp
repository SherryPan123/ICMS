<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>accident list</title>
<meta name="viewport"
	content="width = device-width, initial-scale = 1.0, minimum-scale = 1.0, maximum-scale = 1.0, user-scalable = no" />
<jsp:include page="../basic/include.jsp" flush="true" />
<jsp:include page="../basic/table.jsp" flush="true" />
<link href="${context}/css/table.css" rel="stylesheet" type="text/css" />
</head>
<script type="text/javascript" src="${context}/js/accident/list.js" /></script>

<body>
	<jsp:include page="../basic/header.jsp" flush="true" />
	<div class="spacer"></div>
	<div class="spacer"></div>
	<div class="spacer"></div>
	<div class="spacer"></div>
	<div class="spacer"></div>
	<div class="container-fluid container-height">
		<div class="row col-md-2">
			<div class="spacer"></div>
		</div>	
		
		<div class="row col-md-9">
			<c:if test="${companyId != 1}">
			<a href="/icms/accident/add"><input type="button" value="Add"></a>
			</c:if>
			<c:if test="${companyId!=1 && isEdit==0}">
				<a href="list?isEdit=1"><input type="button" value="Edit"></a>
			</c:if>
			<c:if test="${companyId!=1 && isEdit==1}">
				<a href="list?isEdit=0"><input type="button" value="Compelet Edit"></a>
			</c:if>
			<form  id="searchForm" name="searchForm" method="GET">
			<div>
			<label for="plateNumber">plateNumber</label>
			<input type="text" id = "plateNumber" value="${plateNumber}" name="plateNumber" placeholder="PlateNumber" />  
			</div>
			<div>
			<label for="employeeId">Employee Id</label>
			<input type="text" id = "employeeId" value="${employeeId}" name="employeeId" placeholder="employee id" />  
			</div>
			<div>
			<label for="startTime">From</label>
			<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="FormattedDate" />
			<input type="date" id="startTime"  name="startTime" value="${startTime}"/>
			</div>
			<div>
			<label for="endTime">To</label>
			<input type="date" id="endTime" name="endTime"  value="${endTime}"/>
			</div>
			<div>
			<button type="submit">Search</button>
			<button type="reset">Reset</button>
			</div>
		</form>		
		
			<table id = "accidentlist" class = "table table-striped" data-filtering="true" data-sorting="true">
				<thead>
				<tr>
					<th data-type="number">Driver Id</th>
					<th>Driver</th>
					<th>Plate Number</th>
					<th>Car model</th>
					<th data-breakpoints="xs md" data-type="date"
							data-format-string="YYYY-MM-DD">Time</th>
					<th data-breakpoints="xs md sm">Company</th>
					<th data-breakpoints="xs md sm">Description</th>
					<c:if test="${companyId!=1 && isEdit==1}">
						<th data-type="html" data-sortable="false">Update</th>
						<th data-type="html" data-sortable="false">Delete</th>
					</c:if>
				</tr>
				</thead>
					<tbody>
					<c:forEach var="accident" items="${accident}">
					<tr>
					<td>${accident.driver.id}</td>
					<td>${accident.driver.name}</td>
					<td>${accident.car.plateNumber}</td>
					<td>${accident.car.carType}</td>
					<td>${accident.date}</td>
					<td>${accident.driver.company.name}</td>
					<td>${accident.description}</td>
					<c:if test="${companyId!=1 && isEdit==1}">
						<td><a href="update?id=${accident.id}">update</a></td>
						<td><a href="delete?id=${accident.id}">delete</a></td>
					</c:if>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
		</div>
		<div class="row col-md-2">
			<div class="spacer"></div>
		</div>
	<div class="my-space"></div>
	<div class="my-space"></div>
	<div class="my-space"></div>
	<jsp:include page="../basic/footer.jsp" flush="true" />

</body>
</html>