<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

</head>
<script type="text/javascript" src="${context}/js/fare/list.js"></script>
<script type="text/javascript" src="${context}/js/fare/add.js"></script>
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
		<c:if test="${companyId != 1}">
		<a href="/icms/fare/add"><input type="button" value="Add"></a>
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
			<input type="text" value="${plateNumber}" name="plateNumber" placeholder="PlateNumber" />  
			</div>
			<div>
			<label for="type">Type</label>
			<input type="text" id = "type" value="${type}" name="type" placeholder="Type" />  
			</div>
			<div>
			<label for="startTime">lend time</label>
			<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="FormattedDate" />
			<input type="date" id="startTime"  name="startTime" value="${startTime}"/>
			</div>
			<div>
			<label for="endTime">return time</label>
			<input type="date" id="endTime" name="endTime"  value="${endTime}"/>
			</div>
			<div>
			<button type="submit">Search</button>
			<button type="reset">Reset</button>
			</div>
		</form>
		</div>
		<div class="row col-md-8">
			<div class = "my-icon">
			<!-- Edit按钮 -->
			<c:if test = "${isEdit==0 }">
			<label> <span class="glyphicon glyphicon-pencil" aria-hidden="true" ></span></label>
			</c:if>
			
			<!-- 查看按钮  -->
			<c:if test = "${isEdit==0}">
			<label> <span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span></label>
			</c:if>
			
			<!-- add -->
			<label class="blueColor"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></label>
			<a class="add-icon" href="javascript:void(0);" id="addButton" class = "nav-icon">Add</a>
			<noscript>
			<a class="blueColor" href="<c:url value='add'/>">Add</a>
			</noscript>
			</div>
			
			<!-- 导航栏 -->
			<ol class="breadcrumb">
				<li><a href ="${context}">Home</a></li>
				<li class="active">ICMS</li>
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
						<c:if test="${companyId!=1 && isEdit==1}">
						<th data-type="html" data-sortable="false">Update</th>
						<th data-type="html" data-sortable="false">Delete</th>
						</c:if>
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
							<c:if test="${companyId!=1 && isEdit==1}">
							<td><a href="update?id=${fare.id}">update</a></td>
							<td><a href="delete?id=${fare.id}">delete</a></td>
							</c:if>
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
		
		<div class="row col-md-2">
		<div class="spacer"></div>
		</div>
		</div>
	<div class="my-space"></div>
	<div class="my-space"></div>
	<div class="my-space"></div>
	<jsp:include page="../basic/footer.jsp" flush="true" />
	<!--  Add 弹窗 -->
	<div id = "addFare" class="modal fade" tabindex="-1" role="dialog"
		aria-labelledby="myAddLabel">
		<div class = "modal-dialog my-dialog" role = "document">
			<div class = "modal-content">
				<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title text-center" id="addTitle">
						Add New Fare
					</h4>
				</div>
				<div class="modal-body">
				<form id = "addForm"  class="form-horizontal" method="GET" onsubmit="add()">
					<label>Type</label>
					<select id="type" name="type">
					<option value="违章罚款">违章罚款</option>
					<option value="加油">加油</option>
					<option value="维修">维修</option>
					<option value="保养">保养</option>
					</select>
					<br>
					<input id="companyId" type="hidden" value="${companyId}" readonly>
					<label>Expense</label>
					<input id="expense" name="expense" type="number" onchange="checkExpense()"><br>
					<span id="expense_result"><font color=red>The Expense can't be empty!</font><br></span>  
					<label>Operator</label>
					<input id="operator" name="operator" onchange="checkOperator()">
					<span id="operator_result"><font color=red>The Operator can't be empty!</font><br></span>
					<br>
					<label>Date</label>
					<input id="date" name="date" type="date" placeholder="date" onchange="checkDate()">
					<span id ="date_result"> <font color=red>The Date can't be empty!</font><br></span>
					<br>
					<label>PlateNumber</label>
					<input id="plateNumber" name="plateNumber" onchange="checkPlateNumber()">
					<span id="plateNumber_result"><font color=red>The plateNumber can't be empty!</font><br></span>
					<br>
					<input type="submit" value="Submit" id="submit" disabled/>   
					<input type="reset" value="Reset" id="reset"/> 
					<form:input id="carId" path="car.id" type="hidden" />
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>	
	</div>

</body>
</html>