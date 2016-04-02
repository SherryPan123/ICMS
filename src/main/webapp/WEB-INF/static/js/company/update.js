var xmlHttpReq;
var flagUsername=true,flagName=true,flagPassword=true; //用来判断当前表单是否正确
// 创建一个XmlHttpRequest
function createXmlHttpRequest() {
	if (window.XMLHttpRequest)
		xmlHttpReq = new XMLHttpRequest();// 非IE浏览器
	else
		xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
}
// 检测用户名是否已经被注册
function checkUsername() {
	var submit = document.getElementById("submit");
	var username = document.getElementById('username').value;
	var id = document.getElementById('id').value;
	var username_result = document.getElementById("username_result");
	if (username == "") {
		username_result.innerHTML = "<font color=red>" + "Username Can't Be Empty!"
				+ "</font><br/>";
		submit.setAttribute('disabled','disabled');
		flagUsername=false;
		return false;
	} else {
		username_result.innerHTML = "";
		if(flagUsername&&flagName&&flagPassword)submit.removeAttribute('disabled');
	}
	var reg = /^[a-zA-Z]+$/;
	if(reg.test(username) != true)
	{
		username_result.innerHTML = "<font color=red>The Username Must Be English!</font><br>";
		submit.setAttribute('disabled', 'disabled');
		flagUsername = false;
		return false;
	}
	else
	{
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
	var submit = document.getElementById("submit");
	if (xmlHttpReq.readyState == 4) {
		// 响应状态码为200，一切正常
		if (xmlHttpReq.status == 200) {
			// alert("进入了200");
			var res = xmlHttpReq.responseText;
			var username_result = document.getElementById("username_result");
			if (res == "The Username is available!") {
				username_result.innerHTML = "<font color=green>" + res + "</font><br/>";
				flagUsername=true;
				if(flagUsername&&flagName&&flagPassword)submit.removeAttribute('disabled');
			} else {
				username_result.innerHTML = "<font color=red>" + res + "</font><br/>";
				submit.setAttribute('disabled','disabled');
				flagUsername=false;
<<<<<<< HEAD

=======
>>>>>>> 0534ae4a229a00195a85614edf67cfe6ca58218a
			}
		}
	}
}
// 确认密码一致
function confirm_password() {
	var submit = document.getElementById("submit");
	var password = document.getElementById("password").value;
	var cpassword = document.getElementById("cpassword").value;
	var confirm_result = document.getElementById("confirm_result");
	if (password == "" || cpassword == "") {
		submit.setAttribute('disabled','disabled');
		confirm_result.innerHTML = "<font color=red>The Password and Confirm password can't be empty!</font><br/>";
		flagPassword=false;
		return false;
	} else {
		confirm_result.innerHTML = "";
		if(flagUsername&&flagName&&flagPassword)submit.removeAttribute('disabled');
	}
	if (password == cpassword) {
		confirm_result.innerHTML = "<font color=green>The Password is the same as Confirm Password!</font><br/>";
		flagPassword=true;
		if(flagUsername&&flagName&&flagPassword)submit.removeAttribute('disabled');
	} else {
		flagPassword=false;
<<<<<<< HEAD
		submit.setAttribute('disabled');
=======
		submit.setAttribute('disabled','disabled');
>>>>>>> 0534ae4a229a00195a85614edf67cfe6ca58218a
		confirm_result.innerHTML = "<font color=red>The Password must be the same as Confirm Password!</font><br/>";
	}
}
//检测公司名字是否为空
function checkName()
{
	var submit = document.getElementById("submit");
	var name = document.getElementById("name").value;
	var name_result = document.getElementById("name_result");
	if(name=="")
	{
		flagName=false;
		submit.setAttribute('disabled','disabled');
		name_result.innerHTML = "<font color=red>The Company Name can't be empty!</font><br/>";
		return false;
	}
	else
	{
		flagName=true;
		name_result.innerHTML = "";
		if(flagUsername&&flagName&&flagPassword)submit.removeAttribute('disabled');
	}
<<<<<<< HEAD
}

=======
}
>>>>>>> 0534ae4a229a00195a85614edf67cfe6ca58218a
