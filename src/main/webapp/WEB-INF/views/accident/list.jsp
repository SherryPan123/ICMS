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
<script type="text/javascript" src="${context}/js/accident/add.js" /></script>
</head>


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
		
		<div class="row col-md-8">
			<div style="width: 100%; text-align: right">
				<!-- Edit按钮 -->
				<c:if test="${companyId != 1}">
					<c:if test="${isEdit==0}">
						<label> <span class="glyphicon glyphicon-pencil"
							aria-hidden="true"></span>
						</label>
						<a href="list?name=${name}&isEdit=1&page=${page}">Edit</a>
					</c:if>
				</c:if>
				<!--查看按钮 -->
				<c:if test="${isEdit==1}">
					<label> <span class="glyphicon glyphicon-eye-open"
						aria-hidden="true"></span>
					</label>
					<a href="list?name=${name}&isEdit=0&page=${page}">Watch</a>
				</c:if>
				<!-- 添加按钮 -->
				<c:if test="${companyId != 1}">
					<label class="blueColor"> <span
						class="glyphicon glyphicon-plus" aria-hidden="true"></span>
					</label> <a href="javascript:void(0);" id="addButton" class="nav-icon "
						style="height: 54px;">Add</a>
					<noscript>
						<a class="blueColor" href="<c:url value='add'/>">Add</a>
					</noscript>
				</c:if>
			</div>
			<!-- 导航栏  -->
			<ol class="breadcrumb">
				<li><a href="${context}">Home</a></li>
				<li class="active">ICMS</li>
			</ol>
			
			<!-- 过滤器 -->
			<form id="searchForm" name="searchForm" method="GET" class="form-inline" style="text-align:center; margin-bottom:20px; margin-top:30px">
			<span class="glyphicon glyphicon-filter filter_span"></span>
			<span class="filter_span"></span>
			<span class="filter_span">
				<input type="text" id = "searchPlateNumber" value="${plateNumber}" name="searchPlateNumber" placeholder="PlateNumber" />  
			</span>
			<span class="filter-span">
				 <input type="text" id = "employeeId" value="${employeeId}" name="employeeId" placeholder="employee id" />  
			</span>
			<span class="filter-span">
				<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="FormattedDate" />
				<input type="date" id="startTime"  name="startTime" value="${startTime}"/>
			</span>
			<span class="filter-span">
				<input type="date" id="endTime" name="endTime"  value="${endTime}"/>
			</span>
			<span class="filter-span">
				<button type="submit">Search</button>
				<button type="reset">Reset</button>
			</span>
			</form>		
			
			<table id = "accidentlist" class = "table table-striped" data-sorting="true">
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
						<th data-type="html" data-sortable="false">Operate</th>
					</c:if>
				</tr>
				</thead>
					<tbody>
					<c:forEach var="accidentList" items="${accidentList}">
					<tr>
					<td>${accidentList.driver.id}</td>
					<td>${accidentList.driver.name}</td>
					<td>${accidentList.car.plateNumber}</td>
					<td>${accidentList.car.carType}</td>
					<td>${accidentList.date}</td>
					<td>${accidentList.driver.company.name}</td>
					<td>${accidentList.description}</td>
					<td>
						<a title="Update" onclick="updateAccidentPop(${accidentList.id})"
								style="cursor: pointer"> <span
									class="glyphicon glyphicon-edit blackColor" aria-hidden="true"></span>
						</a>
						<noscript>
							<a href="update?id=${accidentList.id}">
								<button type="button" class="btn-link blackColor btn-default"
									aria-label="Update">
									<span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
								</button>
							</a>
						</noscript>
						<span style="margin-right:25px"></span>
						<a href="delete?id=${accidentList.id}" onClick="return confirm('Confirm Delete?')" title="Delete" aria-label="Delete" style="cursor:pointer" class="blackColor focus_not_underline">
							<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
						</a>
					</td>
					</tr>
					</c:forEach>
				</tbody>
				<!--  分页 -->
			</table>
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
		</div>
		<div class="row col-md-2">
			<div class="spacer"></div>
		</div>
		</div>
	<div class="my-space"></div>
	<div class="my-space"></div>
	<div class="my-space"></div>
	
	<!-- add 弹窗 -->
	<div id="addAccident" class ="modal fade" tabindex="-1" role="dialog"
		aria-labelledby="myAddLabel">
		<div class="modal-dialog" style="width:500px" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title text-center" id="myAddLabel">Add Accident</h4>
				</div>
			<div class="modal-body">
				<span id ="addErrorMsg"></span>
<!-- 				<div class="form-horizontal form_pop"> -->
<%-- 						<form:form method="post" modelAttribute="accident"  --%>
<%-- 							id="updateAccidentForm" onsubmit="return update();"> --%>
<%-- 							<form:input path="id" type="hidden" id="u_id" /> --%>
<!-- 							<span id="u_addErrorMsg"></span> -->
<!-- 							<div class="form-group"> -->
<!-- 								<label class="col-sm-5 control-label">Driver Id</label> -->
<!-- 								<div class="col-sm-7" > -->
<!-- 									<span id="u_driverId"></span> -->
<!-- 								</div>	 -->
<!-- 							</div> -->
				<div class="form-horizontal form-pop">
				<form:form id ="addAccidentForm" method ="post" modelAttribute="accident" onsubmit="return add();">
					<form:input id = "companyId" path = "car.company.id" value="${companyId}" type = "hidden"/>
						<span id = "addErrorMsg"></span>
						<div class="form-group">
							<form:input id="carId" path="car.id" type="hidden" />
							<label class="col-sm-5 control-label">PlateNumber</label>
							<div class="col-sm-7">
								<form:input cssClass="form-control" path="car.plateNumber" id = "plateNumber" onchange="checkPlateNumber()"/>
								<span id = plateNumber_result></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-5 control-label">Driver Id</label>
							<div class="col-sm-7">
								<form:input cssClass="form-control" id="driverId" path="driver.id" onchange="checkDriverId()"/>
								<span id = "driver_result"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-5 control-label">Date</label>
							<div class="col-sm-7">
								<form:input cssClass="form-control" id="date" type="date" path="date" onchange="checkDate()"/>
								<span id = "date_result"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-5 control-label">Description</label>
							<div class="col-sm-7">
								<form:textarea cssClass="form-control" id = "description" path="description"/>
							</div>
						</div>
						<div class="form-group">
								<div class="col-sm-offset-3 col-sm-9">
									<input type="submit" value="Submit"
										class="btn btn-success width100" id="submit" /> <span
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
	
	<!-- update 弹窗 -->
	
	<div class="modal fade" id="updateFareDiv" tabindex="-1" role="dialog"
	aria-labelledby="myAccidentUpdateLabel">
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
						<form:form method="post" modelAttribute="accident" 
							id="updateAccidentForm" onsubmit="return update();">
							<form:input path="id" type="hidden" id="u_id" />
							<span id="u_addErrorMsg"></span>
							<div class="form-group">
								<label class="col-sm-5 control-label">Driver Id</label>
								<div class="col-sm-7" >
									<span id="u_driverId"></span>
								</div>	
							</div>
							<div class="form-group">
								<label class="col-sm-5 control-label">Driver</label>
								<div class="col-sm-7" >
									<span id="u_driver"></span>
								</div>	
							</div>
							<div class="form-group">
								<label class="col-sm-5 control-label">PlateNumber</label>
								<div class="col-sm-7" >
									<span id="u_plateNumber"></span>
								</div>	
							</div>
							<div class="form-group">
								<label class="col-sm-5 control-label">Car Model</label>
								<div class="col-sm-7" >
									<span id="u_carModel"></span>
								</div>	
							</div>
							<div class="form-group">
								<label class="col-sm-5 control-label">Time</label>
								<div class="col-sm-7" style="paddingtop:7px">
									<span><form:input type="date" path="date" id="u_date" 
										placeholder="${date}" cssClass="form-control"/>
									</span>
								</div>
							</div>
							<div>
								<label class="col-sm-5 control-label">Company</label>
								<div class="col-sm-7" style="padding-top:7px;padding-bottom:7px">
									<span id="u_company"></span>
								</div>	
							</div>
							<div class="form-group">
								<label class="col-sm-5 control-label">Description</label>
								<div class="col-sm-7" style="paddingtop:7px">
									<span><form:textarea path="description" id="u_description" 
										placeholder="${description}" cssClass="form-control"/>
									</span>
								</div>
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