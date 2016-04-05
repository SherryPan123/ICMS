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
	<div class="spacer"></div>
	<div class="spacer"></div>
	<div class="spacer"></div>
	<div class="spacer"></div>
	<div class="spacer"></div>
	<div class="container-fluid container-height" ">
		<div class="row col-md-2">
		<div class="spacer"></div>
		
		<c:if test="${companyId != 1}">
		<a href="/icms/fare/add"><input type="button" value="Add"></a>
		</c:if>
		<c:if test="${companyId!=1 && isEdit==0}">
			<a href="list?isEdit=1"><input type="button" value="Edit"></a>
		</c:if>
		<c:if test="${companyId!=1 && isEdit==1}">
			<a href="list?isEdit=0"><input type="button" value="Complet Edit"></a>
		</c:if>
		</div>
		<div class="row col-md-8">

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

</body>
</html>