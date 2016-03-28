<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Company - ICMS</title>
<script type="text/javascript">
function confirm_password()
{
	var submit = document.getElementById("submit");
	var password = document.getElementById("password").value;
	var cpassword = document.getElementById("cpassword").value;
	var confirm_result = document.getElementById("confirm_result");
	if(password==""||cpassword=="")
	{
		submit.setAttribute('disabled');
		confirm_result.innerHTML="<font color=red>The Password and Confirm password can't be empty!</font><br/>";
		return false;
	}
	else
	{
		submit.removeAttribute('disabled');
		confirm_result.innerHTML="<br/>";
	}
	if(password==cpassword)
	{
		submit.removeAttribute('disabled');
		confirm_result.innerHTML="<font color=green>The Password is the same as Confirm Password!</font><br/>"
		return true;
	}
	else
	{
		submit.setAttribute('disabled');
		confirm_result.innerHTML="<font color=red>The Password must be the same as Confirm Password!</font><br/>"
		return false;
	}
}

var xmlHttpReq;
//创建一个xmlHttpRequest
function createXmlHttpRequest()
{
	if(window.XMLHttpRequest) xmlHttpReq = new XMLHttpRequest();//非IE浏览器
	else xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
}
//检测用户名是否被注册
function checkName()
{
	var submit = document.getElementById("submit");
	var name = document.getElementById("name").value;
	if(name=="")
	{
		result.innerHTML = "<font color=red>The Name can't be empty!</font><br>";
		submit.setAttribute('disabled');
		return false;
	}
	else
	{
		result.innerHTML = "";
	}
	createXmlHttpRequest();  
	xmlHttpReq.onreadystatechange=handle;
	var url = "/icms/check_add?name="+name; //绝对路径：  /项目名/check_update?name=""&id=""
	xmlHttpReq.open("get",url,false);
	xmlHttpReq.send(null);
}
//状态发生改变时回调的函数
function handle()
{
	//准备状态为4
	var submit = document.getElementById("submit");
	var password = document.getElementById("password");
	var cpassword = document.getElementById("cpassword");
	if(xmlHttpReq.readyState==4)
	{
		//响应状态码为200，一切正常
		if(xmlHttpReq.status==200)
		{
			//alert("进入了200");
			var res = xmlHttpReq.responseText;
			var result = document.getElementById("result");
			if(res=="The Name is available!")
			{
				submit.removeAttribute('disabled');
				password.removeAttribute('disabled');
				cpassword.removeAttribute('disabled');
				result.innerHTML="<font color=green>"+res+"</font><br/>";
			}
			else  
			{
				result.innerHTML="<font color=red>"+res+"</font><br/>";
				submit.setAttribute('disabled');
				password.setAttribute('disabled');
				cpassword.setAttribute('disabled');
			}
		}
	}
}
</script>
</head>
<body >
<form:form method="POST" modelAttribute="company">
Company Name：<form:input path="name" id="name" onchange="checkName()"/> <br> 
<span id="result"></span>  
Password：<form:password path="password" id="password" onchange="confirm_password()"/><br>
Confirm Password：<input type="password" id="cpassword" onchange="confirm_password()"/><br>  
<span id="confirm_result"></span>
Address：<form:input path="address" id="address"/><br> 
Phone:<form:input path="phone" id="phone"/><br>
<input type="submit" value="Submit" id="submit" onmouseover="checkName();confirm_password()"/>   
<input type="reset" value="Reset" id="reset"/> 
</form:form>
</body>
</html>