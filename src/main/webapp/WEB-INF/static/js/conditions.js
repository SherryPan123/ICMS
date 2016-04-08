//bing change event to #plateNumber
function getCar() {
	var plateNumber = $("#plateNumber").val();
	var companyId = $("#companyId").val();   //${companyId}
	delay(function(){
		getCarInJson(companyId, plateNumber);
	}, 0 );
}

//bing change event to #employeeId
function getEmployee() {
	var employeeId = $("#employeeId").val();
	var companyId = $("#companyId").val();   //${companyId}
	delay(function(){
		getEmployeeInJson(companyId, employeeId);
	}, 0 );
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
	var submitBtn = document.getElementById("submitBtn");
		$.ajax({
			url:context+"/car/getCarInJson.html",
			data:{"companyId":companyId,"plateNumber":plateNumber},
			success:function(returnData){
				var carId = $("#carId");
				var carType = $("#carType");				
				if(returnData.success){
					carId.val(returnData.id);
					carType.html(returnData.carType);
					submitBtn.removeAttribute('disabled');
				}else{
					carId.val("");
					carType.html(returnData.msg);
					submitBtn.setAttribute('disabled','disabled');
				}
			},
			dataType:"json"
		});
};

//get employee id and set employee name
var getEmployeeInJson = function(companyId, employeeId){
	var submitBtn = document.getElementById("submitBtn");
		$.ajax({
			url:context+"/employee/getEmployeeInJson.html",
			data:{"companyId":companyId,"employeeId":employeeId},
			success:function(returnData){
				var employee_Id = $("#employee_Id");
				var employeeName = $("#employeeName");				
				if(returnData.success){
					employee_Id.val(returnData.id);
					employeeName.html(returnData.name);
					submitBtn.removeAttribute('disabled');
				}else{
					employee_Id.val("");
					employeeName.html("Error:NO Employee Found!");
					submitBtn.setAttribute('disabled','disabled');
				}
			},
			dataType:"json"
		});
};

//对日期格式进行大致的验证
function checkDate() {
	 var date = document.getElementById("lendTimeResult").value;
	 var reg = /^(\d{4})-(\d{1,2})-(\d{1,2})$/;
	 var submit = document.getElementById("submit");
	 var lendTimeResult = document.getElementById("lendTimeResult");
	 if(reg.test(date)) {
		 lendTimeResult.innerHTML = "";
		 return true;
	 }
	 else {
		 lendTimeResult.innerHTML = "<font color = red>Please use the fromat!</font><br/>";
		 submit.setAttribute('disabled','disabled');
		 return false;
	}
}

//validate conditions form
function conditions_validate() {
	var carId = $("#carId");
	var employee_Id = $("#employee_Id");
	var lendTime = $("#lendTime");
	
//	if("" == carId.val() || "" == employee_Id.val() || "" == lendTime.val()){
//		$('#addErrorMsg').html("<font color='red'>Invalid Conditions Information</font>" );
//		return false;
//	}
//	if (!checkDate()) return false;
	
	alert($('#addConditionsForm').serialize());
	$.ajax({
		cache : true,
		type : "POST",
		url : context + '/conditions/submitJSON.html',
		data : $('#addConditionsForm').serialize(),
		async : true,
		error : function(request) {
			$('#addErrorMsg').html("<font color='red'>Failed!</font>");
		},
		success : function(data) {
			if (data.success) {
				history.go(0);
			} else {
				$('#addErrorMsg').html("<font color='red'> " + data.msg + "</font>");
			}
		},
		dataType : "json"
	});
	return false;
}

//add conditions pop up
$(document).ready(function(){
    $("#btnAdd").click(function(){
        $("#conditionsAddForm").modal('show');
    });
});

jQuery(function($){
	$('#conditionsList').footable();
});