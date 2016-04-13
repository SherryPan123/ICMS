
var flagExpense=true ,flagOperator=true,flagDate=true ,flagPlateNumber=true,flag=true;
//检查Expense是否为空
function u_checkExpense(){
	var u_submit = document.getElementById("u_submit") ;
	var u_expense = document.getElementById("u_expense").value ;
	var u_expense_result =document.getElementById("u_expense_result");
	if(u_expense == ""){
		flagExpense = false ;
		u_submit.setAttribute('disabled','disabled') ;
		$('#u_expense_result').html ("<font color=red>Expense can't be empty!</font>") ;
		return false ;
	}else{
		flagExpense=true ;
		$('#u_expense_result').html("") ;
		if(flagExpense && flagOperator && flagDate &&  flagPlateNumber && flag ){
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
		flagOperator = false ;
		u_submit.setAttribute('disabled','disabled') ;
		$('#u_operator_result').html ("<font color=red>Operator can't be empty!</font>") ;
		return false ;
	}else{
		flagOperator=true ;
		$('#u_operator_result').html ("") ;
		if(flagExpense && flagOperator && flagDate &&  flagPlateNumber	&&flag ){
			u_submit.removeAttribute('disabled') ;
		}
	}
}

//检查Date是否为空
function u_checkDate(){
	var u_submit = document.getElementById("u_submit") ;
	var u_date = document.getElementById("u_date").value ;
	var u_date_result =document.getElementById("u_date_result");
	if(u_date == ""){
		flagdate = false ;
		u_submit.setAttribute('disabled','disabled') ;
		$('#u_date_result').html ("<font color=red>Date can't be empty!</font>") ;
		return false ;
	}else{
		flagDate=true ;
		$('#u_date_result').html = "" ;
		if(flagExpense && flagOperator && flagDate  && flagPlateNumber &&flag ){
			u_submit.removeAttribute('disabled') ;
		}
	}
}

//检查PlateNumber是否为空以及待添加的车是否属于该公司
function u_checkPlateNumber(){
	var u_submit = document.getElementById("u_submit") ;
	var u_plateNumber = document.getElementById("u_plateNumber").value ;
	var u_plateNumber_result =document.getElementById("u_plateNumber_result");
	if(u_plateNumber == ""){
		flagplateNumber = false ;
		u_submit.setAttribute('disabled','disabled') ;
		$('#u_plateNumber_result').html ("<font color=red>PlateNumber can't be empty!</font>" );
		return false ;
	}else{
		flagPlateNumber=true ;
		var companyId=$("#companyId").val();
		var u_plateNumber=$("#u_plateNumber").val();
		alert(u_plateNumber);
		alert(companyId);
		$('#u_plateNumber_result').html ( "<font color=red>Car not found!</font>") ;
		delay(function(){
			checkCarInJson(companyId, u_plateNumber);
		}, 500 );
		
		if(flagExpense && flagOperator && flagDate &&  flagPlateNumber && flag){
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
var checkCarInJson = function(companyId,u_plateNumber){
	$.ajax({
		url:context+"/car/getCarInJson.html",
		data:{"companyId":companyId,"plateNumber":u_plateNumber},
		success:function(returnData){
			var carId = $("#carId");
			var carType = $("#carType");				
			if(returnData.success){
				carId.val(returnData.id);
				$('#u_plateNumber_result').html("") ;
				flag = true; 
				if(flagExpense && flagOperator && flagDate &&  flagPlateNumber	&&flag ){
					u_submit.removeAttribute('disabled') ;
				}
			}else{
				carId.val("");
				flag = false ;
				u_submit.setAttribute('disabled','disabled') ;
				$('#u_plateNumber_result').html("<font color=red>Car not found in this company!</font>") ;
			}
		},
		dataType:"json"
	});
};

