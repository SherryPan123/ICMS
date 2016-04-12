<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../basic/include.jsp" flush="true" />
<jsp:include page="../basic/table.jsp" flush="true" />
<link href="${context}/css/table.css" rel="stylesheet" type="text/css" />
<title>employee view - ICMS</title>
<script src="${context}/js/employee.js"></script>
</head>
<body>
	<jsp:include page="../basic/header.jsp" flush="true" />
	<div class="container-fluid container-height">
		<div class="spacer"></div>
		<div class="spacer"></div>
		<div class="row col-md-2">
			<div class="spacer"></div>
		</div>
		<div class="row col-md-9">
			<div>
				<!-- edit&watch&add -->
				<div class="edit_watch" style="float:right; margin-top: 15px; margin-right:10px; margin-left: 20px;">
					<a href="?id=${employee.id}&isEdit=1"><span class="glyphicon glyphicon-pencil" style="margin-right: 5px"></span>edit</a>
					<span style="margin-right:5px"></span>
					<a href="?id=${employee.id}&isEdit=0"><span class="glyphicon glyphicon-eye-open" style="margin-right: 5px"></span>watch</a>
				</div>
				<h2 style="text-align: left;">${employee.name}</h2>
			</div>
			<hr >
			<div style="margin-bottom: 30px">
				<h4 style="color: #337ab7; font-weight: 500;">>>>Basic Information</h4>
				<div class="card" style="width:300px; margin-left:auto; margin-right:auto">
					<c:if test="${isEdit==0}">
						<div><div style="width: 100px; float:left">Employee Id:</div> <span>${employee.employeeId}</span></div>
						<div><div style="width: 100px; float:left">Sex:</div> <span>${employee.sex}</span></div>
						<div><div style="width: 100px; float:left">Phone:</div> ${employee.phone}</div>
						<div><div style="width: 100px; float:left">Email:</div> ${employee.email}</div>
					</c:if>
					<c:if test="${isEdit==1}">
						<form:form modelAttribute="employee" action="update.html" method = "POST" style="text-align:center">
							<form:input id="companyId" path="company.id" type="hidden" />
							<form:input path="id" type="hidden" />
							<table>
								<tr>
									<td>Employee Id:</td>
									<td><form:input path="employeeId" cssClass="input-text" /></td>
									<td><form:errors path="employeeId" cssClass="field-error" /></td>
								</tr>
								<tr>
									<td>Name:</td>
									<td><form:input path="name" /></td>
									<td><form:errors path="name" cssClass="field-error" /></td>
								</tr>
								<tr>
									<td>Sex:</td>
									<td><form:radiobutton path="sex" value="M"/>Male</td>
									<td><form:radiobutton path="sex" value="F"/>Female</td>
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
					</c:if>
				</div>
			</div>
			<div style="margin-bottom: 50px">
				<h4 style="color: #337ab7; font-weight: 500;">>>>Conditions</h4>
				<!-- 表格 -->
				<table id="employee_conditionsList" class="table table-striped" data-sorting="true" data-filtering="true">
					<thead>
		                <tr>
		                    <th data-sort-initial="true">Plate Number</th>
		                    <th>Car Model</th>
		                    <th>Status</th>
		                    <th data-breakpoints="xs md" data-type="date"
								data-format-string="YYYY-MM-DD">Lending Time</th>
		                    <th data-breakpoints="xs md" data-type="date"
								data-format-string="YYYY-MM-DD">Returning Time</th>
		                    <th>Driver</th>
		                </tr>
		            </thead>
		            <tbody>
			            <c:forEach var="conditions" items="${conditionsList}">
			                <tr>
			                    <td>${conditions.car.plateNumber}</td>
			                    <td>${conditions.car.carType}</td>
			                    <td>
			                    <c:if test="${conditions.car.status==1}">available</c:if>
			                    <c:if test="${conditions.car.status==0 || conditions.car.status==2}">not available</c:if>
			                    </td>
			                    <td><fmt:formatDate value="${conditions.lendTime}" pattern="yyyy-MM-dd" /></td>
			                    <td><fmt:formatDate value="${conditions.returnTime}" pattern="yyyy-MM-dd" /></td>
			                    <td>${conditions.employee.name}</td>
			                </tr>
			        	</c:forEach>
		        	</tbody>
		        </table><!-- 表格结束 -->
			</div>

	        <div style="margin-bottom: 40px">
	        	<h4 style="color: #337ab7; font-weight: 500;">>>>Accident</h4>
		        <!-- 表格 -->
				<table id="employee_accidentList" class="table table-striped" data-sorting="true" data-filtering="true">
					<thead>
				<tr>
					<th data-type="number">Driver Id</th>
					<th>Plate Number</th>
					<th>Car model</th>
					<th data-breakpoints="xs md" data-type="date"
							data-format-string="YYYY-MM-DD">Time</th>
					<th data-breakpoints="xs md sm">Company</th>
					<th data-breakpoints="xs md sm">Description</th>
					<th>Driver</th>
					<c:if test="${companyId!=1 && isEdit==1}">
						<th data-type="html" data-sortable="false">Update</th>
						<th data-type="html" data-sortable="false">Delete</th>
					</c:if>
					
				</tr>
				</thead>
					<tbody>
					<c:forEach var="accidentList" items="${accidentList}">
					<tr>
					<td>${accidentList.driver.id}</td>					
					<td>${accidentList.car.plateNumber}</td>
					<td>${accidentList.car.carType}</td>
					<td>${accidentList.date}</td>
					<td>${accidentList.driver.company.name}</td>
					<td>${accidentList.description}</td>
					<td>${accidentList.driver.name}</td>
					<c:if test="${companyId!=1 && isEdit==1}">
						<td><a href="update?id=${accidentList.id}">update</a></td>
						<td><a href="delete?id=${accidentList.id}">delete</a></td>
					</c:if>
					</tr>
					</c:forEach>
				</tbody>
		        </table><!-- 表格结束 -->
		    </div>
		</div><!-- col-mod-9结束 -->
	    <div class="row col-md-2">
			<div class="spacer"></div>
		</div> 
	</div>
	<jsp:include page="../basic/footer.jsp" flush="true" />
</body>
</html>