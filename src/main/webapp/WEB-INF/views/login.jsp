<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="basic/include.jsp" flush="true" />
<!-- Login Form CSS -->
<link href="${context}/css/login.css" rel="stylesheet">
<title>login - ICMS</title>
</head>
<body>
<jsp:include page="basic/header.jsp" flush="true" />
<div class="intro-header">
    <div class="container">
    	<div class="row">
            <div class="col-lg-12">
                <div class="intro-message">
                    <div class="spacer"></div>
                    <div class="spacer"></div>
                    <div class="spacer"></div>
                    <h1>ICMS</h1>
                    <h3>Information of Car Management System</h3>
                    <div class="spacer"></div>
                    <hr class="intro-divider">
                </div>
            </div>
        </div>

		<div class="login-form">
			<form action="${context}/login" method="post" class="form-inner">
				<sec:csrfInput />
				<c:if test="${!empty sessionScope['SPRING_SECURITY_LAST_EXCEPTION']}">
		        	<div class="alert alert-danger">
		        		Invalid company name or password
		        	</div>
				</c:if>
	            <div class="input-group input-sm">
	                <label class="input-group-addon" for="username"><i class="fa fa-user"></i></label>
	                <input type="text" class="form-control" id="name" name="name" placeholder="Enter Username" value="${sessionScope['SPRING_SECURITY_LAST_USERNAME']}" required />               
	            </div>
	            <div class="input-group input-sm">
	                <label class="input-group-addon" for="password"><i class="fa fa-lock"></i></label> 
	                <input type="password" class="form-control" id="password" name="password" placeholder="Enter Password" required />            	
	            </div>	                 
	            <div class="form_group">
					<div class="center">
						<button type="submit" class="btn btn-warning">Login</button>
						<button type="reset" class="btn btn-default">Reset</button>
					</div>
				</div>
	        </form>
		</div>
    </div>
</div>
<jsp:include page="basic/footer.jsp" flush="true" />
</body>
</html>