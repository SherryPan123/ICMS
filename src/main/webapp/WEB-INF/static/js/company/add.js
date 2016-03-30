function confirm_password() {
	var submit = document.getElementById("submit");
	var password = document.getElementById("password").value;
	var cpassword = document.getElementById("cpassword").value;
	var confirm_result = document.getElementById("confirm_result");
	if (password == "" || cpassword == "") {
<<<<<<< HEAD
		submit.setAttribute('disabled', 'disabled');
=======
		submit.setAttribute('disabled');
>>>>>>> origin/kj
		confirm_result.innerHTML = "<font color=red>The Password and Confirm password can't be empty!</font><br/>";
		return false;
	} else {
		submit.removeAttribute('disabled');
		confirm_result.innerHTML = "<br/>";
	}
	if (password == cpassword) {
		submit.removeAttribute('disabled');
		confirm_result.innerHTML = "<font color=green>The Password is the same as Confirm Password!</font><br/>"
		return true;
	} else {
<<<<<<< HEAD
		submit.setAttribute('disabled', 'disabled');
=======
		submit.setAttribute('disabled');
>>>>>>> origin/kj
		confirm_result.innerHTML = "<font color=red>The Password must be the same as Confirm Password!</font><br/>"
		return false;
	}
}

var xmlHttpReq;
// 创建一个xmlHttpRequest
function createXmlHttpRequest() {
	if (window.XMLHttpRequest)
		xmlHttpReq = new XMLHttpRequest();// 非IE浏览器
	else
		xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
}
// 检测用户名是否被注册
function checkName() {
	var submit = document.getElementById("submit");
	var name = document.getElementById("name").value;
	if (name == "") {
<<<<<<< HEAD
		result.innerHTML = "<font color=red>The name can't be empty!</font><br>";
		submit.setAttribute('disabled', 'disabled');
=======
		result.innerHTML = "<font color=red>The Name can't be empty!</font><br>";
		submit.setAttribute('disabled');
>>>>>>> origin/kj
		return false;
	} else {
		result.innerHTML = "";
	}
	createXmlHttpRequest();
	xmlHttpReq.onreadystatechange = handle;
<<<<<<< HEAD
	var url = context + "/company/check?name=" + name +"&id="; // 绝对路径：
=======
	var url = "/icms/company/check?name=" + name +"&id="; // 绝对路径：
>>>>>>> origin/kj
												// /项目名/check_update?name=""&id=""
	xmlHttpReq.open("get", url, false);
	xmlHttpReq.send(null);
}
// 状态发生改变时回调的函数
function handle() {
	// 准备状态为4
	var submit = document.getElementById("submit");
<<<<<<< HEAD
=======
	var password = document.getElementById("password");
	var cpassword = document.getElementById("cpassword");
>>>>>>> origin/kj
	if (xmlHttpReq.readyState == 4) {
		// 响应状态码为200，一切正常
		if (xmlHttpReq.status == 200) {
			// alert("进入了200");
			var res = xmlHttpReq.responseText;
			var result = document.getElementById("result");
<<<<<<< HEAD
			if (res == "The name is available!") {
				submit.removeAttribute('disabled');
				result.innerHTML = "<font color=green>" + res + "</font><br/>";
			} else {
				result.innerHTML = "<font color=red>" + res + "</font><br/>";
				submit.setAttribute('disabled', 'disabled');
=======
			if (res == "The Name is available!") {
				submit.removeAttribute('disabled');
				password.removeAttribute('disabled');
				cpassword.removeAttribute('disabled');
				result.innerHTML = "<font color=green>" + res + "</font><br/>";
			} else {
				result.innerHTML = "<font color=red>" + res + "</font><br/>";
				submit.setAttribute('disabled');
				password.setAttribute('disabled');
				cpassword.setAttribute('disabled');
>>>>>>> origin/kj
			}
		}
	}
}
