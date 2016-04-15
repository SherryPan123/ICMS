var u_flagDriver=true ,u_flagDate=true ,u_flagPlateNumber=true,u_flag=true , u_flagEmployee=true;
//检查PlateNumber是否为空以及待添加的车是否属于该公司
function checkPlateNumber(){
	var submit = document.getElementById("submit") ;
	var plateNumber = document.getElementById("plateNumber").value ;
	var plateNumber_result =document.getElementById("plateNumber_result");
	if(plateNumber == ""){
		u_flagplateNumber = false ;
		submit.setAttribute('disabled','disabled') ;
		$('#plateNumber_result').html("<font color=red>PlateNumber can't be empty!</font>") ; 
		return false ;
	}else{
		u_flagPlateNumber=true ;
		var companyId=$("#companyId").val();
		var plateNumber=$("#plateNumber").val();
		delay(function(){
			checkCarInJson(companyId, plateNumber);
		}, 500 );
		
		if(u_flagExpense && u_flagEmployee && u_flagDate &&  u_flagPlateNumber && u_flag){
			submit.removeAttribute('disabled') ;
		}
	}
}

//检查driverId是否为空以及待添加的员工是否属于该公司
function checkDriverId(){
	var submit = document.getElementById("submit") ;
	var driverId = document.getElementById("driverId").value;
	var driverId_result = document.getElementById("driverId_result") ;
	if(driverId == ""){
		u_flagDriver=false;
		submit.setAttribute('disabled','disabled');
		$('#driverId_result').html("<font color=red>driver id can't be empty!</font>");
		return false ;
	}else{
		u_flagDriver=true ;
		var companyId=$("#companyId").val();
		var driverId=$("#driverId").val();
		delay(function(){
			checkDriverInJson(companyId, driverId);
		}, 500 );
		
		if(u_flagDriver && u_flagEmployee && u_flagDate &&  u_flagPlateNumber && u_flag){
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
			if(returnData.success){
				$('#driverId_result').html("") ;
				u_flagEmployee = true; 
				if(u_flagDriver && u_flagEmployee && u_flagDate &&  u_flagPlateNumber && u_flag){
					submit.removeAttribute('disabled') ;
				}
			}else{
				
				u_flagEmployee=false ;
				submit.setAttribute('disabled','disabled');
				$('#driverId_result').html ("<font color=red>Driver not found in this company!</font>") ;
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
				u_flag = true; 
				if(u_flagDriver && u_flagEmployee && u_flagDate &&  u_flagPlateNumber && u_flag){
					submit.removeAttribute('disabled') ;
				}
			}else{
				carId.val("");
				u_flag = false ;
				submit.setAttribute('disabled','disabled') ;
				$('#plateNumber_result').html("<font color=red>Car not found in this company!</font>") ;
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
		u_flagDate = false ;
		submit.setAttribute('disabled','disabled') ;
		$('#date_result').html("<font color=red>Date can't be empty!</font>") ;
		return false ;
	}else{
		u_flagDate=true ;
		$('#date_result').html("") ;
		if(u_flagDriver && u_flagEmployee && u_flagDate &&  u_flagPlateNumber && u_flag){
			submit.removeAttribute('disabled') ;
		}
	}
}
