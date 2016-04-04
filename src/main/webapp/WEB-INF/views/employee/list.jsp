<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../basic/include.jsp" flush="true" />
<title>employee list - ICMS</title>
</head>
<body>
<jsp:include page="../basic/header.jsp" flush="true" />


	<div class="spacer"></div>
	<div class="spacer"></div>
	<div class="spacer"></div>
	<div class="spacer"></div>
	<div class="spacer"></div>

	<form id="_pageForm" name="_pageForm" method="GET">
		<div>
			<label for="employeeId">employeeId</label>
			<input type="text" id="employeeId" name="employeeId" value="${employeeId}" placeholder="employee Id"/>		
		</div>
		<div>
		<label for="name">name</label>
		<input type="text" id="name" name="name" value="${name}" placeholder="employee name"/>
		</div>
		<div>
		<button type="submit">Search</button>
		<button type="reset">Reset</button>
		</div>
	</form>
	<c:if test="${isEdit==0}">
	<a class="glyphicon glyphicon-edit" title="edit" href="?page=${page}&max=${max}&companyId=${companyId}&name=${name}&isEdit=1"></a>
	</c:if>
	<c:if test="${isEdit==1}">
	<a class="glyphicon glyphicon-check" title="view" href="?page=${page}&max=${max}&companyId=${companyId}&name=${name}&isEdit=0"></a>
	</c:if>
	<div class = "demo-container">
        <div class="tab-content">
            <div class="tab-pane active" id="demo">
        <table class="demo">
            <thead>
                <tr>
                    <th data-sort-initial="true">employee id</th>
                    <th>name</th>
                    <th>sex</th>
                    <th>phone</th>
                    <th>email</th>
                    <c:if test="${isEdit==1}">
                    <th>operation</th>
                    </c:if>
                </tr>
            </thead>
            <c:forEach var="employee" items="${employeeList}">
                <tr>
                    <td>
                        <a href="${context}/employee/view?id=${employee.id}">${employee.employeeId}</a>
                    </td>
                    <td>
                        ${employee.name}
                    </td>
                    <td>
                    	${employee.sex}
                    </td>
                    <td>
                        ${employee.phone}
                    </td>
                    <td>
                    	${employee.email}
                    </td>
                    <c:if test="${isEdit==1}">
						<td>
						<a href="${context}/employee/update?id=${empployee.id}">update</a>
						</td>
					</c:if>
                <tr>
        	</c:forEach>
        </table>
        </div>
        </div>
    </div>
    
    <div>
    	<a href="${context}/employee/add?companyId=${companyId}">add new employee</a>
    </div>
    
	<!--分页 -->
	<span>Current page: ${page}, Total page: ${totalPage}</span>
    <div>
		<c:if test="${page <= 1}"><a class="btn btn-default" disabled='disabled'>First</a></c:if>
		<c:if test="${page > 1}"><a class="btn btn-default" href="?page=1&max=${max}&companyId=${companyId}&employeeId=${employeeId}&name=${name}&isEdit=${isEdit}">First</a></c:if>

		<c:if test="${page - 1 < 1}"><a class="btn btn-default" disabled='disabled'>Previous</a></c:if>
		<c:if test="${page - 1 >= 1}"><a class="btn btn-default" href="?page=${page-1}&max=${max}&companyId=${companyId}&employeeId=${employeeId}&name=${name}&isEdit=${isEdit}">Previous</a></c:if>
		
		<c:if test="${page + 1 > totalPage}"><a class="btn btn-default" disabled='disabled'>Next</a></c:if>
		<c:if test="${page + 1 <= totalPage}"><a class="btn btn-default" href="?page=${page+1}&max=${max}&companyId=${companyId}&employeeId=${employeeId}&name=${name}&isEdit=${isEdit}">Next</a></c:if>

		<c:if test="${page >= totalPage}"><a class="btn btn-default" disabled='disabled'>Last</a></c:if>
		<c:if test="${page < totalPage}"><a class="btn btn-default" href="?page=${totalPage}&max=${max}&companyId=${companyId}&employeeId=${employeeId}&name=${name}&isEdit=${isEdit}">Last</a></c:if>
	</div><!--page-->
    
    <div class="spacer"></div>
	<div class="spacer"></div>
	<div class="spacer"></div>
	<div class="spacer"></div>
	<div class="spacer"></div>
    
    
<jsp:include page="../basic/footer.jsp" flush="true" />
</body>
</html>