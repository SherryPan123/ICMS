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
<style type="text/css">
.highcharts-contextmenu div hr {
	margin-top: 5px;
	margin-bottom: 5px;
}
</style>
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
	
	$('#fareChart').highcharts({
		title: {
            text: 'Car Fare chart'
        },
        xAxis: {
            categories: ['Jan', 'Feb', 'Mar', 'Apr']
        },
        labels: {
            items: [{
                html: 'Total Car Fare',
                style: {
                    left: '20px',
                    top: '0px',
                    color: (Highcharts.theme && Highcharts.theme.textColor) || 'black'
                }
            }]
        },
        series: [{
            type: 'column',
            name: '违章罚款',
            data: [
				<c:forEach var="fk" items="${fakuan}" varStatus="st">
					<c:if test="${st.index > 0}">,</c:if> 
					${fk}
				</c:forEach>
			]
        }, {
            type: 'column',
            name: '加油',
            data: [
				<c:forEach var="jy" items="${jiayou}" varStatus="st">
					<c:if test="${st.index > 0}">,</c:if> 
					${jy}
				</c:forEach>
			]
        }, {
            type: 'column',
            name: '维修',
            data: [
   				<c:forEach var="wx" items="${weixiu}" varStatus="st">
					<c:if test="${st.index > 0}">,</c:if> 
					${wx}
				</c:forEach>	
			]
        }, {
            type: 'spline',
            name: '平均值',
            data: [
				<c:forEach var="ag" items="${avg}" varStatus="st">
					<c:if test="${st.index > 0}">,</c:if> 
					${ag}
				</c:forEach>
			],
            marker: {
                lineWidth: 2,
                lineColor: Highcharts.getOptions().colors[3],
                fillColor: 'white'
            }
        }, {
            type: 'pie',
            name: 'Total Fare',
            data: [{
                name: '违章罚款',
                y: ${percent[0]*100},
                color: Highcharts.getOptions().colors[0] // Jane's color
            }, {
                name: '加油',
                y: ${percent[1]*100},
                color: Highcharts.getOptions().colors[1] // John's color
            }, {
                name: '维修',
                y: ${percent[2]*100},
                color: Highcharts.getOptions().colors[2] // Joe's color
            }],
            center: [65, 45],
            size: 100,
            showInLegend: false,
            dataLabels: {
                enabled: false
            }
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
			<div id="conditionsChart" style="min-height: 400px"></div>
			<div id="fareChart" style="min-height: 400px; margin-top: 100px"></div>
		</div>

		<div class="row col-md-2">
			<div class="spacer"></div>
		</div>
	</div>
	
	<jsp:include page="basic/footer.jsp" flush="true" />
</body>
</html>