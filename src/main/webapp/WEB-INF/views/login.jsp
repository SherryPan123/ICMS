<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta property="og:title" content="information of car manager system" />
<meta property="og:site_name" content="icms" />
<meta property="og:type" content="website" />
<meta property="og:description"
	content="information of car manager system" />
<meta name="description" content="information of car manager system">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="./basic/include.jsp" flush="true" />
<!-- login form -->
<%-- <link href="${context}/css/login.css" rel="stylesheet" type="text/css"> --%>
<title>index - ICMS</title>
</head>
<body>
	<!--  head -->
	<jsp:include page="./basic/header.jsp" flush="true" />

	<!-- page -->
	<div class="intro-header" style="min-height:500px">
		<div class="col-lg-12">
			<div class="intro-message">
				<div class="spacer"></div>
				<div class="spacer"></div>
				<div class="spacer"></div>
				<h1>ICMS</h1>
				<div class="spacer"></div>
				<hr class="intro-divider">
			</div>
		</div>
		<div>
			<div class="col-lg-4">
				<div class="spacer"></div>
			</div>
			<div class="col-lg-4" style="margin-top: -35px">
				<form action="${context}/login" method="POST">
					<sec:csrfInput />
					<c:if test="${!empty sessionScope['SPRING_SECURITY_LAST_EXCEPTION']}">
						<div class="alert alert-danger" style="width: 20%; margin: 20px auto">Invalid company name or password</div>
					</c:if>
					<div class="input-group" style="margin-bottom:10px">
						<label class="input-group-addon" for="username"><i class="fa fa-user"></i></label>
						<input type="text" class="form-control" id="username" name="username" placeholder="Username"
							value="${sessionScope['SPRING_SECURITY_LAST_USERNAME']}" required />
					</div>
					<div class="input-group" style="margin-bottom:10px">
						<label for="password" class="input-group-addon"><i class="fa fa-lock"></i></label> 
						<input type="password" class="form-control" id="password" name="password" 
								placeholder="Password" required />
					</div>
					<div class="input-group" style="margin-left:auto; margin-right:auto; margin-top:20px">
						<button type="submit" class="btn btn-success" style="float:left; width:100px">Login</button>
						<span style="margin-left:10px"></span>
						<button type="reset" class="btn btn-success" style="float:right; width:100px">Reset</button>
					</div>
				</form>
			</div>
			<div class="col-lg-4">
				<div class="spacer"></div>
			</div>
		</div>
		
		<div class="spacer"></div>
		<div class="spacer"></div>
	</div>
	<!-- footer -->
	<jsp:include page="./basic/footer.jsp" flush="true" />
</body>
</html>