//add
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
					employeeName.html("NO Employee Found!");
					submitBtn.setAttribute('disabled','disabled');
				}
			},
			dataType:"json"
		});
};

//-------------------------update------------------------------------
//bing change event to #plateNumber
function u_getCar() {
	var plateNumber = $("#u_plateNumber").val();
	var companyId = $("#u_companyId").val();   //${companyId}
	delay(function(){
		u_getCarInJson(companyId, plateNumber);
	}, 0 );
}

//bing change event to #employeeId
function u_getEmployee() {
	var employeeId = $("#u_employeeId").val();
	var companyId = $("#u_companyId").val();   //${companyId}
	delay(function(){
		u_getEmployeeInJson(companyId, employeeId);
	}, 0 );
}

//get car id and set carType
var u_getCarInJson = function(companyId, plateNumber){
	var submitBtn = document.getElementById("u_submitBtn");
		$.ajax({
			url:context+"/car/getCarInJson.html",
			data:{"companyId":companyId,"plateNumber":plateNumber},
			success:function(returnData){
				var carId = $("#u_carId");
				var carType = $("#u_carType");				
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
var u_getEmployeeInJson = function(companyId, employeeId){
	var submitBtn = document.getElementById("u_submitBtn");
		$.ajax({
			url:context+"/employee/getEmployeeInJson.html",
			data:{"companyId":companyId,"employeeId":employeeId},
			success:function(returnData){
				var employee_Id = $("#u_employee_Id");
				var employeeName = $("#u_employeeName");				
				if(returnData.success){
					employee_Id.val(returnData.id);
					employeeName.html(returnData.name);
					submitBtn.removeAttribute('disabled');
				}else{
					employee_Id.val("");
					employeeName.html("NO Employee Found!");
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
	
	//alert($('#addConditionsForm').serialize());
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

//validate update conditions form
function update_conditions_validate() {
	alert($('#updateConditionsForm').serialize());
	$.ajax({
		cache : true,
		type : "POST",
		url : context + '/conditions/submitJSON.html',
		data : $('#updateConditionsForm').serialize(),
		async : true,
		error : function(request) {
			$('#u_addErrorMsg').html("<font color='red'>Failed!</font>");
		},
		success : function(data) {
			if (data.success) {
				history.go(0);
			} else {
				$('#u_addErrorMsg').html("<font color='red'> " + data.msg + "</font>");
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

//update conditions pop up
function update_conditions_pop(conditionsId){
	$.ajax({
		url:context+"/conditions/getConditionsInJson.html",
		data:{"conditionsId":conditionsId},
		success:function(returnData){
			$("#u_conditionsId").val(returnData.id);
			$("#u_carId").val(returnData.carId);
			$("#u_plateNumber").val(returnData.plateNumber);
			$("#u_employee_Id").val(returnData.employee_Id);
			$("#u_employeeId").val(returnData.employeeNumber);
			$("#u_lendTime").val(returnData.lendTime);
			$("#u_returnTime").val(returnData.returnTime);
			$("#u_companyId").val(returnData.companyId);
		},
		dataType:"json"
	});
	$("#conditionsUpdateForm").modal('show');
}

jQuery(function($){
	$('#conditionsList').footable();
});