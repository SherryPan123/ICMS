<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<head>
<title>List Cars - ICMS</title>
<meta name="viewport"
	content="width = device-width, initial-scale = 1.0, minimum-scale = 1.0, maximum-scale = 1.0, user-scalable = no" />
<jsp:include page="../basic/table.jsp" flush="true" />
<link href="${context}/css/table.css" rel="stylesheet" type="text/css" />

<style type="text/css">
.redColor {
	color: red
}

.greenColor {
	color: green
}

.blackColor {
	color: black
}

.blueColor {
	color: #337AB7
}

a {
	color: black
}

td {
	text-align: left;
}
</style>

</head>

<script type="text/javascript" src="${context}/js/car/list.js"></script>

<body>
	<jsp:include page="../basic/header.jsp" flush="true" />
	<div class="spacer"></div>
	<div class="spacer"></div>
	<div class="spacer"></div>
	<div class="container-fluid">
		<div class="row col-md-2"></div>
		<div class="row col-md-9">
			<div style="width: 100%; text-align: right">
				<!-- 编辑  -->
				<c:if test="${currentUser.getUsername()!='ICMS' }">
					<c:if test="${isEdit==0}">
						<label><span class="glyphicon glyphicon-pencil"
							aria-hidden="true"></span> </label>
						<a
							href="list?company_id=${company_id}&isEdit=1&page=${page}&status=${status}&totalPage=${totalPage}">
							Edit</a>
					</c:if>
					<c:if test="${isEdit==1}">
						<label><span class="glyphicon glyphicon-eye-open"
							aria-hidden="true"></span> </label>
						<a
							href="list?company_id=${company_id}&isEdit=0&page=${page}&status=${status}&totalPage=${totalPage}">
							Watch</a>
					</c:if>
				</c:if>
				<!-- 添加新车  -->
				<c:if test="${currentUser.getUsername()!='ICMS'}">
					<label class="blueColor"><span
						class="glyphicon glyphicon-plus" aria-hidden="true"></span></label>
					<a class="blueColor"
						href="<c:url value='add?pageStatus=${status}&isEdit=${isEdit}&company_id=${company_id}'/>">
						Add</a>
				</c:if>
			</div>
			<!-- 导航栏  -->
			<ol class="breadcrumb">
				<li><a href="${context}">Home</a></li>
				<c:if test="${currentUser.getUsername()=='ICMS'}">
					<li><a href="${context}/company/list">Company List</a></li>
				</c:if>
				<li class="active">${company_name}</li>
			</ol>
			<div style="width: 100%; text-align: right">
			<!-- 通过Car Type,Plate Number,Buy Time模糊搜索 -->
			<!-- Buy Time待做,参考中国银行-->
			<input id="inputCarType" value="${carType}" placeholder="Car Type"
				onkeypress="if(event.keyCode==13)search(${status},${isEdit},${company_id})" />
			<input id="inputPlateNumber" placeholder="Plate Number"
				value="${searchPlateNumber}"
				onkeypress="if(event.keyCode==13)search(${status},${isEdit},${company_id})" />
			<button type="button" class="btn btn-default" aria-label="Search"
				title="Search" onclick="search(${status},${isEdit},${company_id})">
				<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
			</button>
			<br />
			</div>
			<table id="carList" class="table table-striped" data-filtering="true"
				data-sorting="true">
				<thead>
					<tr>
						<th>Plate Number</th>
						<th>Car Type</th>
						<th>Buy Time</th>
						<th>Status
							<div class="btn-group-vertical">
								<button type="button"
									class="btn btn-link btn-sm dropdown-toggle"
									data-toggle="dropdown">
									<span class="caret"></span>
								</button>
								<ul class="dropdown-menu">
									<c:if test="${status==-1||status==0}">
										<a
											href="?list?isEdit=${isEdit}&status=1&company_id=${company_id}&searchPlateNumber=${searchPlateNumber}&carType=${carType}">
											<button type="button" class="btn-link blackColor">
												<span class="glyphicon glyphicon-ok-sign greenColor"
													aria-hidden="true"></span> &nbsp&nbspOnly Available
											</button>
										</a>
									</c:if>
									<c:if test="${status==1||status==-1}">
										<a
											href="?list?isEdit=${isEdit}&status=0&company_id=${company_id}&searchPlateNumber=${searchPlateNumber}&carType=${carType}">
											<button type="button" class="btn-link blackColor">
												<span class="glyphicon glyphicon-minus-sign redColor"
													aria-hidden="true"></span> &nbsp&nbspOnly Not Available
											</button>
										</a>
									</c:if>
									<c:if test="${status!=-1}">
										<a
											href="?list?isEdit=${isEdit}&status=-1&company_id=${company_id}&searchPlateNumber=${searchPlateNumber}&carType=${carType}">
											<button type="button" class="btn-link blackColor">
												<span class="glyphicon glyphicon-info-sign"
													aria-hidden="true"></span> &nbsp&nbspAll Car
											</button>
										</a>
									</c:if>
								</ul>
							</div>
						</th>
						<c:if test="${isEdit==1}">
							<th>Update</th>
							<th>Delete</th>
						</c:if>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="car" items="${cars}">
						<tr>
							<td>${car.plateNumber}</td>
							<td>${car.carType}</td>
							<td><fmt:formatDate value="${car.buyTime}"
									pattern="yyyy-MM-dd" /></td>
							<c:choose>
								<c:when test="${car.status==1}">
									<td><label class="greenColor" title="Available">
											&nbsp&nbsp&nbsp&nbsp<span class="glyphicon glyphicon-ok-sign"
											aria-hidden="true"></span>
									</label></td>
								</c:when>
								<c:otherwise>
									<td><label class="redColor" title="Not Available">
											&nbsp&nbsp&nbsp&nbsp<span
											class="glyphicon glyphicon-minus-sign" aria-hidden="true"></span>
									</label></td>
								</c:otherwise>
							</c:choose>
							<c:if test="${currentUser.getUsername()!='ICMS'}">
								<c:if test="${isEdit==1}">
									<td><a title="Update"
										href="update?company_id=${company_id}&status=${status}&car_id=${car.id}">
											<button type="button" class="btn btn-default"
												aria-label="Update">
												<span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
											</button>
									</a></td>
									<td>
										<button onclick="deleteCar(${car.id},${company_id},${status})"
											title="Delete" type="button" class="btn btn-default"
											aria-label="Delete">
											<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
										</button>
									</td>
								</c:if>
							</c:if>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!--分页 -->
			<div style="width: 100%; text-align: center">
				<nav>
					<ul class="pagination">
						<li><a
							href="?page=1&isEdit=${isEdit}&status=${status}&company_id=${company_id}&searchPlateNumber=${searchPlateNumber}&carType=${carType}"
							aria-label="First"> <span aria-hidden="true">&laquo;</span>
						</a></li>
						<c:if test="${totalPage<5||totalPage==5}">
							<c:forEach var="i" begin="1" end="${page-1}" step="1">
								<li><a
									href="?page=${i}&isEdit=${isEdit}&status=${status}&company_id=${company_id}&searchPlateNumber=${searchPlateNumber}&carType=${carType}">${i}</a></li>
							</c:forEach>
							<li class="active"><a href="#">${page}</a></li>
							<c:forEach var="i" begin="${page+1}" end="${totalPage}" step="1">
								<li><a
									href="?page=${i}&isEdit=${isEdit}&status=${status}&company_id=${company_id}&searchPlateNumber=${searchPlateNumber}&carType=${carType}">${i}</a></li>
							</c:forEach>
						</c:if>
						<c:if test="${totalPage>5}">
							<c:if test="${page<3 || page==3}">
								<c:forEach var="i" begin="1" end="${page-1}" step="1">
									<li><a
										href="?page=${i}&isEdit=${isEdit}&status=${status}&company_id=${company_id}&searchPlateNumber=${searchPlateNumber}&carType=${carType}">${i}</a></li>
								</c:forEach>
								<li class="active"><a href="#">${page}</a></li>
								<c:forEach var="i" begin="${page+1}" end="5" step="1">
									<li><a
										href="?page=${i}&isEdit=${isEdit}&status=${status}&company_id=${company_id}&searchPlateNumber=${searchPlateNumber}&carType=${carType}">${i}</a></li>
								</c:forEach>
							</c:if>
							<c:if test="${page>3}">
								<c:if test="${totalPage-page<2}">
									<c:forEach var="i" begin="${totalPage-4}" end="${page-1}"
										step="1">
										<li><a
											href="?page=${i}&isEdit=${isEdit}&status=${status}&company_id=${company_id}&searchPlateNumber=${searchPlateNumber}&carType=${carType}">${i}</a></li>
									</c:forEach>
									<li class="active"><a href="#">${page}</a></li>
									<c:forEach var="i" begin="${page+1}" end="${totalPage}"
										step="1">
										<li><a
											href="?page=${i}&isEdit=${isEdit}&status=${status}&company_id=${company_id}&searchPlateNumber=${searchPlateNumber}&carType=${carType}">${i}</a></li>
									</c:forEach>
								</c:if>
								<c:if test="${totalPage-page>2 || totalPage-page==2}">
									<c:forEach var="i" begin="${page-2}" end="${page-1}" step="1">
										<li><a
											href="?page=${i}&isEdit=${isEdit}&status=${status}&company_id=${company_id}&searchPlateNumber=${searchPlateNumber}&carType=${carType}">${i}</a></li>
									</c:forEach>
									<li class="active"><a href="#">${page}</a></li>
									<c:forEach var="i" begin="${page+1}" end="${page+2}" step="1">
										<li><a
											href="?page=${i}&isEdit=${isEdit}&status=${status}&company_id=${company_id}&searchPlateNumber=${searchPlateNumber}&carType=${carType}">${i}</a></li>
									</c:forEach>
								</c:if>
							</c:if>
						</c:if>
						<li><a
							href="?page=${totalPage}&isEdit=${isEdit}&status=${status}&company_id=${company_id}&searchPlateNumber=${searchPlateNumber}&carType=${carType}"
							aria-label="Last"> <span aria-hidden="true">&raquo;</span>
						</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
	<div class="row col-md-2"></div>
	<jsp:include page="../basic/footer.jsp" flush="true" />
</body>
</html>