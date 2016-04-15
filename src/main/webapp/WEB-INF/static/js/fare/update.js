
var u_flagExpense=true ,u_flagOperator=true,u_flagDate=true ,u_flagPlateNumber=true,u_flag=true;
//检查Expense是否为空
function u_checkExpense(){
	var u_submit = document.getElementById("u_submit") ;
	var u_expense = document.getElementById("u_expense").value ;
	var u_expense_result =document.getElementById("u_expense_result");
	if(u_expense == ""){
		u_flagExpense = false ;
		u_submit.setAttribute('disabled','disabled') ;
		$('#u_expense_result').html ("<font style='color:#a94442; font-size:12px; font-weight: 400'>Expense can't be empty!</font>") ;
		return false ;
	}else{
		u_flagExpense=true ;
		$('#u_expense_result').html("") ;
		if(u_flagExpense && u_flagOperator && u_flagDate &&  u_flagPlateNumber && u_flag ){
			u_submit.removeAttribute('disabled') ;
		}
	}
}
//检查Operator是否为空
function u_checkOperator(){
	var u_submit = document.getElementById("u_submit") ;
	var u_operator = document.getElementById("u_operator").value ;
	var u_operator_result =document.getElementById("u_operator_result");
	if(u_operator == ""){
		u_flagOperator = false ;
		u_submit.setAttribute('disabled','disabled') ;
		$('#u_operator_result').html ("<font style='color:#a94442; font-size:12px; font-weight: 400'>Operator can't be empty!</font>") ;
		return false ;
	}else{
		u_flagOperator=true ;
		$('#u_operator_result').html ("") ;
		if(u_flagExpense && u_flagOperator && u_flagDate &&  u_flagPlateNumber	&&u_flag ){
			u_submit.removeAttribute('disabled') ;
		}
	}
}

//检查Date是否为空
function u_checkDate(){
	var u_submit = document.getElementById("u_submit") ;
	var u_date = document.getElementById("u_date").value ;
	var myDate = new Date().format('yyyy-MM-dd');
	var u_date_result =document.getElementById("u_date_result");
	if(u_date == ""){
		u_flagdate = false ;
		u_submit.setAttribute('disabled','disabled') ;
		$('#u_date_result').html ("<font style='color:#a94442; font-size:12px; font-weight: 400'>Date can't be empty!</font>") ;
		return false ;
	}else{
		if (myDate >= u_date) {
			u_flagDate = true;
			u_date_result.innerHTML = "";
			if(u_flagExpense && u_flagOperator && u_flagDate  && u_flagPlateNumber &&u_flag )
				u_submit.removeAttribute('disabled');
		} else {
			u_flagDate = false;
			u_date_result.innerHTML = "<font style='color:#a94442; font-size:12px; font-weight: 400'>Please use the past time!</font>";
			u_submit.setAttribute('disabled', 'disabled');
		}		
	}
}

//检查PlateNumber是否为空以及待添加的车是否属于该公司
function u_checkPlateNumber(){
	var u_submit = document.getElementById("u_submit") ;
	var u_plateNumber = document.getElementById("u_plateNumber").value ;
	var u_plateNumber_result =document.getElementById("u_plateNumber_result");
	if(u_plateNumber == ""){
		u_flagplateNumber = false ;
		u_submit.setAttribute('disabled','disabled') ;
		$('#u_plateNumber_result').html ("<font style='color:#a94442; font-size:12px; font-weight: 400'>PlateNumber can't be empty!</font>" );
		return false ;
	}else{
		u_flagPlateNumber=true ;
		var companyId=$("#companyId").val();
		var u_plateNumber=$("#u_plateNumber").val();
		alert(u_plateNumber);
		alert(companyId);
		$('#u_plateNumber_result').html ( "<font style='color:#a94442; font-size:12px; font-weight: 400'>Car not found!</font>") ;
		delay(function(){
			u_checkCarInJson(companyId, u_plateNumber);
		}, 500 );
		
		if(u_flagExpense && u_flagOperator && u_flagDate &&  u_flagPlateNumber && u_flag){
			u_submit.removeAttribute('disabled') ;
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

//检查该辆车是否属于该公司
var u_checkCarInJson = function(companyId,u_plateNumber){
	$.ajax({
		url:context+"/car/getCarInJson.html",
		data:{"companyId":companyId,"plateNumber":u_plateNumber},
		success:function(returnData){
			var carId = $("#carId");
			var carType = $("#carType");				
			if(returnData.success){
				carId.val(returnData.id);
				$('#u_plateNumber_result').html("") ;
				u_flag = true; 
				if(u_flagExpense && u_flagOperator && u_flagDate &&  u_flagPlateNumber	&&u_flag ){
					u_submit.removeAttribute('disabled') ;
				}
			}else{
				carId.val("");
				u_flag = false ;
				u_submit.setAttribute('disabled','disabled') ;
				$('#u_plateNumber_result').html("<font style='color:#a94442; font-size:12px; font-weight: 400'>Car not found in this company!</font>") ;
			}
		},
		dataType:"json"
	});
};

