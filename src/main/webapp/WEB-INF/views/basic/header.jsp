<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<nav class="navbar navbar-default navbar-fixed-top"
	style="opacity: 75%; height: 54px;">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand navbar-collapse collapse" href="#"
				style="height: 54px;"><img class="nav-icon"
				src="<c:url value="/img/sovappslogo.png" />" height="54px"></a>
		</div>

		<div id="navbar" class="navbar-collapse collapse"
			aria-expanded="false" style="height: 1px;">
			<ul class="nav navbar-nav ">
				<li><a href="/icms" class="" style="height: 54px;">ICMS</a></li>
				<li><a href="/icms" class="nav-icon" style="height: 54px;"><span
						class="glyphicon glyphicon-home label_tag"></span></a></li>
				<li><a href="/icms/car/add" class="nav-icon"
					style="height: 54px;"><span
						class="glyphicon glyphicon-bed label_tag" aria-hidden="true"></span></a></li>
				<li><a href="#" class="nav-icon" style="height: 54px;"><span
						class="glyphicon glyphicon-transfer label_tag" aria-hidden="true"></span></a></li>
				<li><a href="#" class="nav-icon" style="height: 54px;"><span
						class="glyphicon glyphicon-user label_tag" aria-hidden="true"></span></a></li>
				<li><a href="#" class="nav-icon " style="height: 54px;"><span
						class="glyphicon glyphicon-piggy-bank label_tag"
						aria-hidden="true"></span></a></li>
				<li><a href="#" class="nav-icon " style="height: 54px;"><span
						class="glyphicon glyphicon-fire label_tag" aria-hidden="true"></span></a></li>

				<li class="dropdown" style="height: 54px;"><a href="#"
					class="dropdown-toggle" data-toggle="dropdown" role="button"
					aria-haspopup="true" aria-expanded="false" style="height: 54px;">Blogs<span
						class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="#" target=_blank>Pan blog</a></li>
						<li><a href="#" target=_blank>Lv blog</a></li>
						<li><a href="#" target=_blank>Kuang blog</a></li>
					</ul></li>
				<li><a href="javascript:void(0);" id="btnContact"
					class="nav-icon " style="height: 54px;">Contact/Support</a></li>

				<li><a href="/icms/login" id="btnLogin" class="nav-icon"
					style="height: 54px;"><i class="fa fa-user"></i>Login</a></li>
				<li><a href="/icms/logout" id="btnLogout" class="nav-icon "
					style="height: 54px;">Logout</a></li>
			</ul>
		</div>
		<!--/.nav-collapse -->
	</div>
	<!--/.container-fluid -->
</nav>

