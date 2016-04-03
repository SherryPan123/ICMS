//bing change event to #plateNumber
function getCar() {
	var plateNumber = $("#plateNumber").val();
	var companyId = $("#companyId").val();   //${companyId}
	delay(function(){
		getCarInJson(companyId, plateNumber);
	}, 500 );
}

//bing change event to #employeeId
function getEmployee() {
	var employeeId = $("#employeeId").val();
	var companyId = $("#companyId").val();   //${companyId}
	delay(function(){
		getEmployeeInJson(companyId, employeeId);
	}, 500 );
}

//delay method
var delay = (function(){
	var timer = 0;
	return function(callback, ms){
		clearTimeout (timer);
		timer = setTimeout(callback, ms);
	};
})();	

//get car id and set carType
var getCarInJson = function(companyId, plateNumber){
		$.ajax({
			url:context+"/car/getCarInJson.html",
			data:{"companyId":companyId,"plateNumber":plateNumber},
			success:function(returnData){
				var carId = $("#carId");
				var carType = $("#carType");				
				if(returnData.success){
					carId.val(returnData.id);
					carType.html(returnData.carType);
				}else{
					carId.val("");
					carType.html("Error:NO Car Found!");
				}
			},
			dataType:"json"
		});
};

//get employee id and set employee name
var getEmployeeInJson = function(companyId, employeeId){
		$.ajax({
			url:context+"/employee/getEmployeeInJson.html",
			data:{"companyId":companyId,"employeeId":employeeId},
			success:function(returnData){
				var employee_Id = $("#employee_Id");
				var employeeName = $("#employeeName");				
				if(returnData.success){
					employee_Id.val(returnData.id);
					employeeName.html(returnData.name);
				}else{
					employee_Id.val("");
					employeeName.html("Error:NO Employee Found!");
				}
			},
			dataType:"json"
		});
};

//validate conditions form
function validate() {
	var carId = $("#carId");
	var employee_Id = $("#employee_Id");
	var lendTime = $("#lendTime");
	if("" == carId.val()){
		alert("Car Cannot Empty!");
		return false;
	}
	if(title.val() == ""){
		alert("Employee Cannot Empty!");
		return false;
	}
	if(lendTime.val() == ""){
		alert("Lend Time Cannot Empty!");
		return false;
	}
}