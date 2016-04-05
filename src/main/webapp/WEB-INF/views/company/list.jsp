<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>

<head>
<title>List Companies - ICMS</title>
<meta name="viewport"
	content="width = device-width, initial-scale = 1.0, minimum-scale = 1.0, maximum-scale = 1.0, user-scalable = no" />

<jsp:include page="../basic/table.jsp" flush="true" />
<link href="${context}/css/table.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.blueColor {
	color: #337AB7
}

a {
	color: black
}
</style>
</head>

<script type="text/javascript" src="${context}/js/company/list.js"></script>

<body>
	<jsp:include page="../basic/header.jsp" flush="true" />
	<div class="spacer"></div>
	<div class="spacer"></div>
	<div class="spacer"></div>

	<div class="container-fluid">
		<div class="row col-md-2"></div>

		<div class="row col-md-9">
			<div style="width: 100%; text-align: right">
				<!-- Edit按钮 -->
				<c:if test="${isEdit==0}" >
				<label> <span class="glyphicon glyphicon-pencil"
					aria-hidden="true"></span>
				</label> <a href="list?name=${name}&isEdit=1&page=${page}">Edit</a>
				</c:if>
				<!--查看按钮 -->
				<c:if test="${isEdit==1}" >
				<label> <span class="glyphicon glyphicon-eye-open"
					aria-hidden="true"></span>
				</label> <a href="list?name=${name}&isEdit=0&page=${page}">Watch</a>
				</c:if>
				<!-- 添加新单位  -->
				<label class="blueColor"> <span
					class="glyphicon glyphicon-plus" aria-hidden="true"></span>
				</label> <a class="blueColor" href="<c:url value='add'/>">Add</a>
			</div>
			<!-- 导航栏  -->
			<ol class="breadcrumb">
				<li><a href="${context}">Home</a></li>
				<li class="active">ICMS</li>
			</ol>
			<div style="width: 100%; text-align: right">
				<!-- 搜索按钮  -->
				<label> <span class="glyphicon glyphicon-filter"
					aria-hidden="true"></span>
				</label> <input id="searchInput" value="${name}" placeholder="Name"
					onkeypress="if(event.keyCode==13)search(${isEdit})" />
				<button type="button" class="btn btn-default" aria-label="Search"
					onclick="search(${isEdit})">
					<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
				</button>
			</div>
			<table id="companyList" class="table table-striped"
				data-filtering="true" data-sorting="true">
				<!-- 罗列信息  -->
				<thead>
					<tr>
						<th>User Name</th>
						<th>Company Name</th>
						<th>Address</th>
						<th>Phone</th>
						<c:if test="${isEdit==1}">
							<th>Update</th>
							<th>Delete</th>
						</c:if>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="company" items="${companies}">
						<tr>
							<td>${company.username}</td>
							<td>${company.name}
								<div class="btn-group-vertical">
									<button type="button"
										class="btn btn-link btn-sm dropdown-toggle"
										data-toggle="dropdown">
										<span class="caret"></span>
									</button>
									<ul class="dropdown-menu">
										<li style="width: 100%;"><a
											href="${context}/car/list?company_id=${company.id}"> <span
												class="glyphicon glyphicon-bed" aria-hidden="true"></span>
												&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbspCar
										</a></li>
										<li><a href="#">下拉链接 2</a></li>
									</ul>
								</div>
							</td>
							<td>${company.address}</td>
							<td>${company.phone}</td>
							<c:if test="${isEdit==1}">
								<td><a href="update?id=${company.id}">
										<button type="button" class="btn btn-default"
											aria-label="Update">
											<span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
										</button>
								</a></td>
							</c:if>
							<c:if test="${company.username=='ICMS'&&isEdit==1}">
								<td>
									<button type="button" class="btn btn-default"
										aria-label="Delete" disabled>
										<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									</button>
								</td>
							</c:if>
							<c:if test="${company.username!='ICMS'&&isEdit==1}">
								<td>
									<button onclick="del(${company.id})" type="button"
										class="btn btn-default" aria-label="Delete">
										<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									</button>
								</td>
							</c:if>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!--分页 -->
			<div style="width: 100%; text-align: center">
				<nav>
					<ul class="pagination">
						<li><a href="?page=1&isEdit=${isEdit}&name=${name}"
							aria-label="First"> <span aria-hidden="true">&laquo;</span>
						</a></li>
						<c:if test="${totalPage<5||totalPage==5}">
							<c:forEach var="i" begin="1" end="${page-1}" step="1">
								<li><a href="?page=${i}&isEdit=${isEdit}&name=${name}">${i}</a></li>
							</c:forEach>
							<li class="active"><a href="#">${page}</a></li>
							<c:forEach var="i" begin="${page+1}" end="${totalPage}" step="1">
								<li><a href="?page=${i}&isEdit=${isEdit}&name=${name}">${i}</a></li>
							</c:forEach>
						</c:if>
						<c:if test="${totalPage>5}">
							<c:if test="${page<3 || page==3}">
								<c:forEach var="i" begin="1" end="${page-1}" step="1">
									<li><a href="?page=${i}&isEdit=${isEdit}&name=${name}">${i}</a></li>
								</c:forEach>
								<li class="active"><a href="#">${page}</a></li>
								<c:forEach var="i" begin="${page+1}" end="5" step="1">
									<li><a href="?page=${i}&isEdit=${isEdit}&name=${name}">${i}</a></li>
								</c:forEach>
							</c:if>
							<c:if test="${page>3}">
								<c:if test="${totalPage-page<2}">
									<c:forEach var="i" begin="${totalPage-4}" end="${page-1}"
										step="1">
										<li><a href="?page=${i}&isEdit=${isEdit}&name=${name}">${i}</a></li>
									</c:forEach>
									<li class="active"><a href="#">${page}</a></li>
									<c:forEach var="i" begin="${page+1}" end="${totalPage}"
										step="1">
										<li><a href="?page=${i}&isEdit=${isEdit}&name=${name}">${i}</a></li>
									</c:forEach>
								</c:if>
								<c:if test="${totalPage-page>2 || totalPage-page==2}">
									<c:forEach var="i" begin="${page-2}" end="${page-1}" step="1">
										<li><a href="?page=${i}&isEdit=${isEdit}&name=${name}">${i}</a></li>
									</c:forEach>
									<li class="active"><a href="#">${page}</a></li>
									<c:forEach var="i" begin="${page+1}" end="${page+2}" step="1">
										<li><a href="?page=${i}&isEdit=${isEdit}&name=${name}">${i}</a></li>
									</c:forEach>
								</c:if>
							</c:if>
						</c:if>
						<li><a
							href="?page=${totalPage}&isEdit=${isEdit}&name=${name}"
							aria-label="Last"> <span aria-hidden="true">&raquo;</span>
						</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
	<div class="row col-md-2"></div>
	<div class="my-space"></div>
	<div class="my-space"></div>
	<div class="my-space"></div>
	<div class="spacer"></div>
	<jsp:include page="../basic/footer.jsp" flush="true" />
</body>
</html>






