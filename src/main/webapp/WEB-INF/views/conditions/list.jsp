<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../basic/include.jsp" flush="true" />
<title>conditions list - ICMS</title>
<%
	Date now = new Date(System.currentTimeMillis());
	request.setAttribute("now",now);
%>
<script src="${context}/js/conditions.js"></script>
</head>
<body>
<jsp:include page="../basic/header.jsp" flush="true" />


	<div class="spacer"></div>
	<div class="spacer"></div>
	<div class="spacer"></div>
	<div class="spacer"></div>
	<div class="spacer"></div>

	<form  id="_pageForm" name="_pageForm" method="GET">
		<div>
			<label for="car">car</label>
			<input type="text" id="car" name="car" value="${car}" placeholder="plateNumber / car model"/>		
		</div>
		<div>
		<label for="employee">driver</label>
		<input type="text" id="employee" name="employee" value="${employee}" placeholder="employeeId / name"/>
		</div>
		<div>
		<label for="lendTime">lend time</label>
		<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="FormattedDate" />
		<input type="text" id="lendTime" name="lendTime" value="${lendTime}" placeholder="${FormattedDate}"/>
		</div>
		<div>
		<label for="returnTime">return time</label>
		<input type="text" id="returnTime" name="returnTime" value="${returnTime}" placeholder="${FormattedDate}"/>
		</div>
		<div>
		<button type="submit">Search</button>
		<button type="reset">Reset</button>
		</div>
	</form>
	<c:if test="${isEdit==0}">
	<a class="glyphicon glyphicon-edit" title="edit" href="?page=${page}&max=${max}&companyId=${companyId}&car=${car}&employee=${employee}&lendTime=${lendTime}&returnTime=${returnTime}&isEdit=1"></a>
	</c:if>
	<c:if test="${isEdit==1}">
	<a class="glyphicon glyphicon-check" title="view" href="?page=${page}&max=${max}&companyId=${companyId}&car=${car}&employee=${employee}&lendTime=${lendTime}&returnTime=${returnTime}&isEdit=0"></a>
	</c:if>
	<div class = "demo-container">
        <div class="tab-content">
            <div class="tab-pane active" id="demo">
        <table class="demo">
            <thead>
                <tr>
                    <th data-sort-initial="true">Plate Number</th>
                    <th>Car Model</th>
                    <th>Lending Time</th>
                    <th>Returning Time</th>
                    <th>Driver</th>
                    <c:if test="${isEdit==1}">
                    <th>operation</th>
                    </c:if>
                </tr>
            </thead>
            <c:forEach var="conditions" items="${conditionsList}">
                <tr>
                    <td>
                        ${conditions.car.plateNumber}
                    </td>
                    <td>
                        ${conditions.car.carType}
                    </td>
                    <td>
                    	<fmt:formatDate value="${conditions.lendTime}" pattern="yyyy-MM-dd" />
                    </td>
                    <td>
                        <fmt:formatDate value="${conditions.returnTime}" pattern="yyyy-MM-dd" />
                    </td>
                    <td>
                    	${conditions.employee.name}
                    </td>
                    <c:if test="${isEdit==1}">
						<td>
						<a href="${context}/conditions/delete?id=${conditions.id}" onClick="return confirm('Confirm Delete?')">delete</a>
						<a href="${context}/conditions/update?id=${conditions.id}">update</a>
						</td>
					</c:if>
                <tr>
        	</c:forEach>
        </table>
        </div>
        </div>
    </div>
    
    <div>
    	<a href="${context}/conditions/add?companyId=${companyId}">add new conditions</a>
    </div>
    
	<!--分页 -->
	<span>Current page: ${page}, Total page: ${totalPage}</span>
    <div>
		<c:if test="${page <= 1}"><a class="btn btn-default" disabled='disabled'>First</a></c:if>
		<c:if test="${page > 1}"><a class="btn btn-default" href="?page=1&max=${max}&companyId=${companyId}&car=${car}&employee=${employee}&lendTime=${lendTime}&returnTime=${returnTime}&isEdit=${isEdit}">First</a></c:if>

		<c:if test="${page - 1 < 1}"><a class="btn btn-default" disabled='disabled'>Previous</a></c:if>
		<c:if test="${page - 1 >= 1}"><a class="btn btn-default" href="?page=${page-1}&max=${max}&companyId=${companyId}&car=${car}&employee=${employee}&lendTime=${lendTime}&returnTime=${returnTime}&isEdit=${isEdit}">Previous</a></c:if>
		
		<c:if test="${page + 1 > totalPage}"><a class="btn btn-default" disabled='disabled'>Next</a></c:if>
		<c:if test="${page + 1 <= totalPage}"><a class="btn btn-default" href="?page=${page+1}&max=${max}&companyId=${companyId}&car=${car}&employee=${employee}&lendTime=${lendTime}&returnTime=${returnTime}&isEdit=${isEdit}">Next</a></c:if>

		<c:if test="${page >= totalPage}"><a class="btn btn-default" disabled='disabled'>Last</a></c:if>
		<c:if test="${page < totalPage}"><a class="btn btn-default" href="?page=${totalPage}&max=${max}&companyId=${companyId}&car=${car}&employee=${employee}&lendTime=${lendTime}&returnTime=${returnTime}&isEdit=${isEdit}">Last</a></c:if>
	</div><!--page-->
    
    <div class="spacer"></div>
	<div class="spacer"></div>
	<div class="spacer"></div>
	<div class="spacer"></div>
	<div class="spacer"></div>
    
    
<jsp:include page="../basic/footer.jsp" flush="true" />
</body>
</html>