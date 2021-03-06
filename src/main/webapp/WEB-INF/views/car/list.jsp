<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>List Cars - ICMS</title>
<meta name="viewport"
	content="width = device-width, initial-scale = 1.0, minimum-scale = 1.0, maximum-scale = 1.0, user-scalable = no" />
<jsp:include page="../basic/include.jsp" flush="true" />
<jsp:include page="../basic/table.jsp" flush="true" />
<link href="${context}/css/table.css" rel="stylesheet" type="text/css" />

<style type="text/css">
td {
	text-align: left;
}
</style>

</head>
<script type="text/javascript" src="${context}/js/car/list.js"></script>

<body>
	<jsp:include page="../basic/header.jsp" flush="true" />
	<div class="container-fluid container-height">
		<div class="spacer"></div>
		<div class="spacer"></div>
		<div class="row col-md-2">
			<div class="spacer"></div>
		</div>
		<div class="row col-md-9">
			<div style="width: 100%; text-align: right">
				<!-- 编辑  -->
				<div class="edit_watch_add">
					<c:if test="${currentUser.getUsername()!='ICMS' }">
						<a
							href="list?company_id=${company_id}&isEdit=1&page=${page}&status=${status}&totalPage=${totalPage}"><span
							class="glyphicon glyphicon-pencil" aria-hidden="true"
							style="margin-right: 5px"></span>Edit</a>
						<span style="margin-right: 5px"></span>
						<a
							href="list?company_id=${company_id}&isEdit=0&page=${page}&status=${status}&totalPage=${totalPage}"><span
							class="glyphicon glyphicon-eye-open" aria-hidden="true"
							style="margin-right: 5px"></span>Watch</a>
						<!-- 添加新车  -->
						<noscript>
							<span style="margin-right: 5px"> <a class="blueColor"
								style="color: #337AB7; cursor: pointer"
								href="<c:url value='add?pageStatus=${status}&isEdit=${isEdit}&company_id=${company_id}'/>"><span
									class="glyphicon glyphicon-plus" aria-hidden="true"
									style="margin-right: 5px"></span>Add</a>
							</span>
						</noscript>
						<span style="margin-right: 5px"></span> <a
							href="javascript:void(0)" style="color: #337AB7; cursor: pointer"
							id="btnAdd"> <span class="glyphicon glyphicon-plus"
								aria-hidden="true" style="margin-right: 5px"></span>Add
						</a>
					</c:if>
				</div>
			</div>
			<!-- 导航栏  -->
			<ol class="breadcrumb">
				<li><a href="${context}">Home</a></li>
				<li><a href="${context}/car/list?company_id=${company_id}">Car</a></li>
				<li class="active">${company_name}</li>
			</ol>
			
			<div class="row">
				<div class="col-lg-7">
				</div>
				<!-- 通过Car Type,Plate Number,Buy Time模糊搜索 -->
				<div class="col-lg-2" style="padding-left:1px; padding-right:1px">
					<div class="input-group">
						<input id="inputCarType" class="form-control" value="${carType}" placeholder="Car Type"
						onkeypress="if(event.keyCode==13)search(${status},${isEdit},${company_id})" />
					</div>
				</div>
				<div class="col-lg-2" style="padding-left:1px; padding-right:1px">
					<div class="input-group">
						<input id="inputPlateNumber" class="form-control"placeholder="Plate Number"
						value="${searchPlateNumber}"
						onkeypress="if(event.keyCode==13)search(${status},${isEdit},${company_id})" />
					</div>
				</div>
				<div class="col-lg-1" style="padding-left:2px; padding-right:1px">
					<button type="button" class="btn btn-default" aria-label="Search"
						title="Search" onclick="search(${status},${isEdit},${company_id})">
						<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
					</button>
				</div>
			</div>
			
			<table id="carList" class="table table-striped" data-sorting="true">
				<thead>
					<tr>
						<th data-breakpoints="xs md">Company Name</th>
						<th>Plate Number</th>
						<th>Car Type</th>
						<th data-breakpoints="xs md" class="sort-column">Buy Time</th>
						<th data-type="html"  data-sortable="false" style="padding-bottom: 2px"><span>Status</span>
							<div class="btn-group-vertical">
								<button type="button"
									class="btn btn-link btn-sm dropdown-toggle"
									data-toggle="dropdown">
									<span class="caret"></span>
								</button>
								<ul class="dropdown-menu">
									<c:if test="${status==-1||status==0}">
										<li><a style="padding-left: 5px"
											href="${context}/car/list?isEdit=${isEdit}&status=1&company_id=${company_id}&searchPlateNumber=${searchPlateNumber}&carType=${carType}">
												<button type="button"
													class="btn-link blackColor focus_not_underline">
													<span class="glyphicon glyphicon-ok greenColor"
														aria-hidden="true"></span> &nbsp;&nbsp;可借
												</button>
										</a></li>
									</c:if>
									<c:if test="${status==1||status==-1}">
										<li><a style="padding-left: 5px"
											href="${context}/car/list?isEdit=${isEdit}&status=0&company_id=${company_id}&searchPlateNumber=${searchPlateNumber}&carType=${carType}">
												<button type="button"
													class="btn-link blackColor focus_not_underline">
													<span class="glyphicon glyphicon-minus redColor"
														aria-hidden="true"></span> &nbsp;&nbsp;借出
												</button>
										</a></li>
									</c:if>
									<c:if test="${status!=-1}">
										<li><a style="padding-left: 5px;"
											href="${context}/car/list?isEdit=${isEdit}&status=-1&company_id=${company_id}&searchPlateNumber=${searchPlateNumber}&carType=${carType}">
												<button type="button"
													class="btn-link blackColor focus_not_underline">
													<span class="glyphicon glyphicon-info-sign"
														aria-hidden="true"></span> &nbsp;&nbsp;所有车
												</button>
										</a></li>
									</c:if>
								</ul>
							</div></th>
						<c:if test="${isEdit==1}">
							<th data-type="html" data-sortable="false">Operation</th>
						</c:if>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="car" items="${cars}">
						<tr>
							<td>${car.company.username}</td>
							<td>${car.plateNumber}</td>
							<td>${car.carType}</td>
							<td><fmt:formatDate value="${car.buyTime}"
									pattern="yyyy-MM-dd" /></td>
							<c:choose>
								<c:when test="${car.status==1}">
									<td><label class="greenColor" title="Available">
											&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-ok"
											aria-hidden="true"></span>
									</label></td>
								</c:when>
								<c:otherwise>
									<td><label class="redColor" title="Not Available">
											&nbsp;&nbsp;&nbsp;&nbsp;<span
											class="glyphicon glyphicon-minus" aria-hidden="true"></span>
									</label></td>
								</c:otherwise>
							</c:choose>
							<c:if test="${currentUser.getUsername()!='ICMS'}">
								<c:if test="${isEdit==1}">
									<td><span style="margin-right: 10px"></span>
										<noscript>
											<a title="Update"
												href="update?company_id=${company_id}&status=${status}&car_id=${car.id}"
												class="focus_not_underline"> <span
												class="glyphicon glyphicon-edit" aria-hidden="true"></span>
											</a>
										</noscript> <a title="Update" class="blackColor focus_not_underline" onclick="getUpdateCar(${car.id})"
										style="cursor: pointer"> <span
											class="glyphicon glyphicon-edit" aria-hidden="true"></span>
									</a> <span style="margin-right: 15px"></span> <a class="blackColor"
										onclick="deleteCar(${car.id},${company_id},${status})"
										title="Delete" aria-label="Delete" class="focus_not_underline"
										style="cursor: pointer"> <span
											class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									</a></td>
								</c:if>
							</c:if>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<!--分页 -->
			<div style="width: 100%; text-align: center">
				<nav>
					<ul class="pagination">
						<li><a
							href="?page=1&isEdit=${isEdit}&status=${status}&company_id=${company_id}&searchPlateNumber=${searchPlateNumber}&carType=${carType}"
							aria-label="First"> <span aria-hidden="true">&laquo;</span>
						</a></li>
						<c:if test="${totalPage<5||totalPage==5}">
							<c:forEach var="i" begin="1" end="${page-1}" step="1">
								<li><a
									href="?page=${i}&isEdit=${isEdit}&status=${status}&company_id=${company_id}&searchPlateNumber=${searchPlateNumber}&carType=${carType}">${i}</a></li>
							</c:forEach>
							<li class="active"><a href="#">${page}</a></li>
							<c:forEach var="i" begin="${page+1}" end="${totalPage}" step="1">
								<li><a
									href="?page=${i}&isEdit=${isEdit}&status=${status}&company_id=${company_id}&searchPlateNumber=${searchPlateNumber}&carType=${carType}">${i}</a></li>
							</c:forEach>
						</c:if>
						<c:if test="${totalPage>5}">
							<c:if test="${page<3 || page==3}">
								<c:forEach var="i" begin="1" end="${page-1}" step="1">
									<li><a
										href="?page=${i}&isEdit=${isEdit}&status=${status}&company_id=${company_id}&searchPlateNumber=${searchPlateNumber}&carType=${carType}">${i}</a></li>
								</c:forEach>
								<li class="active"><a href="#">${page}</a></li>
								<c:forEach var="i" begin="${page+1}" end="5" step="1">
									<li><a
										href="?page=${i}&isEdit=${isEdit}&status=${status}&company_id=${company_id}&searchPlateNumber=${searchPlateNumber}&carType=${carType}">${i}</a></li>
								</c:forEach>
							</c:if>
							<c:if test="${page>3}">
								<c:if test="${totalPage-page<2}">
									<c:forEach var="i" begin="${totalPage-4}" end="${page-1}"
										step="1">
										<li><a
											href="?page=${i}&isEdit=${isEdit}&status=${status}&company_id=${company_id}&searchPlateNumber=${searchPlateNumber}&carType=${carType}">${i}</a></li>
									</c:forEach>
									<li class="active"><a href="#">${page}</a></li>
									<c:forEach var="i" begin="${page+1}" end="${totalPage}"
										step="1">
										<li><a
											href="?page=${i}&isEdit=${isEdit}&status=${status}&company_id=${company_id}&searchPlateNumber=${searchPlateNumber}&carType=${carType}">${i}</a></li>
									</c:forEach>
								</c:if>
								<c:if test="${totalPage-page>2 || totalPage-page==2}">
									<c:forEach var="i" begin="${page-2}" end="${page-1}" step="1">
										<li><a
											href="?page=${i}&isEdit=${isEdit}&status=${status}&company_id=${company_id}&searchPlateNumber=${searchPlateNumber}&carType=${carType}">${i}</a></li>
									</c:forEach>
									<li class="active"><a href="#">${page}</a></li>
									<c:forEach var="i" begin="${page+1}" end="${page+2}" step="1">
										<li><a
											href="?page=${i}&isEdit=${isEdit}&status=${status}&company_id=${company_id}&searchPlateNumber=${searchPlateNumber}&carType=${carType}">${i}</a></li>
									</c:forEach>
								</c:if>
							</c:if>
						</c:if>
						<li><a
							href="?page=${totalPage}&isEdit=${isEdit}&status=${status}&company_id=${company_id}&searchPlateNumber=${searchPlateNumber}&carType=${carType}"
							aria-label="Last"> <span aria-hidden="true">&raquo;</span>
						</a></li>
					</ul>
				</nav>
			</div>
			<!--分页结束 -->

		</div>
	</div>
	<!-- add car pop up -->
	<div class="modal fade" id="carAddDiv" tabindex="-1" role="dialog">
		<div class="modal-dialog" style="width: 500px;" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						&times;</button>
					<h4 class="modal-title text-center" id="addCarTitle">Add New
						Car</h4>
				</div>
				<div class="modal-body">
					<div class="form-horizontal form_pop">
						<form:form method="post" modelAttribute="car" id="addCarForm"
							onsubmit="addCar()">
							<form:input id="company_id" type="hidden" path="company.id"
								value="${company_id}" />
							<div class="form-group">
								<label class="col-sm-4 control-label">Plate Number<font class="requereStar">*</font></label>
								<div class="col-sm-8">
									<form:input cssClass="form-control" path="plateNumber"
										id="plateNumber" onchange="checkPlateNumber()" />
									<div id="plateNumber_result" class="row_content"></div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">Car Type<font class="requereStar">*</font></label>
								<div class="col-sm-8">
									<form:input cssClass="form-control" path="carType" id="carType"
										onchange="checkCarType()" />
									<div id="carType_result" class="row_content"></div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">Buy Time<font class="requereStar">*</font></label>
								<div class="col-sm-8">
									<form:input cssClass="form-control" path="buyTime" type="date"
										id="buyTime" onchange="checkDate()" />
									<div id="time_result" class="row_content"></div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label" style="padding-top: 0px;">Status<font class="requereStar">*</font></label>
								<div class="col-sm-8">
									<form:radiobutton path="status" id="carStatus" value="1"
										checked="checked" />
									Available
									<span style="margin-right:12px"></span>
									<form:radiobutton path="status" id="carStatus" value="0" />
									Not Available
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-offset-3 col-sm-9">
									<input class="btn btn-success width100" type="submit"
										value="Submit" id="submit" disabled="disabled" /> 
										<span style="margin-right: 22px"></span> 
										<input type="reset"
										class="btn btn-success width100" value="Reset" id="reset" />
								</div>
							</div>
						</form:form>
					</div>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>

			</div>
		</div>
	</div>

	<!-- update pop up -->
	<div class="modal fade" id="carUpdateDiv" tabindex="-1" role="dialog">
		<div class="modal-dialog" style="width: 500px" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title text-center" id="addCarTitle">Update
						Car Info</h4>
				</div>
				<div class="modal-body">
					<div class="form-horizontal form_pop">
						<span id="u_addErrorMsg"></span>
						<form:form method="post" modelAttribute="car" id="updateCarForm"
							onsubmit="return updateCar()">
							<form:input id="u_company_id" type="hidden" path="company.id"
								value="${company_id}" />
							<form:input id="u_id" type="hidden" path="id" />
							<div class="form-group">
								<label class="col-sm-4 control-label">Plate Number<font class="requereStar">*</font></label>
								<div class="col-sm-8">
									<form:input path="plateNumber" id="u_plateNumber"
										onchange="checkPlateNumber()" cssClass="form-control" />
									<div id="u_plateNumber_result" class="row_content"></div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">Car Type<font class="requereStar">*</font></label>
								<div class="col-sm-8">
									<form:input path="carType" id="u_carType"
										onchange="checkCarType()" cssClass="form-control" />
									<div id="u_carType_result" class="row_content"></div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">Buy Time<font class="requereStar">*</font></label>
								<div class="col-sm-8">
									<form:input path="buyTime" type="date" id="u_buyTime"
										onchange="checkDate()" cssClass="form-control" />
									<div id="u_time_result" class="row_content"></div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label" style="padding-top: 0px;">Status<font class="requereStar">*</font></label>
								<div class="col-sm-8">
									<form:radiobutton path="status" id="u_carStatus" value="1"
										checked="checked" />
									Available
									<span style="margin-right:12px"></span>
									<form:radiobutton path="status" id="u_carStatus" value="0" />
									Not Available<br />
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-offset-3 col-sm-9">
									<input type="submit" class="btn btn-success width100" value="Submit" id="u_submit" /> 
									<span style="margin-right: 22px"></span>
									<input type="reset" class="btn btn-success width100" value="Reset" id="u_reset" />
								</div>
							</div>
						</form:form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-defautl" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	<div class="row col-md-2"></div>
	<jsp:include page="../basic/footer.jsp" flush="true" />
</body>
</html>