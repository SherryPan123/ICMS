<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<jsp:include page="../basic/include.jsp" flush="true" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>List Companies - ICMS</title>
<%
	String path = request.getContextPath();
	String context = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path;
	request.setAttribute("context", context);
%>
</head>
<script type="text/javascript" src="${context}/js/company/list.js"></script>
<body>
	<jsp:include page="../basic/header.jsp" flush="true" />
	<div class="spacer"></div>
	<div class="spacer"></div>
	<div class="spacer"></div>
	<table>
		<!-- 罗列信息  -->
		<tr>
			<td>Username</td>
			<td>Company Name</td>
			<td>Address</td>
			<td>Phone</td>
			<c:if test="${isEdit==0}">
				<td><a href="list?name=${name}&isEdit=1">Edit</a></td>
			</c:if>
			<c:if test="${isEdit==1}">
				<td><a href="list?name=${name}&isEdit=0">Complete Edit</a></td>
			</c:if>
		</tr>
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

		<!--分页 -->
		<tr>
			<td><input type="button" id="first" value="First"
				onclick="pageGo(${page},${totalPage},'first',${isEdit})" /></td>
			<td><input type="button" id="last" value="Last"
				onclick="pageGo(${page},${totalPage},'last',${isEdit})" /></td>
			<td>No.<input id="currentPage" value="${page}"
				onkeypress="if(event.keyCode==13)pageGo(${page},${totalPage},'go',${isEdit})" /></td>
			<td>/${totalPage} IN TOTAL</td>
			<td><input type="button" id="go" value="GO"
				onclick="pageGo(${page},${totalPage},'go',${isEdit})" /></td>
			<td><input type="button" id="next" value="Next"
				onclick="pageGo(${page},${totalPage},'next',${isEdit})" /></td>
			<td><input type="button" id="final" value="Final"
				onclick="pageGo(${page},${totalPage},'final',${isEdit})" /></td>
		</tr>
	</table>

	<!-- 搜索按钮  -->
	<input id="searchInput" value="${name}"
		onkeypress="if(evetn.keyCode==13)search(${isEdit})" />
	<input type="button" value="Search In All" id="searchButton"
		onclick="search(${isEdit})" />
	<br />
	<!-- 添加新单位  -->
	<a href="<c:url value='add'/>">ADD NEW COMPANY</a>
	<jsp:include page="../basic/footer.jsp" flush="true" />
</body>
</html>






