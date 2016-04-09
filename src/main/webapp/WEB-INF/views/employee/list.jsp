<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>employee list - ICMS</title>
<meta name="viewport"
	content="width = device-width, initial-scale = 1.0, minimum-scale = 1.0, maximum-scale = 1.0, user-scalable = no" />
<jsp:include page="../basic/include.jsp" flush="true" />
<jsp:include page="../basic/table.jsp" flush="true" />
<link href="${context}/css/table.css" rel="stylesheet" type="text/css" />
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
		    <!-- edit&watch&add -->
			<div class="edit_watch_add">
				<a href="?page=${page}&max=${max}&companyId=${companyId}&employeeId=${employeeId}&name=${name}&isEdit=1"><span class="glyphicon glyphicon-pencil" style="margin-right: 5px"></span>edit</a>
				<span style="margin-right:5px"></span>
				<a href="?page=${page}&max=${max}&companyId=${companyId}&employeeId=${employeeId}&name=${name}&isEdit=0"><span class="glyphicon glyphicon-eye-open" style="margin-right: 5px"></span>watch</a>
				<span style="margin-right:5px"></span>
				<a id="btnAdd" style="color:#337AB7; cursor:pointer"><span class="glyphicon glyphicon-plus" style="margin-right: 5px"></span>Add</a>
			</div>
			<!-- 导航栏 -->
			<ol class="breadcrumb">
			  <li><a href="${context}">Home</a></li>
			  <li><a href="${context}/employee/list?companyId=${companyId}">Employee</a></li>
			  <li class="active">${companyName}</li>
			</ol>
			<!-- 过滤器 -->
			<form id="_pageForm" name="_pageForm" method="GET" class="form-inline" style="text-align:center; margin-bottom:20px; margin-top:30px">
				<input type="hidden" id="companyId" name="companyId" value="${companyId}"/>
				<span class="glyphicon glyphicon-filter filter_span"></span>
				<span class="filter_span"></span>
				<span class="filter_span">
					<input type="text" id="employeeId" name="employeeId" value="${employeeId}" placeholder="employee Id"/>
				</span>
				<span class="filter_span">
					<input type="text" id="name" name="name" value="${name}" placeholder="employee name"/>
				</span>
				<span class="filter_span">
					<input type="submit" value="find"/>
					<span class="filter_span"></span>
					<input type="reset" value="reset"/>
				</span>
			</form><!-- 过滤器结束 -->
			<!-- 表格 -->
			<table id="employeeList" class="table table-striped" data-sorting="true">
				<thead>
					<tr>
						<th data-sort-initial="true" data-type="html">Employee Id</th>
	                    <th>Name</th>
	                    <th>Sex</th>
	                    <th data-breakpoints="xs md">Phone</th>
	                    <th data-breakpoints="xs md" >Email</th>
	                    <th>Company</th>
	                </tr>
	            </thead>
	            <tbody>
					<c:forEach var="employee" items="${employeeList}">
		                <tr>
		                    <td><a href="${context}/employee/view?id=${employee.id}">${employee.employeeId}</a></td>
		                    <td>${employee.name}</td>
		                    <td>${employee.sex}</td>
		                    <td>${employee.phone}</td>
		                    <td>${employee.email}</td>
		                    <td>${employee.company.name}</td>
		                </tr>
					</c:forEach>
		        </tbody>
	        </table><!-- 表格结束 -->
	        <!-- 分页 -->
	        <div style="width: 100%; text-align: center">
				<nav>
					<ul class="pagination">
						<li><a href="?page=1&max=${max}&companyId=${companyId}&employeeId=${employeeId}&name=${name}&isEdit=${isEdit}"
							aria-label="First"><span aria-hidden="true">&laquo;</span>
						</a></li>
						<c:if test="${totalPage<5||totalPage==5}">
							<c:forEach var="i" begin="1" end="${page-1}" step="1">
								<li><a href="?page=${i}&max=${max}&companyId=${companyId}&employeeId=${employeeId}&name=${name}&isEdit=${isEdit}">${i}</a></li>
							</c:forEach>
							<li class="active"><a href="#">${page}</a></li>
							<c:forEach var="i" begin="${page+1}" end="${totalPage}" step="1">
								<li><a href="?page=${i}&max=${max}&companyId=${companyId}&employeeId=${employeeId}&name=${name}&isEdit=${isEdit}">${i}</a></li>
							</c:forEach>
						</c:if>
						<c:if test="${totalPage>5}">
							<c:if test="${page<3 || page==3}">
								<c:forEach var="i" begin="1" end="${page-1}" step="1">
									<li><a href="?page=${i}&max=${max}&companyId=${companyId}&employeeId=${employeeId}&name=${name}&isEdit=${isEdit}">${i}</a></li>
								</c:forEach>
								<li class="active"><a href="#">${page}</a></li>
								<c:forEach var="i" begin="${page+1}" end="5" step="1">
									<li><a href="?page=${i}&max=${max}&companyId=${companyId}&employeeId=${employeeId}&name=${name}&isEdit=${isEdit}">${i}</a></li>
								</c:forEach>
							</c:if>
							<c:if test="${page>3}">
								<c:if test="${totalPage-page<2}">
									<c:forEach var="i" begin="${totalPage-4}" end="${page-1}"
										step="1">
										<li><a href="?page=${i}&max=${max}&companyId=${companyId}&employeeId=${employeeId}&name=${name}&isEdit=${isEdit}">${i}</a></li>
									</c:forEach>
									<li class="active"><a href="#">${page}</a></li>
									<c:forEach var="i" begin="${page+1}" end="${totalPage}" step="1">
										<li><a href="?page=${i}&max=${max}&companyId=${companyId}&employeeId=${employeeId}&name=${name}&isEdit=${isEdit}">${i}</a></li>
									</c:forEach>
								</c:if>
								<c:if test="${totalPage-page>2 || totalPage-page==2}">
									<c:forEach var="i" begin="${page-2}" end="${page-1}" step="1">
										<li><a href="?page=${i}&max=${max}&companyId=${companyId}&employeeId=${employeeId}&name=${name}&isEdit=${isEdit}">${i}</a></li>
									</c:forEach>
									<li class="active"><a href="#">${page}</a></li>
									<c:forEach var="i" begin="${page+1}" end="${page+2}" step="1">
										<li><a href="?page=${i}&max=${max}&companyId=${companyId}&employeeId=${employeeId}&name=${name}&isEdit=${isEdit}">${i}</a></li>
									</c:forEach>
								</c:if>
							</c:if>
						</c:if>
						<li><a href="?page=${totalPage}&max=${max}&companyId=${companyId}&employeeId=${employeeId}&name=${name}&isEdit=${isEdit}"
							aria-label="Next"> <span aria-hidden="true">&raquo;</span>
						</a></li>
					</ul>
				</nav>
			</div><!-- 分页结束 -->
        </div><!-- col-mod-9结束 -->
	    <div class="row col-md-2">
			<div class="spacer"></div>
		</div>
	</div>

<!-- add employee pop up -->
<div class="modal fade" id="employeeAddForm" tabindex="-1" role="dialog"
	aria-labelledby="myEmployeeAddLabel">
	<div class="modal-dialog" style="width:500px" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title text-center" id="myEmployeeAddLabel">Add Employee</h4>
			</div>
			<div class="modal-body">
				<form:form method="post" modelAttribute="employee" id="addEmployeeForm" onsubmit="return employee_validate();">
					<form:input id="companyId" path="company.id" type="hidden" />
					<table>
						<tr id="addErrorMsg"></tr>
						<tr>
							<td>Employee Id:</td>
							<td><form:input path="employeeId" cssClass="input-text" /></td>
							<td id="employeeIdInfo"></td>
						</tr>
						<tr>
							<td>Name:</td>
							<td><form:input path="name" cssClass="input-text" /></td>
							<td id="employeeNameInfo"></td>
						</tr>
						<tr>
							<td>Sex:</td>
							<td><input type="radio" name="sex" value="M" checked>Male</td>
							<td><input type="radio" name="sex" value="F">Female</td>
						</tr>
						<tr>
							<td>Phone:</td>
							<td><form:input path="phone" cssClass="input-text" /></td>
							<td><form:errors path="phone" cssClass="field-error" /></td>
						</tr>
						<tr>
							<td>Email:</td>
							<td><form:input path="email" cssClass="input-text" /></td>
							<td><form:errors path="email" cssClass="field-error" /></td>
						</tr>
						<tr>
							<td>
								<input id="submitBtn" type="submit" value="Submit" />
								<input type="reset" value="Reset" />
							</td>
						</tr>
					</table>
				</form:form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

	<jsp:include page="../basic/footer.jsp" flush="true" />
</body>
</html>