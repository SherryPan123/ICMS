<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- login pop form css -->
<link href="${context}/css/login_pop.css" rel="stylesheet" type="text/css">

<!-- Footer -->
<footer>
	<div class="container">
		<div class="row" style="text-align: center">
			<div class="col-lg-12">
				<ul class="list-inline">
					<li><a href="javascript:void(0);" id="btnContact2">Contact
							Email / Support</a></li>
				</ul>
				<p class="copyright text-muted small">Copyright &copy; ICMS
					2016. All Rights Reserved</p>
			</div>
		</div>
	</div>
</footer>
<!-- Modal Contact-->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title text-center" id="myModalLabel">Support /
					Contact</h4>
			</div>
			<div class="modal-body">
				<div class="row text-center">
					<strong>Feel free to contact us!</strong>
				</div>

				<div class="row text-center">
					<address>
						<br />Please add the company name, phone number and any other
						relevant information.
					</address>
				</div>
				<div class="row">
					<div class="col-md-2 text-right">
						<img src="${context}/img/sovappslogo.png">
					</div>
					<div class="col-md-10 text-left">
						<address>
							<strong>Pan</strong><br> <a href="mailto:??.com">??.com</a>
							<p></p>
						</address>
					</div>
				</div>
				<div class="row">
					<div class="col-md-2 text-right">
						<img src="${context}/img/sovappslogo.png">
					</div>
					<div class="col-md-10 text-left">
						<address>
							<strong>Lv</strong><br> <a href="??">??</a>
							<p></p>
						</address>
					</div>
				</div>
				<div class="row">
					<div class="col-md-2 text-right">
						<img src="${context}/img/sovappslogo.png">
					</div>
					<div class="col-md-10 text-left">
						<address>
							<strong>kuang</strong><br>
							<p></p>
						</address>
					</div>
				</div>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<!-- login -->
<div class="modal fade" id="loginForm" tabindex="-1" role="dialog"
	aria-labelledby="myLoginLabel">
	<div class="modal-dialog" style="width:500px" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title text-center" id="myLoginLabel">Login</h4>
			</div>
			<div class="modal-body">
				<div class="login-form">
					<form id="loginFormName" class="form-horizontal" method="POST" onsubmit="return validate()">
						<sec:csrfInput />
						<span id="errorMsg"></span>
						<div class="form-group input-group">
							<span class="input-group-addon"><i class="fa fa-user"></i></span>
							<input type="text" class="form-control" style="width:92%" id="name" name="name" placeholder="Username"
							value="${sessionScope['SPRING_SECURITY_LAST_USERNAME']}" required />
						</div>
						<div class="form-group input-group">
							<span class="input-group-addon"><i class="fa fa-lock"></i></span>
							<input type="password" class="form-control" style="width:92%" id="password" name="password" placeholder="Password" required />
						</div>
						<div class="form-group col-sm-10 btn-group center">
							<button type="submit" class="btn btn-success">Login</button>
							<button type="reset" class="btn btn-success">Reset</button>
						</div>
					</form>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<script>
function validate(){
	$.ajax({
	    type: "POST",
	    url : context + '/login',
	    data: $("#loginFormName").serialize(),
	    beforeSend: function (xhr) {
	        xhr.setRequestHeader("X-Ajax-call", "true");
	    },
	    success: function(result) {
			if (result == "ok") {
				window.location.assign(context+'/');
			} else if (result == "error") {
				$("#errorMsg").html("<div class='alert alert-danger' style='width: 90%; line-height: 0.5; text-align: center'>Invalid Company Name Or Password.</div>");
	        }
	    }
	});
	return false;
}
</script>