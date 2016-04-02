<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="../basic/include.jsp" flush="true" />
<title>employee view - ICMS</title>
<script src="${context}/js/employee.js"></script>
</head>
<body>
<jsp:include page="../basic/header.jsp" flush="true" />
<div style="margin: 100px">
	<div>
		<p>View Employee</p>
		<p>Employee Id: ${employee.employeeId}</p>
		<p>Name: ${employee.name}</p>
		<p>Sex: ${employee.sex}</p>
		<p>Phone: ${employee.phone}</p>
		<p>Email: ${employee.email}</p>
		
		<p>conditions:</p>
		<table>
			<thead>
<!--                 <tr> -->
<!--                     <th data-sort-initial="true">Plate Number</th> -->
<!--                     <th>Car Model</th> -->
<!--                     <th>Lending Time</th> -->
<!--                     <th>Returning Time</th> -->
<!--                     <th>Driver</th> -->
<%--                     <c:if test="${isEdit==1}"> --%>
<!--                     <th>operation</th> -->
<%--                     </c:if> --%>
<!--                 </tr> -->
            </thead>
            <c:forEach var="conditions" items="${conditionsList}">
                <tr>
                    <td>
                        ${conditions.car.plateNumber}
<!--                     </td> -->
<!--                     <td> -->
<%--                         ${conditions.car.carType} --%>
<!--                     </td> -->
<!--                     <td> -->
<%--                     	<fmt:formatDate value="${conditions.lendTime}" pattern="yyyy-MM-dd" /> --%>
<!--                     </td> -->
<!--                     <td> -->
<%--                         <fmt:formatDate value="${conditions.returnTime}" pattern="yyyy-MM-dd" /> --%>
<!--                     </td> -->
<!--                     <td> -->
<%--                     	${conditions.employee.name} --%>
                    </td>
                <tr>
        	</c:forEach>
        </table>
        
        <p>accident:</p>
        <table>
        
        </table>
	</div>
</div>
<jsp:include page="../basic/footer.jsp" flush="true" />
</body>
</html>