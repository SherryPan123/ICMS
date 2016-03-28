<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="basic/include.jsp" flush="true" />
<title>Error - ICMS</title>
<meta http-equiv="Refresh" content="3;URL=${context}" />
<link href="${context}/css/error.css" rel="stylesheet" type="text/css" />
</head>
<body>
<jsp:include page="basic/header.jsp" flush="true" />
<div class="intro-header">
    <div class="container">
    	<div class="spacer"></div>
        <div class="spacer"></div>
        <div class="spacer"></div>
		<div class="login_form">
			<h3>Error</h3>
			<div class="form_group center">
				<c:if test="${empty msg} ">
					<p>System ERROR!!!</p>
				</c:if>
				<c:if test="${!empty msg}">
					<p>${fn:escapeXml(msg)}</p>
				</c:if>
			</div>
			<div class="form_group">
				<p class="center">Redirect to Home Page after <span id="jumpTo">3</span>s</p>
			</div>
		</div>
		<div class="spacer"></div>
        <div class="spacer"></div>
        <div class="spacer"></div>
        <div class="spacer"></div>
        <div class="spacer"></div>
        <div class="spacer"></div>
	</div>
</div>

<jsp:include page="basic/footer.jsp" flush="true" />
<script type="text/javascript">
  function countDown(secs, surl){
    var jumpTo = document.getElementById('jumpTo');
    jumpTo.innerHTML = secs;
    if (--secs>0) {
      setTimeout("countDown("+secs+",'"+surl+"')", 1000);
    } else {
      location.href = surl;
    }
  }
  countDown(3, context);
</script>
</body>
</html>