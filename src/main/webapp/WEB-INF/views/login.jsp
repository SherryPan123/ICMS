<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html xmlns:og="http://ogp.me/ns#">
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

<!--   <link href="${context}/css/login.css" rel="stylesheet"> -->
<title>index - ICMS</title>
</head>
<body>
	<!--  head -->
	<jsp:include page="./basic/header.jsp" flush="true" />

	<!-- page -->


	<div class="intro-header">
		<div class="container">

			<div class="row ">
				<div class="col-lg-12">
					<div class="intro-message">
						<div class="spacer"></div>
						<div class="spacer"></div>
						<div class="spacer"></div>
						<div class="spacer"></div>
						<div class="spacer"></div>
						<h1>ICMS</h1>
						<div class="spacer"></div>
						<hr class="intro-divider">
					</div>
				</div>
			</div>
		</div>

		<form action="${context}/login" class="form-horizontal" method="POST"
			modelAttribute="company">
			<sec:csrfInput />
			<c:if test="${!empty sessionScope['SPRING_SECURITY_LAST_EXCEPTION']}">
				<div class="alert alert-danger"
					style="width: 20%; margin: 20px auto">Invalid company name
					or password</div>
			</c:if>
			<div class="input-group login-group">
				<label class="input-group-addon" for="name"><i class="fa fa-user"></i></label> 
				<input type="text" class="form-control" id="name" name="name" placeholder="Username"
					value="${sessionScope['SPRING_SECURITY_LAST_USERNAME']}" required />
			</div>

			<div class="input-group login-group">
				<label for="password" class="input-group-addon"><i class="fa fa-lock"></i></label> 
				<input class="form-control" id="password" name="password" 
						placeholder="Password" required />
			</div>

			<div class="form-group">
				<div class="col-sm-10 btn-group">
					<button type="submit" class="btn btn-success">Login</button>
					<button type="reset" class="btn btn-success">Reset</button>
				</div>
			</div>
		</form>
		<div class="spacer"></div>
		<div class="spacer"></div>
		<div class="spacer"></div>
		<div class="spacer"></div>
		<div class="spacer"></div>



	</div>

	<!-- footer -->
	<jsp:include page="./basic/footer.jsp" flush="true" />
</body>
</html>