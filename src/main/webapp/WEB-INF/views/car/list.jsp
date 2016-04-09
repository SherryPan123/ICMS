<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>List Cars - ICMS</title>
<meta name="viewport"
	content="width = device-width, initial-scale = 1.0, minimum-scale = 1.0, maximum-scale = 1.0, user-scalable = no" />
<jsp:include page="../basic/include.jsp" flush="true" />
<jsp:include page="../basic/table.jsp" flush="true" />
<link href="${context}/css/table.css" rel="stylesheet" type="text/css" />

<style type="text/css">
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
	<div class="container-fluid container-height">
		<div class="spacer"></div>
		<div class="spacer"></div>
		<div class="row col-md-2">
			<div class="spacer"></div>
		</div>
		<div class="row col-md-9">
			<div style="width: 100%; text-align: right">
				<!-- 编辑  -->
				<div class="edit_watch_add">
					<c:if test="${currentUser.getUsername()!='ICMS' }">
						<a href="list?company_id=${company_id}&isEdit=1&page=${page}&status=${status}&totalPage=${totalPage}"><span class="glyphicon glyphicon-pencil" aria-hidden="true" style="margin-right: 5px"></span>Edit</a>
						<span style="margin-right:5px"></span>
						<a href="list?company_id=${company_id}&isEdit=0&page=${page}&status=${status}&totalPage=${totalPage}"><span class="glyphicon glyphicon-eye-open" aria-hidden="true" style="margin-right: 5px"></span>Watch</a>
						<!-- 添加新车  -->
						<span style="margin-right:5px"></span>
						<a class="blueColor" style="color:#337AB7; cursor:pointer" href="<c:url value='add?pageStatus=${status}&isEdit=${isEdit}&company_id=${company_id}'/>"><span class="glyphicon glyphicon-plus" aria-hidden="true" style="margin-right: 5px"></span>Add</a>
					</c:if>
				</div>				
			</div>
			<!-- 导航栏  -->
			<ol class="breadcrumb">
				<li><a href="${context}">Home</a></li>
				<li><a href="${context}/car/list?company_id=${company_id}">Car</a></li>
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
			<table id="carList" class="table table-striped">
				<thead>
					<tr>
						<th data-breakpoints="xs md">Company Name</th>
						<th>Plate Number</th>
						<th>Car Type</th>
						<th data-breakpoints="xs md" class="sort-column">Buy Time</th>
						<th data-type="html" style="padding-bottom:2px">
							<span>Status</span>
							<div class="btn-group-vertical">
								<button type="button"
									class="btn btn-link btn-sm dropdown-toggle"
									data-toggle="dropdown">
									<span class="caret"></span>
								</button>
								<ul class="dropdown-menu">
									<c:if test="${status==-1||status==0}">
										<li><a style="padding-left:5px"
											href="${context}/car/list?isEdit=${isEdit}&status=1&company_id=${company_id}&searchPlateNumber=${searchPlateNumber}&carType=${carType}">
											<button type="button" class="btn-link blackColor focus_not_underline">
												<span class="glyphicon glyphicon-ok greenColor"
													aria-hidden="true"></span> &nbsp;&nbsp;可借
											</button>
										</a></li>
									</c:if>
									<c:if test="${status==1||status==-1}">
										<li><a style="padding-left:5px"
											href="${context}/car/list?isEdit=${isEdit}&status=0&company_id=${company_id}&searchPlateNumber=${searchPlateNumber}&carType=${carType}">
											<button type="button" class="btn-link blackColor focus_not_underline">
												<span class="glyphicon glyphicon-minus redColor"
													aria-hidden="true"></span> &nbsp;&nbsp;借出
											</button>
										</a></li>
									</c:if>
									<c:if test="${status!=-1}">
										<li><a style="padding-left:5px;"
											href="${context}/car/list?isEdit=${isEdit}&status=-1&company_id=${company_id}&searchPlateNumber=${searchPlateNumber}&carType=${carType}">
											<button type="button" class="btn-link blackColor focus_not_underline">
												<span class="glyphicon glyphicon-info-sign"
													aria-hidden="true"></span> &nbsp;&nbsp;所有车
											</button>
										</a></li>
									</c:if>
								</ul>
							</div>
						</th>
						<c:if test="${isEdit==1}">
							<th data-type="html">Operation</th>
						</c:if>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="car" items="${cars}">
						<tr>
							<td>${car.company.username}</td>
							<td>${car.plateNumber}</td>
							<td>${car.carType}</td>
							<td><fmt:formatDate value="${car.buyTime}"
									pattern="yyyy-MM-dd" /></td>
							<c:choose>
								<c:when test="${car.status==1}">
									<td><label class="greenColor" title="Available">
											&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-ok"
											aria-hidden="true"></span>
									</label></td>
								</c:when>
								<c:otherwise>
									<td><label class="redColor" title="Not Available">
											&nbsp;&nbsp;&nbsp;&nbsp;<span
											class="glyphicon glyphicon-minus" aria-hidden="true"></span>
									</label></td>
								</c:otherwise>
							</c:choose>
							<c:if test="${currentUser.getUsername()!='ICMS'}">
								<c:if test="${isEdit==1}">
									<td>
										<span style="margin-right:10px"></span>
										<a title="Update" href="update?company_id=${company_id}&status=${status}&car_id=${car.id}" class="focus_not_underline">
											<span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
										</a>
										<span style="margin-right:15px"></span>
										<a onclick="deleteCar(${car.id},${company_id},${status})" title="Delete" aria-label="Delete" class="focus_not_underline" style="cursor:pointer">
											<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
										</a>
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