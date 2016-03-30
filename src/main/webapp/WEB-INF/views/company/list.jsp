<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>List Companies - ICMS</title>
<%
	String path = request.getContextPath();
    String context = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
    request.setAttribute("context", context);
%>
</head>
<script type="text/javascript" src="${context}/js/company/list.js"></script>
<body>
	<table>
	<!-- 罗列信息  -->
		<tr>
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
				<td>${company.name}</td>
				<td>${company.address}</td>
				<td>${company.phone}</td>
				<c:if test="${company.name=='ICMS'&&isEdit==1}">
					<td><input type="button" value="DELETE" disabled></td>
					<td><input type="button" value="UPDATE" onclick="update('${company.name}')" /></td>
				</c:if>
				<c:if test="${company.name!='ICMS'&&isEdit==1}">
					<td><input type="button" value="DELETE" onclick="del('${company.id}')"></td>
					<td><input type="button" value="UPDATE" onclick="update('${company.id}')" /></td>
				</c:if>
			</tr>
		</c:forEach>
		
		<!--分页 -->
		<tr>
		<td><input type="button" id="first" value="First" onclick="pageGo(${totalPage},${isEdit},3)"/></td>
		<td><input type="button" id="last" value="Last" onclick="pageGo(${totalPage},${isEdit},1)"/></td>
		<td>No.<input id="currentPage" value="${page}" onkeypress="if(event.keyCode==13)pageGo(${totalPage},${isEdit},0)"/></td>
		<td>/${totalPage} IN TOTAL</td>
		<td><input type="button" id="go" value="GO" onclick="pageGo(${totalPage},${isEdit})"/></td>
		<td><input type="button" id="next" value="Next" onclick="pageGo(${totalPage},${isEdit},2,0)"/></td>
		<td><input type="button" id="final" value="Final"onclick="pageGo(${totalPage},${isEdit},4)"/></td>
		</tr>
	</table>

	<!-- 搜索按钮  -->
	<input id="searchInput" onkeypress="if(evetn.keyCode==13)search(${isEdit})"/>
	<input type="button" value="Search In All" id="searchButton" onclick="search(${isEdit})"/>
	<br/>
	<!-- 添加新单位  -->
	<a href="<c:url value='add'/>">ADD NEW COMPANY</a>
</body>
</html>






