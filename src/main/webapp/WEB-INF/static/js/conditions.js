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
					carType.html("<font style='color:#a94442; font-size:12px; font-weight: 400'>"+returnData.msg+"</font>");
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
					employeeName.html("<font style='color:#a94442; font-size:12px; font-weight: 400'>No employee found!</font>");
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
	//alert($('#updateConditionsForm').serialize());
	$.ajax({
		cache : true,
		type : "POST",
		url : context + '/conditions/submitJSON.html',
		data : $('#updateConditionsForm').serialize(),
		async : true,
		error : function(request) {
			$('#u_addErrorMsg').html("<div class='alert alert-danger' style='width: 90%; line-height: 0.5; text-align: center'>Failed!</div>");
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
			$("#u_plateNumber").text("("+returnData.plateNumber+")");
			$("#u_carType").text(returnData.carType);
			$("#u_employee_Id").val(returnData.employee_Id);
			$("#u_employeeId").text("("+returnData.employeeNumber+")");
			$("#u_employeeName").text(returnData.employeeName);
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