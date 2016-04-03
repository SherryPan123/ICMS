<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<head>
<jsp:include page="../basic/include.jsp" flush="true" />
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>List Cars</title>
</head>
<script type="text/javascript" src="${context}/js/car/list.js"></script>
<body>
	<jsp:include page="../basic/header.jsp" flush="true" />
	<div class="spacer"></div>
	<div class="spacer"></div>
	<div class="spacer"></div>
	<table>
		<tr>
			<td>Plate Number</td>
			<td>Car Type</td>
			<td>Buy Time</td>
			<td>Status</td>
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
					<td><input type="button" id="edit" value="Edit"
						onclick="edit(${page},${totalPage},1,${status},${company_id})" /></td>
				</c:if>
				<c:if test="${isEdit==1}">
					<td><input type="button" id="edit" value="Complete Edit"
						onclick="edit(${page},${totalPage},0,${status},${company_id})" /></td>
				</c:if>
			</c:if>
		</tr>

		<c:forEach var="car" items="${cars}">
			<tr>
				<td>${car.plateNumber}</td>
				<td>${car.carType}</td>
				<td><fmt:formatDate value="${car.buyTime}" pattern="yyyy-MM-dd" /></td>
				<c:choose>
					<c:when test="${car.status==1}">
						<td>Available</td>
					</c:when>
					<c:otherwise>
						<td>Not Available</td>
					</c:otherwise>
				</c:choose>
				<c:if test="${currentUser.getUsername()!='ICMS'}">
					<c:if test="${isEdit==1}">
						<td><input type="button" id="UPDATE" value="UPDATE"
							onclick="updateCar(${car.id},${company_id},${status})" /></td>
					</c:if>
					<c:if test="${isEdit==1}">
						<td><input type="button" id="DELETE" value="DELETE"
							onclick="deleteCar(${car.id},${company_id},${status})" /></td>
					</c:if>
				</c:if>
			</tr>
		</c:forEach>

		<tr>
			<td><input type="button" id="first" value="First"
				onclick="pageGo(${page},${totalPage},'first',${isEdit},${status},${company_id})" /></td>
			<td><input type="button" id="previous" value="Previous"
				onclick="pageGo(${page},${totalPage},'previous',${isEdit},${status},${company_id})" /></td>
			<td>No.<input id="currentPage" value="${page}"
				onkeypress="if(event.keyCode==13)pageGo(${page},${totalPage},'go',${isEdit},${status},${company_id})" />/${totalPage}
				IN TOTAL
			</td>
			<td><input type="button" id="go" value="GO"
				onclick="pageGo(${page},${totalPage},'go',${isEdit},${status},${company_id})" /></td>
			<td><input type="button" id="next" value="Next"
				onclick="pageGo(${page},${totalPage},'next',${isEdit},${status},${company_id})" /></td>
			<td><input type="button" id="final" value="Final"
				onclick="pageGo(${page},${totalPage},'final',${isEdit},${status},${company_id})"></td>
				
			<!--用于数据传输的隐藏标签-->
			<td><input type="hidden" id="searchPlateNumber" name="searchPlateNumber" value="${searchPlateNumber}"/></td>
			<td><input type="hidden" id="carType" name="carType" value="${carType}"/></td>
			<!--  -->
		</tr>
	</table>
	<!-- 通过Car Type,Plate Number,Buy Time模糊搜索 -->
	<!-- Buy Time待做,参考中国银行-->
	<br /> Car Type:
	<input id="inputCarType" value="${carType}" onkeypress="if(event.keyCode==13)search(${status},${isEdit})" />
	<br /> Plate Number:
	<input id="inputPlateNumber" value="${searchPlateNumber}" onkeypress="if(event.keyCode==13)search(${status},${isEdit})" />
	<br />
	<input id="search" value="search" onclick="search(${status},${isEdit})" type="button" />
	<br>
	<!-- 添加新车  -->
	<c:if test="${currentUser.getUsername()!='ICMS'}">
		<a href="<c:url value='add?pageStatus=${status}&isEdit=${isEdit}&company_id=${company_id}'/>">Add New Car</a>
	</c:if>
	<jsp:include page="../basic/footer.jsp" flush="true" />
</body>
</html>