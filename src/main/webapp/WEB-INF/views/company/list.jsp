<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<title>List Companies - ICMS</title>
<meta name="viewport"
	content="width = device-width, initial-scale = 1.0, minimum-scale = 1.0, maximum-scale = 1.0, user-scalable = no" />
<jsp:include page="../basic/include.jsp" flush="true" />
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
	<div class="container-fluid">
		<div class="spacer"></div>
		<div class="spacer"></div>
		<div class="row col-md-2">
			<div class="spacer"></div>
		</div>
		<div class="row col-md-9">
			<!-- edit&watch&add -->
			<div class="edit_watch_add">
				<a href="list?name=${name}&isEdit=1&page=${page}"><span class="glyphicon glyphicon-pencil" style="margin-right: 5px"></span>Edit</a>
				<span style="margin-right:5px"></span>
				<a href="list?name=${name}&isEdit=0&page=${page}"><span class="glyphicon glyphicon-eye-open" style="margin-right: 5px"></span>Watch</a>
				<!-- 添加新单位  -->
				<span style="margin-right:5px"></span>
				<a id="addButton" href="javascript:void(0);" style="color:#337AB7; cursor:pointer"><span class="glyphicon glyphicon-plus" style="margin-right: 5px"></span>Add</a>
				<noscript>
					<a class="blueColor" href="<c:url value='add'/>">Add</a>
				</noscript>
			</div>
			<!-- 导航栏  -->
			<ol class="breadcrumb">
				<li><a href="${context}">Home</a></li>
				<li><a href="${context}/company/list">Company</a></li>
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
						<th data-type="html">Company Name</th>
						<th data-breakpoints="xs md">Address</th>
						<th data-breakpoints="xs md">Phone</th>
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
	<!-- Add的弹窗 -->
	<div id="addCompany" class="modal fade" tabindex="-1" role="dialog"
		aria-labelledby="myAddLabel">
		<div class="modal-dialog" style="width: 500px" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title text-center" id="addTitle">Add New
						Company</h4>
				</div>
				<div class="modal-body">
					<form id="addForm" class="form-horizontal" method="GET" onsubmit="add()">
						<sec:csrfInput />
						User Name:<input name="username" id="add_username" onchange="checkAddUsername()"><br> 
						<span id="add_username_result"></span> 
						Company Name：<input name="name" id="add_name" onchange="checkAddName()" /><br> 
						<span id="add_name_result"></span> 
						Password：<input type="password" name="password" id="add_password" onchange="confirmAddPassword()" /><br>
						Confirm Password：<input type="password" id="add_cpassword" onchange="confirmAddPassword()" /><br> 
						<span id="add_confirm_result"></span> 
						Address：<input name="address" id="address" /><br> 
						Phone:<input name="phone" id="phone" /><br>
						<button disabled id="add_submit" type="submit" class="btn btn-warning">Submit</button>
						<button id="add_reset" type="reset" class="btn btn-default navbar-btn">Reset</button>
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






