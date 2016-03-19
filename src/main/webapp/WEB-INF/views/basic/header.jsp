<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<nav class="navbar navbar-default navbar-fixed-top" style="opacity: 75%; height:54px;">
	<div class="container-fluid">
    	<div class="navbar-header">
            <a class="navbar-brand navbar-collapse collapse" href="#" style="height:54px;"><img class="nav-icon" src="<c:url value="/img/sovappslogo.png" />" height="54px"></a>
		</div>
		
		<div id="navbar" class="navbar-collapse collapse" aria-expanded="false" style="height: 1px;">
			<ul class="nav navbar-nav ">
				<li><a href="https://www.sovapps.com" class=""  style="height:54px;">ICMS</a></li>
			    <li><a href="https://www.miaforgmail.com" class="nav-icon" style="height:54px;"><span class="glyphicon glyphicon-home" style="width:24px;"></span></a></li>
			    <li><a href="/preciousdisk" class="nav-icon" style="height:54px;"><span class="glyphicon glyphicon-bed" style="width:24px;" aria-hidden="true"></span></a></li>
			    <li><a href="/lapilule" class="nav-icon" style="height:54px;"><span class="glyphicon glyphicon-transfer" style="width:24px;" aria-hidden="true"></span></a></li>
			    <li><a href="https://www.bmglyph.com" class="nav-icon" style="height:54px;"><span class="glyphicon glyphicon-user" style="width:24px;" aria-hidden="true"></span></a></li>
			    <li><a href="/iceheroes/" class="nav-icon " style="height:54px;"><span class="glyphicon glyphicon-piggy-bank" style="width:24px;" aria-hidden="true"></span></a></li>
			    <li><a href="/puckybirdy" class="nav-icon " style="height:54px;"><span class="glyphicon glyphicon-exclamation-sign glyphicon glyphicon-fire" style="width:24px;" aria-hidden="true"></span></a></li>
			
			    <li class="dropdown" style="height:54px;">
				    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" style="height:54px;">Blogs<span class="caret"></span></a>
				    <ul class="dropdown-menu">
				      <li ><a href="http://blog.sovapps.com/apps/tutorials/" target=_blank>Sovapps blog</a></li>
				      <li ><a href="http://blog.bmglyph.com/tutorials-2"  target=_blank>bmGlyph blog</a></li>
				      <li> <a href="http://blog.lapilule-iphone.com/blog"  target=_blank>La Pilule blog</a></li>
				    </ul>
				</li>
			    <li><a href="javascript:void(0);" id="btnContact" class="nav-icon " style="height:54px;">Contact/Support</a></li>
			</ul>
		</div><!--/.nav-collapse -->
	</div><!--/.container-fluid -->
</nav>

