var xmlHttpReq;

var flagTime=false,flagCarType=false,flagPlateNumber=false;//用来判断当前表单是否正确

function createXmlHttpRequest()
{
	if(window.XMLHttpRequest) xmlHttpReq = new XMLHttpRequest();//非IE
	else xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
}var xmlHttpReq;

var flagTime=true,flagCarType=true,flagPlateNumber=true;//用来判断当前表单是否正确

function createXmlHttpRequest()
{
	if(window.XMLHttpRequest) xmlHttpReq = new XMLHttpRequest();//非IE
	else xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
}
//检测车牌号是否重复，是否为空
function checkPlateNumber()
{
	var submit = document.getElementById("submit");
	var plateNumber = document.getElementById("plateNumber").value;
	var plateNumber_result = document.getElementById("plateNumber_result");
	
	if(plateNumber == "" ) 
	{
		plateNumber_result.innerHTML = "<font color=red>The plate number can't be empty!</font><br/>";
		flagPlateNumber = false;
		submit.setAttribute('disabled','disabled');
		return;
	}
	else
	{
		plateNumber_result.innerHTML = "";
	}

	if( plateNumber.length < 5 || plateNumber.lentgh > 10)
	{
		plateNumber_result.innerHTML = "<font color=red>The length of plateNumber is between 5 and 10!</font><br/>";
		flagPlateNumber = false;
		submit.setAttribute('disabled','disabled');
		return;
	}
	else
	{
		plateNumber_result.innerHTML = "";
	}
	createXmlHttpRequest();
	xmlHttpReq.onreadystatechange = handle;
	var url = "/icms/car/check?plateNumber="+plateNumber;
	xmlHttpReq.open("get",url,false);
	xmlHttpReq.send(null);
}

function handle()
{
	var submit = document.getElementById("submit");
	if( xmlHttpReq.readyState == 4 )
	{
		if(xmlHttpReq.status == 200 )
		{
			var res = xmlHttpReq.responseText;
			var plateNumber_result = document.getElementById("plateNumber_result");
			if(res == "The Plate Number is available!")
			{
				plateNumber_result.innerHTML = "<font color=green>"+res+"</font><br/>";
				flagPlateNumber = true;
				if(flagCarType&&flagTime&&flagPlateNumber)submit.removeAttribute('disabled');
			}
			else
			{
				plateNumber_result.innerHTML = "<font color=red>"+res+"</font><br/>";
				flagPlateNumber = false;
				submit.setAttribute('disabled','disabled');
			}
		}
	}
}

 function checkCarType()
{
	var carType = document.getElementById("carType").value;
	var carType_result = document.getElementById("carType_result");
	var submit = document.getElementById("submit");
	if(carType=="")
	{
		carType_result.innerHTML = "<font color=red>The car type can't be empty!</font><br/>";
		submit.setAttribute('disabled','disabled');
		flagCarType = false;
	}
	else
	{
		carType_result.innerHTML = "";
		flagCarType=true;
		if(flagCarType&&flagTime&&flagPlateNumber)submit.removeAttribute('disabled');
	}
}

 //对日期格式进行大致的验证，不能验证如2012-2-55这样错误的日期
 function checkDate()
 {
	 var date = document.getElementById("buyTime").value;
	 var reg = /^(\d{4})-(\d{1,2})-(\d{1,2})$/;
	 var submit = document.getElementById("submit");
	 var time_result = document.getElementById("time_result");
	 if(reg.test(date))
     {
		 flagTime = true;
		 time_result.innerHTML = "";
		 if(flagCarType&&flagTime&&flagPlateNumber)submit.removeAttribute('disabled');
	 }
	 else
	{
		 flagTime = false;
		 time_result.innerHTML = "<font color = red>Please use the fromat!</font><br/>";
		 submit.setAttribute('disabled','disabled');
	}
 }