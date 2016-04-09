<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
			<label for="searchPlateNumber">plateNumber</label>
			<input type="text" id = "searchPlateNumber" value="${plateNumber}" name="searchPlateNumber" placeholder="PlateNumber" />  
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
		
		</div>	
		
		<div class="row col-md-8">
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
	<div class="my-space"></div>
	<div class="my-space"></div>
	<div class="my-space"></div>
	
	<div id="addAccident" class ="modal fade" tabindex="-1" role="dialog"
		aria-labelledby="myAddLabel">
		<div class="modal-dialog" style="width:500px" role="document">
			<div class="modal-content">
				<button type="button" class="close" data-dismiss="modal"
						aria-label="close">
						<span aria-hidden="true">$times;</span>
						</button>
						<h4 class="modal-title text-center" id="myAddLabel">Add Accident</h4>
			</div>
			<div class="modal-body">
				<span id ="addErrorMsg"></span>
				<form:form id ="addAccidentForm" method ="post" modeAttribute="accident" onsubmit="return add();">
					<form:input id = "companyId" path="company.id" value="${companyId}" type = "hidden"/>
					
				</form:form>
			</div>
		</div>
	</div>
	<jsp:include page="../basic/footer.jsp" flush="true" />

</body>
</html>