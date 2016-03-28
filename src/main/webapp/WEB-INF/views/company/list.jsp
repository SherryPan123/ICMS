<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>List Companies - ICMS</title>
<script type="text/javascript">
	function del(id) {
		var v = window.confirm('Delete this company？');
		if (v) {
			if (v) {
				window.location.href = 'delete?id=' + id;
			}
		}
	}
	function update(name) {
		window.location.href = "update?name=" + name;
	}
</script>
</head>

<body>
	<table>
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
		<c:forEach var="company" items="${company}">
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
					<td><input type="button" value="UPDATE" onclick="update('${company.name}')" /></td>
				</c:if>
			</tr>
		</c:forEach>
	</table>
	<form method="get" action="<c:url value='list?name=${name}' />">
		<input type="text" name="name" /> <input type="submit" />
	</form>
	<a href="<c:url value='add'/>">ADD NEW COMPANY</a>
</body>
</html>






