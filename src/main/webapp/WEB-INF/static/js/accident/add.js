var xmlHttpReq;
var flagDriver=false ,flagDate=false ,flagPlateNumber=false,flag=false , flagEmployee=false;
//创建一个xmlHttpRequest
function createXmlHttpRequest() {
	if (window.XMLHttpRequest)
		xmlHttpReq = new XMLHttpRequest();// 非IE浏览器
	else
		xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
}
//检查PlateNumber是否为空以及待添加的车是否属于该公司
function checkPlateNumber(){
	var submit = document.getElementById("submit") ;
	var plateNumber = document.getElementById("plateNumber").value ;
	var plateNumber_result =document.getElementById("plateNumber_result");
	if(plateNumber == ""){
		flagplateNumber = false ;
		submit.setAttribute('disabled','disabled') ;
		plateNumber_result.innerHTML = "<font color=red>PlateNumber can't be empty!</font><br>" ;
		return false ;
	}else{
		flagPlateNumber=true ;
		var companyId=$("#companyId").val();
		var plateNumber=$("#plateNumber").val();
		plateNumber_result.innerHTML = "<font color=red>Car not found!</font><br>" ;
		delay(function(){
			checkCarInJson(companyId, plateNumber);
		}, 500 );
		
		if(flagExpense && flagOperator && flagDate &&  flagPlateNumber && flag){
			submit.removeAttribute('disabled') ;
		}
	}
}

//检查driverId是否为空以及待添加的员工是否属于该公司
function checkDriverId(){
	var submit = document.getElementById("submit") ;
	var driverId = document.getElementById("driverId").value;
	var driver_result = document.getElementById("driver_result") ;
	if(driverId == ""){
		flagDriver=false;
		sumbit.setAttribute('disabled','disabled');
		driver_result.innerHTML="<font color=red>driver id can't be empty!</font><br>"
		return false ;
	}else{
		flagDriver=true ;
		var companyId=$("#companyId").val();
		var driverId=$("#driverId").val();
		driver_result.innerHTML = "<font color=red>Driver not found!</font><br>" ;
		delay(function(){
			checkDriverInJson(companyId, driverId);
		}, 500 );
		
		if(flagDriver && flagEmployee && flagDate &&  flagPlateNumber && flag){
			submit.removeAttribute('disabled') ;
		}
	}
	
}
//delay method
var delay = (function(){
	var timer = 0;
	return function(callback, ms){
		clearTimeout (timer);
		timer = setTimeout(callback, ms);
	};
})();

var checkDriverInJson=function(companyId, driverId)
{
	$.ajax({
		url:context+"/employee/checkDriverInJson.html",
		data:{"companyId":companyId,"employeeId":driverId},
		success:function(returnData){
			var employee_Id = $("#employee_Id");
			var employeeName = $("#employeeName");				
			if(returnData.success){
				employee_Id.val(returnData.id);
				employeeName.html(returnData.name);
				driver_result.innerHTML = "" ;
				flagEmployee = true; 
				if(flagDriver && flagEmployee && flagDate &&  flagPlateNumber && flag){
					submit.removeAttribute('disabled') ;
				}
			}else{
				flagEmployee=false ;
				employee_Id.val("");
				submit.setAttribute('disabled','disabled');
				driver_result.innerHTML = "<font color=red>Driver not found in this company!</font><br>" ;
			}
		},
		dataType:"json"
	});
};
//检查该辆车是否属于该公司
var checkCarInJson = function(companyId,plateNumber){
	$.ajax({
		url:context+"/car/checkCarInJson.html",
		data:{"companyId":companyId,"plateNumber":plateNumber},
		success:function(returnData){
			var carId = $("#carId");
			var carType = $("#carType");				
			if(returnData.success){
				carId.val(returnData.id);
				plateNumber_result.innerHTML = "" ;
				flag = true; 
				if(flagDriver && flagEmployee && flagDate &&  flagPlateNumber && flag){
					submit.removeAttribute('disabled') ;
				}
			}else{
				carId.val("");
				flag = false ;
				submit.setAttribute('disabled','disabled') ;
				plateNumber_result.innerHTML = "<font color=red>Car not found in this company!</font><br>" ;
			}
		},
		dataType:"json"
	});
};

//检查Date是否为空
function checkDate(){
	var submit = document.getElementById("submit") ;
	var date = document.getElementById("date").value ;
	var date_result =document.getElementById("date_result");
	if(date == ""){
		flagDate = false ;
		submit.setAttribute('disabled','disabled') ;
		date_result.innerHTML = "<font color=red>Date can't be empty!</font><br>" ;
		return false ;
	}else{
		flagDate=true ;
		date_result.innerHTML = "" ;
		if(flagDriver && flagEmployee && flagDate &&  flagPlateNumber && flag){
			submit.removeAttribute('disabled') ;
		}
	}
}
