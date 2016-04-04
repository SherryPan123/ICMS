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
</head>

<script type="text/javascript" src="${context}/js/car/list.js"></script>

<body>
	<jsp:include page="../basic/header.jsp" flush="true" />
	<div class="spacer"></div>
	<div class="spacer"></div>
	<div class="spacer"></div>
	<div class="container-fluid">
		<div style="width: 100%; text-align: right">
			<!-- 通过Car Type,Plate Number,Buy Time模糊搜索 -->
			<!-- Buy Time待做,参考中国银行-->
			Car Type: <input id="inputCarType" value="${carType}"
				onkeypress="if(event.keyCode==13)search(${status},${isEdit})" /> <br />
			Plate Number: <input id="inputPlateNumber"
				value="${searchPlateNumber}"
				onkeypress="if(event.keyCode==13)search(${status},${isEdit})" /> <br />
			<button type="button" class="btn btn-default" aria-label="Search"
				onclick="search(${status},${isEdit})">
				<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
			</button> <br />
			<!-- 添加新车  -->
			<c:if test="${currentUser.getUsername()!='ICMS'}">
				<a
					href="<c:url value='add?pageStatus=${status}&isEdit=${isEdit}&company_id=${company_id}'/>">Add
					New Car</a>
			</c:if>
			<c:if test="${status==-1||status==0}">
				<td><input type="button" value="Only Available"
					onclick="changeStatus(1,${isEdit})" /></td>
			</c:if>

			<c:if test="${status==1||status==-1}">
				<td><input type="button" value="Only Not Available"
					onclick="changeStatus(0,${isEdit})" /></td>
			</c:if>
			<c:if test="${status!=-1}">
				<td><input type="button" value="All Car"
					onclick="changeStatus(-1,${isEdit})" /></td>
			</c:if>
			<c:if test="${currentUser.getUsername()!='ICMS' }">
				<c:if test="${isEdit==0}">
					<a
						href="list?company_id=${company_id}&isEdit=1&page=${page}&status=${status}&totalPage=${totalPage}">
						<button type="button" class="btn btn-default" aria-label="Edit">
							<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
						</button>
					</a>
				</c:if>
				<c:if test="${isEdit==1}">
					<a
						href="list?company_id=${company_id}&isEdit=0&page=${page}&status=${status}&totalPage=${totalPage}">
						<button type="button" class="btn btn-default" aria-label="Watch">
							<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>
						</button>
					</a>
				</c:if>
			</c:if>
		</div>
		<table id="carList" class="table table-striped" data-filtering="true"
			data-sorting="true">
			<thead>
				<tr>
					<th>Plate Number</th>
					<th>Car Type</th>
					<th>Buy Time</th>
					<th>Status</th>
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
								<td><label> <span
										class="glyphicon glyphicon-ok-sign" aria-hidden="true"></span>
								</label></td>
							</c:when>
							<c:otherwise>
								<td><label> <span
										class="glyphicon glyphicon-minus-sign" aria-hidden="true"></span>
								</label></td>
							</c:otherwise>
						</c:choose>
						<c:if test="${currentUser.getUsername()!='ICMS'}">
							<c:if test="${isEdit==1}">
								<td><a
									href="update?company_id=${company_id}&status=${status}&car_id=${car.id}">
										<button type="button" class="btn btn-default"
											aria-label="Update">
											<span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
										</button>
								</a></td>
								<td>
									<button onclick="deleteCar(${car.id},${company_id},${status})"
										type="button" class="btn btn-default" aria-label="Delete">
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
								<c:forEach var="i" begin="${page+1}" end="${totalPage}" step="1">
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
	<jsp:include page="../basic/footer.jsp" flush="true" />
</body>
</html>