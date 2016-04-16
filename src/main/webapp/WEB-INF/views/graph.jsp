<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="basic/include.jsp" flush="true" />
<jsp:include page="basic/table.jsp" flush="true" />

<title>graph - ICMS</title>
<script type="text/javascript">
$(function () {
	$('#conditionsChart').highcharts({
		chart: {
            type: 'line'
        },
		title: {
            text: 'Monthly Car Rent Record',
            x: -20 //center
        },
        subtitle: {
            text: 'Source: company',
            x: -20
        },
        xAxis: {
            categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
        },
        yAxis: {
            title: {
                text: 'Times'
            }
        },
        plotOptions: {
            line: {
                dataLabels: {
                    enabled: true
                },
                enableMouseTracking: false
            }
        },
        series: [{
            name: ${year},
	        data: [
          		<c:forEach var="conditionsPerMonth" items="${conditionsListThisYear}" varStatus="st">
          			<c:if test="${st.index > 0}">,</c:if> 
	          		${conditionsPerMonth}
	           	</c:forEach>
	        ]
        }, {
            name: ${year-1},
            data: [
             	<c:forEach var="conditionsPerMonth" items="${conditionsListLastYear}" varStatus="st">
             		<c:if test="${st.index > 0}">,</c:if> 
   	          		${conditionsPerMonth}
   	           	</c:forEach>
   	        ]
        }]
	});
});
</script>
</head>
<body>
<script src="${context}/js/chart/highcharts.js"></script>
<script src="${context}/js/chart/exporting.js"></script>

	<jsp:include page="basic/header.jsp" flush="true" />

	<div class="container-fluid container-height">
		<div class="spacer"></div>
		<div class="spacer"></div>
		<div class="row col-md-2">
			<div class="spacer"></div>
		</div>
		<div class="row col-md-9">
			<div class="spacer"></div>
			<div class="spacer"></div>
			<div id="conditionsChart" style="min-height: 300px"></div>
		</div>

		<div class="row col-md-2">
			<div class="spacer"></div>
		</div>
	</div>
	
	<jsp:include page="basic/footer.jsp" flush="true" />
</body>
</html>