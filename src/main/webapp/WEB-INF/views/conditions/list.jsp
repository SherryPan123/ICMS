<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<title>conditions list - ICMS</title>
<meta name="viewport"
	content="width = device-width, initial-scale = 1.0, minimum-scale = 1.0, maximum-scale = 1.0, user-scalable = no" />
<jsp:include page="../basic/include.jsp" flush="true" />
<jsp:include page="../basic/table.jsp" flush="true" />
<link href="${context}/css/table.css" rel="stylesheet" type="text/css" />
<script src="${context}/js/conditions.js"></script>
<%
	Date now = new Date(System.currentTimeMillis());
	request.setAttribute("now",now);
%>
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
				<a href="?page=${page}&max=${max}&companyId=${companyId}&car=${car}&employee=${employee}&lendTime=<fmt:formatDate value="${lendTime}" pattern="yyyy-MM-dd" />&returnTime=<fmt:formatDate value="${returnTime}" pattern="yyyy-MM-dd" />&isEdit=1"><span class="glyphicon glyphicon-pencil" style="margin-right: 5px"></span>Edit</a>
				<span style="margin-right:5px"></span>
				<a href="?page=${page}&max=${max}&companyId=${companyId}&car=${car}&employee=${employee}&lendTime=<fmt:formatDate value="${lendTime}" pattern="yyyy-MM-dd" />&returnTime=<fmt:formatDate value="${lendTime}" pattern="yyyy-MM-dd" />&isEdit=0"><span class="glyphicon glyphicon-eye-open" style="margin-right: 5px"></span>Watch</a>
				<span style="margin-right:5px"></span>
				<a id="btnAdd" style="color:#337AB7; cursor:pointer"><span class="glyphicon glyphicon-plus" style="margin-right: 5px"></span>Add</a>
			</div>
			<!-- 导航栏 -->
			<ol class="breadcrumb">
			  <li><a href="${context}">Home</a></li>
			  <li><a href="${context}/conditions/list?companyId=${companyId}">Conditions</a></li>
			  <li class="active">${companyName}</li>
			</ol>
			<!-- 过滤器 -->
			<div style="margin-bottom:65px">
				<form id="_pageForm" name="_pageForm" method="GET" class="form-inline">
					<input type="hidden" id="companyId" name="companyId" value="${companyId}"/>
					<div class="col-lg-2" style="padding-left:2px; padding-right:10px">
						<div class="input-group">
							<input type="text" id="car" class="form-control" name="car" value="${car}" placeholder="car information"/>
						</div>
					</div>
					<div class="col-lg-2" style="padding-left:6px; padding-right: 0px">
						<div class="input-group">
							<input type="text" id="employee" class="form-control" name="employee" value="${employee}" placeholder="dirver information"/>	
						</div>
					</div>
					<div class="col-lg-4" style="padding-left:30px; padding-right:0px">
						<div class="input-group">
							<fmt:formatDate value="${lendTime}" pattern="yyyy-MM-dd" var="FormattedDate" />
							<span class="input-group-addon" id="basic-addon3" style="border-top-right-radius: 0; border-bottom-right-radius: 0;">From</span>
							<input type="date" id="lendTime" class="form-control" name="lendTime" value="${FormattedDate}" style="border-top-left-radius: 0; border-bottom-left-radius: 0;" />
						</div>
					</div>
					<div class="col-lg-3" style="padding-left:0px; padding-right:2px">
						<div class="input-group">
							<fmt:formatDate value="${returnTime}" pattern="yyyy-MM-dd" var="FormattedDate" />
							<span class="input-group-addon" id="basic-addon3" style="border-top-right-radius: 0; border-bottom-right-radius: 0;">To</span>
							<input type="date" id="returnTime" class="form-control" name="returnTime" value="${FormattedDate}" style="border-top-left-radius: 0; border-bottom-left-radius: 0;" />	
						</div>
					</div>
					<div class="col-lg-1">
						<button type="submit" class="btn btn-default" aria-label="Search" title="Search">
							<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
						</button>
					</div>
				</form>
			</div><!-- 过滤器结束 -->
			
			<!-- 表格 -->
			<table id="conditionsList" class="table table-striped" data-sorting="true">
				<thead>
					<tr>
						<th>Plate Number</th>
						<th>Car Model</th>
	                    <th data-breakpoints="xs md" data-type="date"
							data-format-string="YYYY-MM-DD">Lending Time</th>
	                    <th data-breakpoints="xs md" >Returning Time</th>
	                    <th>Driver</th>
	                    <th data-type="html">Status</th>
	                    <c:if test="${isEdit==1}">
	                    <th data-type="html">Operation</th>
	                    </c:if>
	                </tr>
	            </thead>
	            <tbody>
		            <c:forEach var="conditions" items="${conditionsList}">
		                <tr>
		                    <td><a href="#">${conditions.car.plateNumber}</a></td>
		                    <td>${conditions.car.carType}</td>
		                    <td><fmt:formatDate value="${conditions.lendTime}" pattern="yyyy-MM-dd" /></td>
			                <c:if test="${empty conditions.returnTime}"><td></td>
			                </c:if>
			                <c:if test="${!(empty conditions.returnTime)}">
			                	<td><fmt:formatDate value="${conditions.returnTime}" pattern="yyyy-MM-dd" /></td>
			                </c:if>
		                    <td>${conditions.employee.name}</td>
		                    <td>
		                    <c:if test="${empty conditions.returnTime}">
		                    	&nbsp;&nbsp;&nbsp;&nbsp;<span class="redColor glyphicon glyphicon-minus" title="running" aria-hidden="true"></span>
		                    </c:if>
		                    <c:if test="${not empty conditions.returnTime}">
								&nbsp;&nbsp;&nbsp;&nbsp;<span class="greenColor glyphicon glyphicon-ok" title="ending" aria-hidden="true"></span>
							</c:if>
		                    </td>
		                    <c:if test="${isEdit==1}">
		                    	<c:if test="${empty conditions.returnTime}">
								<td>
									<span style="margin-right:10px"></span>
									<a title="Return" onclick="update_conditions_pop(${conditions.id})" style="cursor:pointer" class="blackColor focus_not_underline">
										<span class="glyphicon glyphicon-share-alt" aria-hidden="true"></span>
									</a>
									<span style="margin-right:15px"></span>
									<a href="${context}/conditions/delete?id=${conditions.id}" onClick="return confirm('Confirm Delete?')" title="Delete" aria-label="Delete" style="cursor:pointer" class="blackColor focus_not_underline">
										<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									</a>
<%-- 									<a href="${context}/conditions/delete?id=${conditions.id}" onClick="return confirm('Confirm Delete?')">delete</a> --%>
<%-- 									<a href="${context}/conditions/update?id=${conditions.id}">update</a> --%>
								</td>
								</c:if>
								<c:if test="${not empty conditions.returnTime}">
								<td>
									<span style="margin-right:25px"></span>
									<a href="${context}/conditions/delete?id=${conditions.id}" onClick="return confirm('Confirm Delete?')" title="Delete" aria-label="Delete" style="cursor:pointer" class="blackColor focus_not_underline">
										<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									</a>
								</td>
								</c:if>
							</c:if>
		                </tr>
					</c:forEach>
		        </tbody>
	        </table><!-- 表格结束 -->
	        <!-- 分页 -->
	        <div style="width: 100%; text-align: center">
				<nav>
					<ul class="pagination">
						<li><a href="?page=1&max=${max}&companyId=${companyId}&car=${car}&employee=${employee}&lendTime=${lendTime}&returnTime=${returnTime}&isEdit=${isEdit}"
							aria-label="First"><span aria-hidden="true">&laquo;</span>
						</a></li>
						<c:if test="${totalPage<5||totalPage==5}">
							<c:forEach var="i" begin="1" end="${page-1}" step="1">
								<li><a href="?page=${i}&max=${max}&companyId=${companyId}&car=${car}&employee=${employee}&lendTime=${lendTime}&returnTime=${returnTime}&isEdit=${isEdit}">${i}</a></li>
							</c:forEach>
							<li class="active"><a href="#">${page}</a></li>
							<c:forEach var="i" begin="${page+1}" end="${totalPage}" step="1">
								<li><a href="?page=${i}&max=${max}&companyId=${companyId}&car=${car}&employee=${employee}&lendTime=${lendTime}&returnTime=${returnTime}&isEdit=${isEdit}">${i}</a></li>
							</c:forEach>
						</c:if>
						<c:if test="${totalPage>5}">
							<c:if test="${page<3 || page==3}">
								<c:forEach var="i" begin="1" end="${page-1}" step="1">
									<li><a href="?page=${i}&max=${max}&companyId=${companyId}&car=${car}&employee=${employee}&lendTime=${lendTime}&returnTime=${returnTime}&isEdit=${isEdit}">${i}</a></li>
								</c:forEach>
								<li class="active"><a href="#">${page}</a></li>
								<c:forEach var="i" begin="${page+1}" end="5" step="1">
									<li><a href="?page=${i}&max=${max}&companyId=${companyId}&car=${car}&employee=${employee}&lendTime=${lendTime}&returnTime=${returnTime}&isEdit=${isEdit}">${i}</a></li>
								</c:forEach>
							</c:if>
							<c:if test="${page>3}">
								<c:if test="${totalPage-page<2}">
									<c:forEach var="i" begin="${totalPage-4}" end="${page-1}"
										step="1">
										<li><a href="?page=${i}&max=${max}&companyId=${companyId}&car=${car}&employee=${employee}&lendTime=${lendTime}&returnTime=${returnTime}&isEdit=${isEdit}">${i}</a></li>
									</c:forEach>
									<li class="active"><a href="#">${page}</a></li>
									<c:forEach var="i" begin="${page+1}" end="${totalPage}" step="1">
										<li><a href="?page=${i}&max=${max}&companyId=${companyId}&car=${car}&employee=${employee}&lendTime=${lendTime}&returnTime=${returnTime}&isEdit=${isEdit}">${i}</a></li>
									</c:forEach>
								</c:if>
								<c:if test="${totalPage-page>2 || totalPage-page==2}">
									<c:forEach var="i" begin="${page-2}" end="${page-1}" step="1">
										<li><a href="?page=${i}&max=${max}&companyId=${companyId}&car=${car}&employee=${employee}&lendTime=${lendTime}&returnTime=${returnTime}&isEdit=${isEdit}">${i}</a></li>
									</c:forEach>
									<li class="active"><a href="#">${page}</a></li>
									<c:forEach var="i" begin="${page+1}" end="${page+2}" step="1">
										<li><a href="?page=${i}&max=${max}&companyId=${companyId}&car=${car}&employee=${employee}&lendTime=${lendTime}&returnTime=${returnTime}&isEdit=${isEdit}">${i}</a></li>
									</c:forEach>
								</c:if>
							</c:if>
						</c:if>
						<li><a href="?page=${totalPage}&max=${max}&companyId=${companyId}&car=${car}&employee=${employee}&lendTime=${lendTime}&returnTime=${returnTime}&isEdit=${isEdit}"
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

<!-- add conditions pop up -->
<div class="modal fade" id="conditionsAddForm" tabindex="-1" role="dialog"
	aria-labelledby="myConditionsAddLabel">
	<div class="modal-dialog" style="width:500px" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title text-center" id="myConditionsAddLabel">Add Conditions</h4>
			</div>
			<div class="modal-body">
				<div class="form-horizontal form_pop">
					<form:form method="post" modelAttribute="conditions" id="addConditionsForm" onsubmit="return conditions_validate();">
						<form:input id="companyId" path="company.id" type="hidden" />
							<span id="addErrorMsg"></span>
							<div class="form-group">
								<form:input id="carId" path="car.id" type="hidden" />
								<label class="col-sm-4 control-label">Plate Number<font class="requereStar">*</font></label>
								<div class="col-sm-8">
									<form:input path="car.plateNumber" id="plateNumber" cssClass="form-control" onchange="getCar()" />
							    	<div id="carType" class="row_content"></div>
							    </div>
							</div>
							<div class="form-group">
								<form:input id="employee_Id" path="employee.id" type="hidden" />
								<label class="col-sm-4 control-label">Employee Number<font class="requereStar">*</font></label>
								<div class="col-sm-8">
									<form:input path="employee.employeeId" id="employeeId" cssClass="form-control" onchange="getEmployee()" />
							    	<div id="employeeName" class="row_content"></div>
							    </div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">Lend Time</label>
								<div class="col-sm-8">
									<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="FormattedDate" />
									<span><form:input type="date" path="lendTime" cssClass="form-control" placeholder="${FormattedDate}" /></span>
							    	<form:errors path="lendTime" cssClass="field-error" />
							    </div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">Return Time</label>
								<div class="col-sm-8">
									<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="FormattedDate" />
									<span><form:input type="date" path="returnTime" cssClass="form-control" placeholder="${FormattedDate}" /></span>
							    	<form:errors path="returnTime" cssClass="field-error" />
							    </div>
							</div>
							<div class="form-group">
    							<div class="col-sm-offset-3 col-sm-9">
									<input id="submitBtn" type="submit" class="btn btn-success width100" value="Submit" />
									<span style="margin-right:22px"></span>
									<input type="reset" class="btn btn-success width100" value="Reset" />
								</div>
							</div>
					</form:form>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<!-- update conditions pop up -->
<div class="modal fade" id="conditionsUpdateForm" tabindex="-1" role="dialog"
	aria-labelledby="myConditionsUpdateLabel">
	<div class="modal-dialog" style="width:500px" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title text-center" id="myConditionsUpdateLabel">Update Conditions</h4>
			</div>
			<div class="modal-body">
				<div class="form-horizontal form_pop">
					<form:form method="post" modelAttribute="conditions" id="updateConditionsForm" onsubmit="return update_conditions_validate();">
						<form:input id="u_companyId" path="company.id" type="hidden" />
						<form:input id="u_conditionsId" path="id" type="hidden" />
						<span id="u_addErrorMsg"></span>
						<div class="form-group">
							<form:input id="u_carId" path="car.id" type="hidden" />
							<label class="col-sm-5 control-label">Car Information</label>
							<div class="col-sm-7" style="padding-top:7px">
								<span id="u_carType"></span>
								<span id="u_plateNumber"></span>
							</div>
						</div>
						<div class="form-group">
							<form:input id="u_employee_Id" path="employee.id" type="hidden" />
							<label class="col-sm-5 control-label">Employee Information</label>
							<div class="col-sm-7" style="padding-top:7px">
								<span id="u_employeeName"></span>
								<span id="u_employeeId"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-5 control-label">Lend Time</label>
							<div class="col-sm-7">
								<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="FormattedDate" />
								<span><form:input type="date" path="lendTime" id="u_lendTime" placeholder="${FormattedDate}" cssClass="form-control" /></span>
								<span><form:errors path="lendTime" cssClass="field-error" /></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-5 control-label">Return Time</label>
							<div class="col-sm-7">
								<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="FormattedDate" />
								<span><form:input type="date" path="returnTime" id="u_returnTime" placeholder="${FormattedDate}" cssClass="form-control" /></span>
								<span><form:errors path="returnTime" cssClass="field-error" /></span>
							</div>
						</div>
						<div class="form-group">
    						<div class="col-sm-offset-3 col-sm-9">
								<input id="u_submitBtn" type="submit" class="btn btn-success width100" value="Return" />
								<span style="margin-right:22px"></span>
								<input type="reset" class="btn btn-success width100" value="Reset" />
							</div>
						</div>
					</form:form>
				</div>
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