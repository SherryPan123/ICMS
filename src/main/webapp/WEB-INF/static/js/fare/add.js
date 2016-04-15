
var flagExpense=false ,flagOperator=false,flagDate=false ,flagPlateNumber=false,flag=false;
//检查Expense是否为空
function checkExpense(){
	var submit = document.getElementById("submit") ;
	var expense = document.getElementById("expense").value ;
	var expense_result =document.getElementById("expense_result");
	if(expense == ""){
		flagExpense = false ;
		submit.setAttribute('disabled','disabled') ;
		$('#expense_result').html ("<font color=red>Expense can't be empty!</font>") ;
		return false ;
	}else{
		flagExpense=true ;
		$('#expense_result').html("") ;
		if(flagExpense && flagOperator && flagDate &&  flagPlateNumber && flag ){
			submit.removeAttribute('disabled') ;
		}
	}
}
//检查Operator是否为空
function checkOperator(){
	var submit = document.getElementById("submit") ;
	var operator = document.getElementById("operator").value ;
	var operator_result =document.getElementById("operator_result");
	if(operator == ""){
		flagOperator = false ;
		submit.setAttribute('disabled','disabled') ;
		$('#operator_result').html ("<font color=red>Operator can't be empty!</font>") ;
		return false ;
	}else{
		flagOperator=true ;
		$('#operator_result').html ("") ;
		if(flagExpense && flagOperator && flagDate &&  flagPlateNumber	&&flag ){
			submit.removeAttribute('disabled') ;
		}
	}
}

//检查Date是否为空
function checkDate(){
	var submit = document.getElementById("submit") ;
	var date = document.getElementById("date").value ;
	var date_result =document.getElementById("date_result");
	if(date == ""){
		flagDate = false ;
		submit.setAttribute('disabled','disabled') ;
		$('#date_result').html ("<font color=red>Date can't be empty!</font>") ;
		return false ;
	}else{
		flagDate=true ;
		$('#date_result').html = "" ;
		if(flagExpense && flagOperator && flagDate  && flagPlateNumber &&flag ){
			submit.removeAttribute('disabled') ;
		}
	}
}

//检查PlateNumber是否为空以及待添加的车是否属于该公司
function checkPlateNumber(){
	var submit = document.getElementById("submit") ;
	var plateNumber = document.getElementById("plateNumber").value ;
	var plateNumber_result =document.getElementById("plateNumber_result");
	if(plateNumber == ""){
		flagplateNumber = false ;
		submit.setAttribute('disabled','disabled') ;
		$('#plateNumber_result').html ("<font color=red>PlateNumber can't be empty!</font>" );
		return false ;
	}else{
		flagPlateNumber=true ;
		var companyId=$("#companyId").val();
		var plateNumber=$("#plateNumber").val();
		delay(function(){
			checkCarInJson(companyId, plateNumber);
		}, 500 );
		
		if(flagExpense && flagOperator && flagDate &&  flagPlateNumber && flag){
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
				if(flagExpense && flagOperator && flagDate &&  flagPlateNumber	&&flag ){
					submit.removeAttribute('disabled') ;
				}
			}else{
				carId.val("");
				flag = false ;
				submit.setAttribute('disabled','disabled') ;
				$('#plateNumber_result').html("<font color=red>Car not found in this company!</font>") ;
			}
		},
		dataType:"json"
	});
};

