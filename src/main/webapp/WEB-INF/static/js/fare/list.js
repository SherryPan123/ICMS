var xmlHttpReq;
var flagExpense=false ,flagOperator=false,flagDate=false ,flagPlateNumber=false,flag=false;
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
	var expense = document.getElementById("expense").value ;
	var expense_result =document.getElementById("expense_result");
	if(expense == ""){
		flagExpense = false ;
		submit.setAttribute('disabled','disabled') ;
		expense_result.innerHTML = "<font color=red>Expense can't be empty!</font><br>" ;
		return false ;
	}else{
		flagExpense=true ;
		expense_result.innerHTML="" ;
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
		operator_result.innerHTML = "<font color=red>Operator can't be empty!</font><br>" ;
		return false ;
	}else{
		flagOperator=true ;
		operator_result.innerHTML = "" ;
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
		date_result.innerHTML = "<font color=red>Date can't be empty!</font><br>" ;
		return false ;
	}else{
		flagDate=true ;
		date_result.innerHTML = "" ;
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
		plateNumber_result.innerHTML = "<font color=red>PlateNumber can't be empty!</font><br>" ;
		return false ;
	}else{
		flagPlateNumber=true ;
		var companyId=$("#companyId").val();
		var plateNumber=$("#plateNumber").val();
		plateNumber_result.innerHTML = "<font color=red>Car not found!</font><br>" ;
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
				plateNumber_result.innerHTML = "" ;
				flag = true; 
				if(flagExpense && flagOperator && flagDate &&  flagPlateNumber	&&flag ){
					submit.removeAttribute('disabled') ;
				}
			}else{
				carId.val("");
				flag = false ;
				submit.setAttribute('disabled','disabled') ;
				plateNumber_result.innerHTML = "<font color=red>Car not found in this company!</font><br>" ;
			}
		},
		dataType:"json"
	});
};

function pageGo(page,totalPage,type)
{
	var currentPage=document.getElementById('currentPage').value;
	if(type=='first') page=1 ;
	else if(type=='final') page=totalPage;
	else if(type=='go')page = currentPage;
	else if(type=='next')page++;
	else if(type=='pre')page--;
	page=page<1?1:page ;
	page=page>totalPage?totalpage:page; 
	window.location.href='list?page='+page ;
}

jQuery(function($){
		$('#farelist').footable();
});

//Add Fare Pop
$(document).ready(function(){
	$("#addButton").click(function(){
	  $("#addFare").modal('show') ;	
	});
});

//Add 
function add()
{
	//alert($("#addForm").serialize()) ;
	$.ajax({
		cache:true ,
		type :"GET",
		data :$("#addForm").serialize(),
		url: context+"/fare/addJSON",
		async:true,
		success:function(data)
		{
			alert(data) ;
			window.location.href="list" ;
		},
		dataType:"text"
	});
	return false ;
}