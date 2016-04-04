var xmlHttpReq;
var flagExpense=false ,flagOperator=false,flagDate=false ,flagPlateNumber=false;
//创建一个xmlHttpRequest
function createXmlHttpRequest() {
	if (window.XMLHttpRequest)
		xmlHttpReq = new XMLHttpRequest();// 非IE浏览器
	else
		xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
}
//检查Expense是否为空
function checkExpense(){
	var submit = document.getElementById("submit") ;
	var expense = document.getElementById("expense") ;
	var expense_result =document.getElementById("expense_result");
	if(expense == ""){
		flagExpense = false ;
		submit.setAttribute('disabled','disabled') ;
		expense_result.innerHTML = "<font color=red>Expense can't be empty!</font><br>" ;
		return false ;
	}else{
		flagExpense=true ;
		expense_result.innerHTML="" ;
		if(flagExpense && flagOperator && flagDate &&  flagPlateNumber ){
			submit.removeAttribute('disabled') ;
		}
	}
}
//检查Operator是否为空
function checkOperator(){
	var sumbit = document.getElementById("submit");
	var operator = document.getElementById("operator");
	var operator_result = document.getElementById("operator_result");
	if(operator==""){
		flagOperator=false ;
		submit.addAttribute('disabled','disabled') ;
		operator_result.innerHTML = "<font color=red>Operator can't be empty!</font><br>" ;
		return false ;
	}else{
		flagOperator=true ;
		operator_result.innerHTML = "" ;
		if(flagExpense && flagOperator && flagDate &&  flagPlateNumber	 ){
			submit.removeAttribute('disabled') ;
		}
	}
}

//检查Date是否为空
function checkDate(){
	var sumbit = document.getElementById("submit");
	var date = document.getElementById("date");
	var date_result = document.getElementById("date_result");
	if(date==""){
		flagDate=false ;
		submit.addAttribute('disabled','disabled') ;
		date_result.innerHTML = "<font color=red>Date can't be empty!</font><br>" ;
		return false ;
	}else{
		flagDate=true ;
		date_result.innerHTML = "" ;
		if(flagExpense && flagOperator && flagDate  && flagPlateNumber ){
			submit.removeAttribute('disabled') ;
		}
	}
}

//检查PlateNumber是否为空
function checkPlateNumber(){
	var sumbit = document.getElementById("submit");
	var plateNumber = document.getElementById("plateNumber");
	var plateNumber_result = document.getElementById("plateNumber_result");
	if(plateNumber==""){
		flagplateNumber=false ;
		submit.addAttribute('disabled','disabled') ;
		plateNumber_result.innerHTML = "<font color=red>PlateNumber can't be empty!</font><br>" ;
		return false ;
	}else{
		flagPlateNumber=true ;
		plateNumber_result.innerHTML = "" ;
		if(flagExpense && flagOperator && flagDate &&  flagPlateNumber ){
			submit.removeAttribute('disabled') ;
		}
	}
}