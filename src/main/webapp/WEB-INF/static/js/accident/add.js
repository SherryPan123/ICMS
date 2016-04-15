var xmlHttpReq;
var flagDriver=false ,flagDate=false ,flagPlateNumber=false,flag=false , flagEmployee=false;
var driverName ;
//检查PlateNumber是否为空以及待添加的车是否属于该公司
function checkPlateNumber(){
	var submit = document.getElementById("submit") ;
	var plateNumber = document.getElementById("plateNumber").value ;
	var plateNumber_result =document.getElementById("plateNumber_result");
	if(plateNumber == ""){
		flagplateNumber = false ;
		submit.setAttribute('disabled','disabled') ;
		$('#plateNumber_result').html("<font style='color:#a94442; font-size:12px; font-weight: 400'>PlateNumber can't be empty!</font>") ; 
		return false ;
	}else{
		flagPlateNumber=true ;
		var companyId=$("#companyId").val();
		var plateNumber=$("#plateNumber").val();
		delay(function(){
			checkCarInJson(companyId, plateNumber);
		}, 500 );
		
		if(flagDriver && flagEmployee && flagDate &&  flagPlateNumber && flag){
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
		$('#driver_result').html("<font style='color:#a94442; font-size:12px; font-weight: 400's>driver id can't be empty!</font>");
		return false ;
	}else{
		flagDriver=true ;
		var companyId=$("#companyId").val();
		var driverId=$("#driverId").val();
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
		url:context+"/employee/getEmployeeInJson.html",
		data:{"companyId":companyId,"employeeId":driverId},
		success:function(returnData){
			var driverColId=$("#driverColId");
			if(returnData.success){
				driverColId.val(returnData.id) ;
				$('#driver_result').html(returnData.name) ;
				flagEmployee = true; 
				if(flagDriver && flagEmployee && flagDate &&  flagPlateNumber && flag){
					submit.removeAttribute('disabled') ;
				}
			}else{
				flagEmployee=false ;
				submit.setAttribute('disabled','disabled');
				$('#driver_result').html ("<font style='color:#a94442; font-size:12px; font-weight: 400'>Driver not found in this company!</font>") ;
			}
		},
		dataType:"json"
	});
};
//检查该辆车是否属于该公司
var checkCarInJson = function(companyId,plateNumber){
	$.ajax({
		url:context+"/car/getCarInJson.html",
		data:{"companyId":companyId,"plateNumber":plateNumber},
		success:function(returnData){
			var carId = $("#carId");
			var carType = $("#carType");				
			if(returnData.success){
				carId.val(returnData.id);
				$('#plateNumber_result').html("") ;
				flag = true; 
				if(flagDriver && flagEmployee && flagDate &&  flagPlateNumber && flag){
					submit.removeAttribute('disabled') ;
				}
			}else{
				carId.val("");
				flag = false ;
				submit.setAttribute('disabled','disabled') ;
				$('#plateNumber_result').html("<font style='color:#a94442; font-size:12px; font-weight: 400'>Car not found in this company!</font>") ;
			}
		},
		dataType:"json"
	});
};

//检查Date是否为空
function checkDate(){
	var submit = document.getElementById("submit") ;
	var date = document.getElementById("date").value ;
	var myDate = new Date().format('yyyy-MM-dd');
	var date_result =document.getElementById("date_result");
	
	if(date == ""){
		flagDate = false ;
		submit.setAttribute('disabled','disabled') ;
		$('#date_result').html("<font style='color:#a94442; font-size:12px; font-weight: 400'>Date can't be empty!</font>") ;
		return false ;
	}else{
		if (myDate >= date) {
			flagDate = true;
			date_result.innerHTML = "";
			if(flagDriver && flagEmployee && flagDate &&  flagPlateNumber && flag)
				submit.removeAttribute('disabled');
		} else {
			flagDate = false;
			date_result.innerHTML = "<font style='color:#a94442; font-size:12px; font-weight: 400'>Please use the past time!</font>";
			submit.setAttribute('disabled', 'disabled');
		}
	}
}
//对日期格式进行验证，不能使用未来的时间
Date.prototype.format = function(format) {
	var o = {
		"M+" : this.getMonth() + 1, // month
		"d+" : this.getDate(), // day
		"h+" : this.getHours(), // hour
		"m+" : this.getMinutes(), // minute
		"s+" : this.getSeconds(), // second
		"q+" : Math.floor((this.getMonth() + 3) / 3), // quarter
		"S" : this.getMilliseconds()
	// millisecond
	}
	if (/(y+)/.test(format))
		format = format.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	for ( var k in o)
		if (new RegExp("(" + k + ")").test(format))
			format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k]
					: ("00" + o[k]).substr(("" + o[k]).length));
	return format;
}