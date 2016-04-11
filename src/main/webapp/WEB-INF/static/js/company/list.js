var xmlHttpReq;
// 创建一个xmlHttpRequest
function createXmlHttpRequest() {
	if (window.XMLHttpRequest)
		xmlHttpReq = new XMLHttpRequest();// 非IE浏览器
	else
		xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
}

// 添加用户的判断函数
var flagUsername = false, flagName = false, flagPassword = false; // 用来判断当前表单是否正确
// 检测用户名是否被注册
function checkAddUsername() {
	// alert("uSername");
	var submit = document.getElementById("add_submit");
	var username = document.getElementById("add_username").value;
	var username_result = document.getElementById("add_username_result");
	if (username == "") {
		username_result.innerHTML = "<font color=red>The Username can't be empty!</font><br>";
		submit.setAttribute('disabled', 'disabled');
		flagUsername = false;
		return false;
	} else {
		username_result.innerHTML = "";
	}
	var reg = /^[a-zA-Z]+$/;
	if (reg.test(username) != true) {
		username_result.innerHTML = "<font color=red>The Username Must Be English!</font><br>";
		submit.setAttribute('disabled', 'disabled');
		flagUsername = false;
		return false;
	} else {
		username_result.innerHTML = "";
	}
	createXmlHttpRequest();
	xmlHttpReq.onreadystatechange = add_handle;
	var url = "/icms/company/check?username=" + username + "&id="; // 绝对路径：
	xmlHttpReq.open("get", url, false);
	xmlHttpReq.send(null);
}
// 状态发生改变时回调的函数
function add_handle() {
	// 准备状态为4
	var submit = document.getElementById("add_submit");
	if (xmlHttpReq.readyState == 4) {
		// 响应状态码为200，一切正常
		if (xmlHttpReq.status == 200) {
			// alert("进入了200");
			var res = xmlHttpReq.responseText;
			var username_result = document
					.getElementById("add_username_result");
			if (res == "The Username is available!") {
				username_result.innerHTML = "<font color=green>" + res
						+ "</font><br/>";
				flagUsername = true;
				if (flagUsername && flagName && flagPassword) {
					submit.removeAttribute('disabled');
				}

			} else {
				username_result.innerHTML = "<font color=red>" + res
						+ "</font><br/>";
				submit.setAttribute('disabled', 'disabled');
				flagUsername = false;
			}
		}
	}
}
// 检测公司名字是否为空
function checkAddName() {
	var submit = document.getElementById("add_submit");
	var name = document.getElementById("add_name").value;
	var name_result = document.getElementById("add_name_result");
	if (name == "") {
		flagName = false;
		submit.setAttribute('disabled', 'disabled');
		name_result.innerHTML = "<font color=red>The Company Name can't be empty!</font><br/>";
		return false;
	} else {
		flagName = true;
		name_result.innerHTML = "";
		if (flagUsername && flagName && flagPassword) {
			submit.removeAttribute('disabled');
		}
	}
}

function confirmAddPassword() {
	var submit = document.getElementById("add_submit");
	var password = document.getElementById("add_password").value;
	var cpassword = document.getElementById("add_cpassword").value;
	var confirm_result = document.getElementById("add_confirm_result");
	if (password == "" || cpassword == "") {
		flagPassword = false;
		submit.setAttribute('disabled', 'disabled');
		confirm_result.innerHTML = "<font color=red>The Password and Confirm password can't be empty!</font><br/>";
		return false;
	} else {
		confirm_result.innerHTML = "";
	}
	if (password == cpassword) {
		flagPassword = true;
		if (flagUsername && flagName && flagPassword) {
			submit.removeAttribute('disabled');
		}
		confirm_result.innerHTML = "<font color=green>The Password is the same as Confirm Password!</font><br/>";
	} else {
		flagPassword = false;
		submit.setAttribute('disabled', 'disabled');
		confirm_result.innerHTML = "<font color=red>The Password must be the same as Confirm Password!</font><br/>"
		return false;
	}
}

function del(id, page, name) {
	var v = window.confirm('Delete this company？');
	if (v) {
		if (v) {
			window.location.href = 'delete?id=' + id + '&name=' + name
					+ '&page=' + page;
		}
	}
}
function search(isEdit) {
	var name = document.getElementById('searchInput').value;
	window.location.href = 'list?name=' + name + "&isEdit=" + isEdit;
}

jQuery(function($) {
	$('#companyList').footable();
});

// Add Company Pop
$(document).ready(function() {
	$("#addButton").click(function() {
		$("#addCompany").modal('show');
	});
});
// Add 向后台提交
function add() {
	$.ajax({
		cache : true,
		type : "POST",
		data : $("#addForm").serialize(),
		url : context + '/company/addJSON',
		async : false,
		dataType : 'json',
		success : function(data) {
			setTimeout(function() {
				history.go(0);
			}, 0)
		},
		error : function(request) {

		}

	});
	return false;
}

// update pop up
function updateCarPop(companyId) {
	$.ajax({
		url : context + "/company/getCompanyInJson.html",
		type : "GET",
		data : {
			"companyId" : companyId
		},
		dataType : "json",
		success : function(data) {
			$("#u_id").val(data.id);
			$("#u_username").val(data.username);
			$("#u_name").val(data.name);
			$("#u_password").val(data.password);
			$("#u_cpassword").val(data.password);
			$("#u_address").val(data.address);
			$("#u_phone").val(data.phone);
		},
		error : function(data) {
			alert("error");
		}
	});
	$('#updateCompanyDiv').modal('show');
}
var u_flagUsername = true, u_flagName = true, u_flagPassword = true;
// 检测用户名是否已经被注册
function checkUsername() {
	var submit = document.getElementById("u_submit");
	var username = document.getElementById('u_username').value;
	var id = document.getElementById('u_id').value;
	var username_result = document.getElementById("u_username_result");
	if (username == "") {
		username_result.innerHTML = "<font color=red>"
				+ "Username Can't Be Empty!" + "</font><br/>";
		u_flagUsername = false;
		return false;
	} else {
		username_result.innerHTML = "";
	}
	var reg = /^[a-zA-Z]+$/;
	if (reg.test(username) != true) {
		username_result.innerHTML = "<font color=red>The Username Must Be English!</font><br>";
		u_flagUsername = false;
		return false;
	} else {
		username_result.innerHTML = "";
	}
	createXmlHttpRequest();
	xmlHttpReq.onreadystatechange = handle;
	var url = "/icms/company/check?username=" + username + "&id=" + id; // 绝对路径：
	// /项目名/check_update?name=""&id=""
	xmlHttpReq.open("get", url, false);
	xmlHttpReq.send(null);
}

// 状态发生改变时回调的函数
function handle() {
	// 准备状态为4
	var submit = document.getElementById("u_submit");
	if (xmlHttpReq.readyState == 4) {
		// 响应状态码为200，一切正常
		if (xmlHttpReq.status == 200) {
			// alert("进入了200");
			var res = xmlHttpReq.responseText;
			var username_result = document.getElementById("u_username_result");
			if (res == "The Username is available!") {
				username_result.innerHTML = "<font color=green>" + res
						+ "</font><br/>";
				u_flagUsername = true;
			} else {
				username_result.innerHTML = "<font color=red>" + res
						+ "</font><br/>";
				u_flagUsername = false;
			}
		}
	}
}
// 确认密码一致
function confirm_password() {
	var submit = document.getElementById("u_submit");
	var password = document.getElementById("u_password").value;
	var cpassword = document.getElementById("u_cpassword").value;
	var confirm_result = document.getElementById("u_confirm_result");
	if (password == "" || cpassword == "") {
		confirm_result.innerHTML = "<font color=red>The Password and Confirm password can't be empty!</font><br/>";
		u_flagPassword = false;
		return false;
	} else {
		confirm_result.innerHTML = "";
		if (u_flagUsername && u_flagName && u_flagPassword)
			submit.removeAttribute('disabled');
	}
	if (password == cpassword) {
		confirm_result.innerHTML = "<font color=green>The Password is the same as Confirm Password!</font><br/>";
		u_flagPassword = true;
	} else {
		u_flagPassword = false;
		confirm_result.innerHTML = "<font color=red>The Password must be the same as Confirm Password!</font><br/>";
	}
}
// 检测公司名字是否为空
function checkName() {
	var submit = document.getElementById("u_submit");
	var name = document.getElementById("u_name").value;
	var name_result = document.getElementById("u_name_result");
	if (name == "") {
		u_flagName = false;
		name_result.innerHTML = "<font color=red>The Company Name can't be empty!</font><br/>";
		return false;
	} else {
		u_flagName = true;
		name_result.innerHTML = "";
	}
}
function updateCompany() {
	u_flagUsername = u_flagName = u_flagPassword = true;
	checkUsername();
	checkName();
	confirm_password();
	if (!(u_flagUsername && u_flagName && u_flagPassword))
		return false;

	$.ajax({
		cache : true,
		type : "POST",
		url : context + '/company/addJSON',
		data : $('#updateCompanyForm').serialize(),
		async : false,
		dataType : "json",
		error : function(request) {
			$('#u_addErrorMsg').html("<font color='red'>Failed!</font>");
		},
		success : function(data) {
			if (data.success) {
				history.go(0);
			} else {
				$('#u_addErrorMsg').html("<font color='red'>Failed!</font>");
			}
		}
	});
	return false;
}
