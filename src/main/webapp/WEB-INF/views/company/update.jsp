<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>Update Company Info - ICMS</title>
<script type="text/javascript">
var xmlHttpReq;
//创建一个XmlHttpRequest
function createXmlHttpRequest()
{
	if(window.XMLHttpRequest) xmlHttpReq = new XMLHttpRequest();//非IE浏览器
	else xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
}
//检测用户名是否已经被注册
function checkName()
{
	var submit = document.getElementById("submit");
	var name = document.getElementById('name').value;
	var id = document.getElementById('id').value;
	if(name=="")
	{
		result.innerHTML="<font color=red>"+"Company Name Can't Be Empty!"+"</font><br/>";
		submit.setAttribute('disabled');
		return false;
	}
	else
	{
		result.innerHTML="";
		submit.removeAttribute('disabled');
	}
	createXmlHttpRequest();  
	xmlHttpReq.onreadystatechange=handle;
	var url = "/icms/check_update?name="+name+"&id="+id; //绝对路径：  /项目名/check_update?name=""&id=""
	xmlHttpReq.open("get",url,false);
	xmlHttpReq.send(null);
}

//状态发生改变时回调的函数
function handle()
{
	//准备状态为4
	var submit = document.getElementById("submit");
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
				result.innerHTML="<font color=green>"+res+"</font><br/>";
			}
			else  
			{
				result.innerHTML="<font color=red>"+res+"</font><br/>";
				submit.setAttribute('disabled');
			}
		}
	}
}
//确认密码一致
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
		confirm_result.innerHTML="";
		submit.removeAttribute('disabled');
	}
	if(password==cpassword)
	{
		confirm_result.innerHTML="<font color=green>The Password is the same as Confirm Password!</font><br/>";
		submit.removeAttribute('disabled');
	}
	else
	{
		submit.setAttribute('disabled');
		confirm_result.innerHTML="<font color=red>The Password must be the same as Confirm Password!</font><br/>";
	}
}

</script>
</head>
<body>
<form:form method="POST" modelAttribute="company" >
Company Id:<form:input path = "id" value = "${company.id}" readonly="true" id="id"/><br/>
<c:if test="${company.name == 'ICMS'}">
Company Name：<form:input path="name" readonly = "true" value = "${company.name}" id="name"/><br/>
</c:if>
<c:if test="${company.name != 'ICMS'}">
Company Name：<form:input path="name" onchange="checkName()" id = "name" value = "${company.name}"/><br/>
</c:if>
<span id="result"></span>
Password：<form:password path="password" value="${company.password}" id="password" onchange="confirm_password()"/><br/> 
Confirm Password：<form:password path="password" value="${company.password}" id="cpassword" onchange="confirm_password()"/><br/>
<span id="confirm_result"></span> 
Address：<form:input path="address" value="${company.address}" id="address"/><br/>
Phone：<form:input path="phone" value="${company.phone}" id="phone"/><br/>
<input type="submit" value="Submit" id="submit" onmouseover="confirm_password();checkName()" />
<input type="reset" value="Reset"  id="reset"/>
</form:form>
</body>
</html>