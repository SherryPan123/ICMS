<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<nav class="navbar navbar-default navbar-fixed-top height54"
	style="opacity: 75%;">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand navbar-collapse collapse height54" href="#"><img
				class="nav-icon" src="<c:url value="/img/sovappslogo.png" />"></a>
		</div>

		<div id="navbar" class="navbar-collapse collapse"
			aria-expanded="false" style="height: 1px;">
			<ul class="nav navbar-nav ">
				<li><a href="${context}" class="height54">ICMS</a></li>
				<c:if test="${currentUser.getUsername()!='ICMS'}">
				<li><a href="${context}" class="nav-icon" title="Home"><span
						class="glyphicon glyphicon-home label_tag"></span></a></li>
				</c:if>
				<c:if test="${currentUser.getUsername()=='ICMS'}">
				<li><a href="${context}/company/list" class="nav-icon" title="Home"><span
						class="glyphicon glyphicon-home label_tag"></span></a></li>
				</c:if>
				<li><a href="${context}/car/list" class="nav-icon" title="Car Management"><span
						class="glyphicon glyphicon-bed label_tag" aria-hidden="true"></span></a></li>
				<li><a href="${context}/conditions/list" class="nav-icon" title="Rent Record"><span
						class="glyphicon glyphicon-transfer label_tag" aria-hidden="true"></span></a></li>
				<li><a href="${context}/employee/list" class="nav-icon" title="Employee"><span
						class="glyphicon glyphicon-user label_tag" aria-hidden="true"></span></a></li>
				<li><a href="${context}/fare/list" class="nav-icon" title="Car Fare"><span
						class="glyphicon glyphicon-piggy-bank label_tag"
						aria-hidden="true"></span></a></li>
				<li><a href="${context}/accident/list" class="nav-icon" title="Traffic Accident"><span
						class="glyphicon glyphicon-fire label_tag" aria-hidden="true"></span></a></li>

				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false" style="height: 54px;">Github<span
						class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="https://github.com/CrowCifer" target=_blank>CrowCifer</a></li>
						<li><a href="https://github.com/Consege" target=_blank>Consege</a></li>
						<li><a href="https://github.com/SherryPan123" target=_blank>Sherry Pan</a></li>
					</ul></li>
				<li><a href="javascript:void(0);" id="btnContact"
					class="nav-icon" style="height: 54px;">Contact/Support</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<sec:authorize access="isAuthenticated()">
					<li class="dropdown"><a href="#"
						class="dropdown-toggle height54" data-toggle="dropdown"
						role="button" aria-haspopup="true" aria-expanded="false"><sec:authentication
								property="principal.name" /> <span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="${context}/car/list">Car Management</a></li>
							<li><a href="${context}/conditions/list">Rent Record</a></li>
							<li><a href="${context}/accident/list">Traffic Accident</a></li>
							<li role="separator" class="divider"></li>
							<li><a href="#" onclick="logout();">Logout</a></li>
						</ul></li>
				</sec:authorize>
				<sec:authorize access="!isAuthenticated()">
				  <li><a href="javascript:void(0);" id="btnLogin" class="height54">Login</a></li>
				</sec:authorize>
			</ul>
		</div>
		<!--/.nav-collapse -->
	</div>
	<!--/.container-fluid -->
</nav>

