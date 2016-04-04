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
</head>

<script type="text/javascript" src="${context}/js/company/list.js"></script>

<body>
	<jsp:include page="../basic/header.jsp" flush="true" />
	<div class="spacer"></div>
	<div class="spacer"></div>
	<div class="spacer"></div>

	<div class="container-fluid">
		<div class="row col-md-2">
			<!-- 搜索按钮  -->
			<input id="searchInput"
				onkeypress="if(evetn.keyCode==13)search(${isEdit})" />
			<input type="button" value="Search In All" id="searchButton"
				onclick="search(${isEdit})" />
			<br />
			<!-- 添加新单位  -->
			<a href="<c:url value='add'/>">ADD NEW COMPANY</a>
			
			<c:if test="${isEdit==0}">
                <td><a href="list?name=${name}&isEdit=1">Edit</a></td>
            </c:if>
            <c:if test="${isEdit==1}">
                <td><a href="list?name=${name}&isEdit=0">Complete Edit</a></td>
            </c:if>
		</div>
		<div class="row col-md-10">
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
						<th>UPDATE</th>
						<th>DELETE</th>
						</c:if>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="company" items="${companies}">
						<tr>
							<td>${company.username}</td>
							<td>${company.name}</td>
							<td>${company.address}</td>
							<td>${company.phone}</td>
							<c:if test="${company.username=='ICMS'&&isEdit==1}">
								<td><input type="button" value="DELETE" disabled></td>
								<td><input type="button" value="UPDATE"
									onclick="update('${company.id}')" /></td>
							</c:if>
							<c:if test="${company.username!='ICMS'&&isEdit==1}">
								<td><input type="button" value="DELETE"
									onclick="del('${company.id}')"></td>
								<td><input type="button" value="UPDATE"
									onclick="update('${company.id}')" /></td>
							</c:if>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!--分页 -->
			<div style="width: 100%; text-align: center">
			<nav>
				<ul class="pagination">
					<li>
						<a href="?page=1&isEdit=${isEdit}&name=${name}" aria-label="First">
							<span aria-hidden="true">&laquo;</span>
						</a>
					</li>
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
								<c:forEach var="i" begin="${totalPage-4}" end="${page-1}" step="1">
									<li><a href="?page=${i}&isEdit=${isEdit}&name=${name}">${i}</a></li>
								</c:forEach>
								<li class="active"><a href="#">${page}</a></li>
								<c:forEach var="i" begin="${page+1}" end="${totalPage}" step="1">
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
					<li>
   					   <a href="?page=${totalPage}&isEdit=${isEdit}&name=${name}" aria-label="Next">
       						<span aria-hidden="true">&raquo;</span>
    				   </a>
    				</li>
				</ul>
			</nav>
		</div>
		</div>
	</div>
	<div class="my-space"></div>
	<div class="my-space"></div>
	<div class="my-space"></div>
	<jsp:include page="../basic/footer.jsp" flush="true" />	
</body>
</html>






