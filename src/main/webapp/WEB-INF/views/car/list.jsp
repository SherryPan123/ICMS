<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>List Cars</title>
</head>
<body>
	<table>
		<tr>
			<td>Plate Number</td>
			<td>Car Type</td>
			<td>Buy Time</td>
			<td>Status</td>
		</tr>
		<c:forEach var="car" items="${cars}">
			<td>${car.plateNumber}</td>
			<td>${car.carType}</td>
			<td>${car.buyTime}</td>
			<c:choose>
				<c:when test="${car.status==1}">
					<td>Available</td>
				</c:when>
				<c:otherwise>
					<td>Not Available</td>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<tr>
			<td><input type="button" id="first" value="First" onclick="pageGo(${page},${totalPage},'first')"/></td>
			<td><input type="button" id="last" value="Last" onclick="pageGo(${page},${totalPage},'last')"/></td>
			<td>No.<input id="currentPage" value="${page}" onkeypress="if(event.keyCode==13)pageGo(${page},${totalPage},'go')"/>/${totalPage} IN TOTAL</td>
			<td><input type="button" id="go" value="GO" onclick="pageGo(${page},${totalPage},'go')"/></td>
			<td><input type="button" id="after" value="After" onclick="pageGo(${page},${totalPage},'after')"/></td>
			<td><input type="button" id="final" value="Final" onclick="pageGo(${page},${totalPage},'final')"></td>
		</tr>
	</table>
	<!-- 通过Car Type,Plate Number,Buy Time模糊搜索 -->
	<!-- Buy Time待做,参考中国银行-->
	搜索<br/>
	Car Type:<input id="inputCarType" onkeypress="if(event.keyCode==13)search()"/><br/>
	Plate Number:<input id="inputPlateNumber" onkeypress="if(event.keyCode==13)search()"/><br/>
	<input id="search" value="search" onclick="search()" type="button"/>
	<br>
	<!-- 添加新车  -->
	<a href="<c:url value='add'/>">Add New Car</a>
</body>
</html>