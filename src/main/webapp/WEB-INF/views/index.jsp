<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="basic/include.jsp" flush="true" />
<title>index - ICMS</title>
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
						<small>Feel free to contact us!</small>
						<div class="spacer"></div>
						<hr class="intro-divider">
					</div>
				</div>
			</div>
			<!-- Page Content -->
			<div class="content-section-b">
				<div>
					<div class="row rowmain main ">
						<c:if test="${currentUser.getUsername()!='ICMS' }">
							<a href="${context}">
								<div class="col-md-4 mycell panel colmain ">
									<div class="spacer"></div>
									<span class="glyphicon glyphicon-home img_tag"></span>
									<h2 class="main">Home</h2>
									<h4>Back To Home Page</h4>
									<div class="spacer"></div>
								</div>
							</a>
						</c:if>
						<c:if test="${currentUser.getUsername()=='ICMS' }">
							<a href="${context}/company/list">
								<div class="col-md-4 mycell panel colmain ">
									<div class="spacer"></div>
									<span class="glyphicon glyphicon-home img_tag"></span>
									<h2 class="main">Home</h2>
									<h4>Back To Home Page</h4>
									<div class="spacer"></div>
								</div>
							</a>
						</c:if>
						<a href="${context}/car/list">
							<div class="col-md-4 mycell panel colmain">
								<div class="spacer"></div>
								<span class="glyphicon glyphicon-bed img_tag"></span>
								<h2>Car Management</h2>
								<h4>Make Car Management More Easily</h4>
								<div class="spacer"></div>
							</div>
						</a>
						<a href="${context}/conditions/list">
							<div class="col-md-4 mycell panel colmain">
								<div class="spacer"></div>
								<span class="glyphicon glyphicon-transfer img_tag"></span>
								<h2>Rent Record</h2>
								<h4>Lending And Returning Information of Cars</h4>
								<div class="spacer"></div>
							</div>
						</a>
					</div>

					<div class="spacer"></div>
					<div class="row rowmain main">
						<a href="${context}/employee/list">
							<div class="col-md-4 mycell panel colmain">
								<div class="spacer"></div>
								<span class="glyphicon glyphicon-user img_tag"></span>
								<h2>Employee</h2>
								<h4>Manage Employees Who Borrowed Cars</h4>
								<div class="spacer"></div>
							</div>
						</a>
						<a href="${context}/fare/list">
							<div class="col-md-4 mycell panel colmain">
								<div class="spacer"></div>
								<span class="glyphicon glyphicon-piggy-bank img_tag"></span>
								<h2>Car Fare</h2>
								<h4>Various Car Fare,Maintenance Costs,Premiums,Fuel
									Costs...</h4>
								<div class="spacer"></div>
							</div>
						</a>
						<a href="${context}/accident/list">
							<div class="col-md-4 mycell panel colmain">
								<div class="spacer"></div>
								<span class="glyphicon glyphicon-fire img_tag"></span>
								<h2>Traffic Accident</h2>
								<h4>Record Traffic Accidents</h4>
								<div class="spacer"></div>
							</div>
						</a>
					</div>
					<div class="spacer"></div>
				</div>
			</div>
			<!-- /.intro-header -->
		</div>
	</div>
	<jsp:include page="basic/footer.jsp" flush="true" />
</body>
</html>