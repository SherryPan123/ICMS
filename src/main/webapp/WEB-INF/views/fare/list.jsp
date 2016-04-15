<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html>
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
<script type="text/javascript" src="${context}/js/fare/list.js" ></script>
<script type="text/javascript" src="${context}/js/fare/add.js" ></script>
<script type="text/javascript" src="${context}/js/fare/update.js"> </script>
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
			<div style="width: 100%; text-align: right">
				<!-- edit&watch&add -->
				<div class="edit_watch_add">
					<c:if test="${currentUser.getUsername()!='ICMS' }">
						<a href="list?name=${name}&isEdit=1&page=${page}">
							<span class="glyphicon glyphicon-pencil" aria-hidden="true" style="margin-right: 5px"></span>
							Edit
						</a>
						<span style="margin-right: 5px"></span>
						<a href="list?name=${name}&isEdit=0&page=${page}">
							<span class="glyphicon glyphicon-eye-open" aria-hidden="true" style="margin-right: 5px"></span>
							Watch
						</a>
						<!-- 添加 -->
						<noscript>
							<span style="margin-right: 5px"> <a class="blueColor"
								style="color: #337AB7; cursor: pointer"
								href="<c:url value='add?pageStatus=${status}&isEdit=${isEdit}&company_id=${company_id}'/>"><span
									class="glyphicon glyphicon-plus" aria-hidden="true"
									style="margin-right: 5px"></span>Add</a>
							</span>
						</noscript>
						<span style="margin-right: 5px"></span>
						<a href="javascript:void(0);" id="addButton" class="nav-icon " style="color: #337AB7; cursor: pointer">
							<span class="glyphicon glyphicon-plus" aria-hidden="true" style="margin-right: 5px"></span>
							Add
						</a>
						<noscript>
							<a class="blueColor" href="<c:url value='add'/>">Add</a>
						</noscript>
					</c:if>
				</div>
			</div>
			<!-- 导航栏  -->
			<ol class="breadcrumb">
				<li><a href="${context}">Home</a></li>
				<li><a href="${context}/fare/list?companyId=${companyId}">Fare</a></li>
				<li class="active">${company_name}</li>
			</ol>
			
			<!-- 过滤器 -->
			<div style="margin-bottom:65px">
				<form id="searchForm" name="searchForm" method="GET" class="form-inline">
					<div class="col-lg-2" style="padding-left:2px; padding-right:10px">
						<div class="input-group">
							<input type="text" id="searchPlateNumber" class="form-control" value="${searchPlateNumber}" name="searchPlateNumber" placeholder="Plate Number" />  
						</div>
					</div>
					<div class="col-lg-2" style="padding-left:6px; padding-right: 0px">
						<div class="input-group">
							<input type="text" id = "searchType" class="form-control" value="${searchType}" name="searchType" placeholder="Car Model" />  
						</div>
					</div>
					<div class="col-lg-4" style="padding-left:30px; padding-right:0px">
						<div class="input-group">
							 <span class="input-group-addon" id="basic-addon3" style="border-top-right-radius: 0; border-bottom-right-radius: 0;">From</span>
							 <fmt:formatDate value="${startTime}" pattern="yyyy-MM-dd" var="FormatedStartTime"/>
							 <input type="date" id="startTime" name="startTime" value="${FormatedStartTime}" class="form-control" style="border-top-left-radius: 0; border-bottom-left-radius: 0;" />
						</div>
					</div>
					<div class="col-lg-3" style="padding-left:0px; padding-right:2px">
						<div class="input-group">
							<span class="input-group-addon" id="basic-addon3" style="border-top-right-radius: 0; border-bottom-right-radius: 0;">To</span>
							<fmt:formatDate value="${endTime}" pattern="yyyy-MM-dd" var="FormatedEndTime"/>
							<input type="date" id="endTime" name="endTime"  value="${FormatedEndTime}" class="form-control" style="border-top-left-radius: 0; border-bottom-left-radius: 0;" />	
						</div>
					</div>
					<div class="col-lg-1">
						<button type="submit" class="btn btn-default" aria-label="Search" title="Search">
							<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
						</button>
					</div>
					<input id="isEdit" value="${isEdit}" type="hidden">
				</form>
			</div><!-- 过滤器结束 -->
			<table id="farelist" class="table table-striped" data-sorting="true">
				<thead>
					<tr>
						<th>Plate Number</th>
						<th>Car Model</th>
						<th>Fare Type</th>
						<th>Operator</th>
						<th data-type="numeric" >Expense</th>
						<th data-breakpoints="xs md" data-type="date"
							data-format-string="YYYY-MM-DD">Time</th>
						<th data-breakpoints="xs md sm">Company</th>
						<c:if test="${companyId!=1 && isEdit==1}">
						<th data-type="html" data-sortable="false">Operation</th>
						</c:if>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="fareList" items="${fareList}">
						<tr>	
							<td>${fareList.car.plateNumber}</td>
							<td>${fareList.car.carType}</td>
							<td>${fareList.type}</td>
							<td>${fareList.operator}</td>
							<td>${fareList.expense}</td>
							<td>${fareList.date}</td>
							<td>${fareList.car.company.name}</td>
							<c:if test="${companyId!=1 && isEdit==1}">
							<td>
								<span style="margin-right:10px"></span>
								<a title="Update" onclick="updateFarePop(${fareList.id})" class="blackColor focus_not_underline" style="cursor: pointer">
									<span class="glyphicon glyphicon-edit blackColor" aria-hidden="true"></span>
								</a>
							<noscript>
								<a href="update?id=${fareList.id}">
									<button type="button" class="btn-link blackColor btn-default"
										aria-label="Update">
										<span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
									</button>
								</a>
							</noscript>
							<span style="margin-right:15px"></span>
							<a href="delete?id=${fareList.id}" onClick="return confirm('Confirm Delete?')" title="Delete" aria-label="Delete" style="cursor:pointer" class="blackColor focus_not_underline">
								<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
							</a>
							</td>
							</c:if>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- 分页 -->
			<div style="width: 100%; text-align: center">
			<nav>
				<ul class="pagination">
					<li>
						<a href="?page=1" aria-label="First">
							<span aria-hidden="true">&laquo;</span>
						</a>
					</li>
					<c:if test="${totalPage<5||totalPage==5}">
						<c:forEach var="i" begin="1" end="${page-1}" step="1">
							<li><a href="?page=${i}">${i}</a></li>
						</c:forEach>
						<li class="active"><a href="#">${page}</a></li>
						<c:forEach var="i" begin="${page+1}" end="${totalPage}" step="1">
							<li><a href="?page=${i}">${i}</a></li>
						</c:forEach>
					</c:if>
					<c:if test="${totalPage>5}">
						<c:if test="${page<3 || page==3}">
							<c:forEach var="i" begin="1" end="${page-1}" step="1">
								<li><a href="?page=${i}">${i}</a></li>
							</c:forEach>
							<li class="active"><a href="#">${page}</a></li>
							<c:forEach var="i" begin="${page+1}" end="5" step="1">
								<li><a href="?page=${i}">${i}</a></li>
							</c:forEach>
						</c:if>
						<c:if test="${page>3}">
							<c:if test="${totalPage-page<2}">
								<c:forEach var="i" begin="${totalPage-4}" end="${page-1}" step="1">
									<li><a href="?page=${i}">${i}</a></li>
								</c:forEach>
								<li class="active"><a href="#">${page}</a></li>
								<c:forEach var="i" begin="${page+1}" end="${totalPage}" step="1">
									<li><a href="?page=${i}">${i}</a></li>
								</c:forEach>
							</c:if>
							<c:if test="${totalPage-page>2 || totalPage-page==2}">
								<c:forEach var="i" begin="${page-2}" end="${page-1}" step="1">
									<li><a href="?page=${i}">${i}</a></li>
								</c:forEach>
								<li class="active"><a href="#">${page}</a></li>
								<c:forEach var="i" begin="${page+1}" end="${page+2}" step="1">
									<li><a href="?page=${i}">${i}</a></li>
								</c:forEach>
							</c:if>
						</c:if>
					</c:if>	
					<li>
   					   <a href="?page=${totalPage}" aria-label="Next">
       						<span aria-hidden="true">&raquo;</span>
    				   </a>
    				</li>
				</ul>
			</nav>
			</div>
		</div>
		<div class="row col-md-2">
			<div class="spacer"></div>
		</div>
	</div>
	
	<!-- Add 弹窗 -->
	<div id="addFare" class="modal fade" tabindex="-1" role="dialog"
		aria-labelledby="myAddLabel">
		<div class="modal-dialog" style="width: 500px" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title text-center" id="myAddLabel">Add New
						Fare</h4>
				</div>
				<div class="modal-body">				
					<span id="addErrorMsg"></span>	
					<div class="form-horizontal form_pop">
					<form:form id = "addFareForm" method = "post" modelAttribute="fare" onsubmit="return add();">						
						<form:input id="companyId" path="car.company.id" value="${companyId}" type="hidden" />	
							<span id="addErrorMsg"></span>
							<div class="form-group">
								<form:input path="car.id" id = "carId" type = "hidden" />		
								<label class="col-sm-5 control-label">PlateNumber<font class="requereStar">*</font></label>
								<div class="col-sm-7">
									<form:input id="plateNumber" cssClass="form-control" name="plateNumber" path="car.plateNumber" onchange="checkPlateNumber()" />
									<span id="plateNumber_result"></span>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-5 control-label">Type</label>
								<div class="col-sm-7">
									<form:select path="type" id="type" name="type" cssClass="form-control">
										<form:option value="违章罚款">违章罚款</form:option>
										<form:option value="加油">加油</form:option>
										<form:option value="维修">维修</form:option>
										<form:option value="保养">保养</form:option>
									</form:select>		
								</div>	
							</div>
							<div class="form-group">
								<label class="col-sm-5 control-label">Expense<font class="requereStar">*</font></label>
								<div class="col-sm-7">
									<form:input cssClass="form-control" id="expense" path="expense" name="expense" step="0.01" type="number" onchange="checkExpense()"/>						
									<span id="expense_result"></span>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-5 control-label">Operator<font class="requereStar">*</font></label>
								<div class="col-sm-7">
									<form:input cssClass="form-control" id="operator" name="operator" path="operator" onchange="checkOperator()" />
									<span id="operator_result"></span>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-5 control-label">Date<font class="requereStar">*</font></label>
								<div class="col-sm-7">
									<form:input cssClass="form-control" id="date" name="date" type="date" path="date" placeholder="date" onchange="checkDate()" />
									<span id ="date_result"></span>
								</div>
							</div>
							
							<div class="form-group">
								<div class="col-sm-offset-3 col-sm-9">
									<input type="submit" value="Submit"
										class="btn btn-success width100" id="submit" disabled/> <span
										style="margin-right: 22px"></span> <input type="reset"
										value="Reset" class="btn btn-success width100" id="reset" />
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
	<!-- Update 弹窗 -->
	<div class="modal fade" id="updateFareDiv" tabindex="-1" role="dialog"
	aria-labelledby="myFareUpdateLabel">
		<div class="modal-dialog" style="width: 500px" role="document">
			<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
				<div class="modal-body">
					<div class="form-horizontal form_pop">
						<form:form method="post" modelAttribute="fare" 
							id="updateFareForm" onsubmit="return update();">
							<form:input path="id" type="hidden" id="u_id" />
							<span id="u_addErrorMsg"></span>
							<div class="form-group">
								<label class="col-sm-5 control-label" style="padding-top: 0px;">Plate Number</label>
								<div class="col-sm-7" >
									<span id="u_plateNumber"></span>
								</div>	
							</div>
							<div class="form-group">
								<label class="col-sm-5 control-label">Car Type</label>
								<div class="col-sm-7">
									<span id="u_carType"></span>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-5 control-label">Fare Type</label>
									<div class="col-sm-7" style="padding-top:7px">
									<span>
									<form:select id="u_fareType" path="type" cssClass="form-control" >
									<form:option value="违章罚款"></form:option>
									<form:option value="加油">加油</form:option>
									<form:option value="维修">维修</form:option>
									<form:option value="保养">保养</form:option>
									</form:select>
									</span>
									</div>
							</div>
							<div class="form-group">
								<label class="col-sm-5 control-label">Operator<font class="requereStar">*</font></label>
								<div class="col-sm-7" style="paddingtop:7px">
									<span><form:input path="operator" id="u_operator" 
										placeholder="${operator}" cssClass="form-control" onchange="u_checkOperator()"/>
									</span>
									<span id="u_operator_result"></span>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-5 control-label">Expense<font class="requereStar">*</font></label>
								<div class="col-sm-7" style="paddingtop:7px">
									<span>
									<form:input path="expense" id="u_expense" type = "number" step="0.01" placeholder="${expense}" cssClass="form-control" onchange="u_checkExpense()"/>
									</span>
									<span id="u_expense_result"></span>
								</div>
							</div>
							<div class="form-group"> 
								<label class="col-sm-5 control-label">Time<font class="requereStar">*</font></label>
								<div class="col-sm-7" style="paddingtop:7px">
									<span>
									<form:input type="date" path="date" id="u_date" palceholder="${date}" cssClass="form-control" onchange="u_checkDate()" />
									</span>
									<span id=u_date_result></span>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-5 control-label">Company</label>
								<div class="col-sm-7" style="padding-top:7px">
									<span id="u_company"></span>
								</div>	
							</div>
							<div class="form-group col-sm-12"style="padding-top:7px">
							</div>
							<div class="form-group">
								<div class="col-sm-offset-3 col-sm-9">
									<input type="submit" value="Submit"
										class="btn btn-success width100" id="u_submit" /> <span
										style="margin-right: 22px"></span> <input type="reset"
										value="Reset" class="btn btn-success width100" id="u_reset" />
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