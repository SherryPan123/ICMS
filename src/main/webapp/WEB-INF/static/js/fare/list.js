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
	//add按钮
	$("#addButton").click(function(){
	  $("#addFare").modal('show') ;	
	});
});
//Add 
function add()
{
	var carId = $("#carId");
	var expense=$("#expense") ;
	var type =$("#type") ;
	var operator=$("#operator") ;
	var date = $("#date") ;
	var isEdit=$("#isEdit").val();
	//alert($('#addFareForm').serialize()) ;
	$.ajax({
		cache:true ,
		type :"POST",
		url: context+'/fare/addJSON',
		data :$('#addFareForm').serialize(),
		async:true,
		success:function(data)
		{
			window.location.href="list?isEdit="+isEdit+"" ;
		},
		error : function(request) {
			$('#addErrorMsg').html("<font color='red'>Failed!</font>");
		},
		dataType:"json"
	});
	return false ;
}
//Update Fare Pop
function updateFarePop(fareId)
{
	$.ajax({
		url : context + "/fare/getFareInJson.html",
		type : "GET",
		data : {
			"fareId" : fareId
		},
		dataType : "json",
		success:function(returnData) {
			$("#u_id").val(returnData.id);
			$("#u_plateNumber").text(""+returnData.plateNumber+"");
			$("#u_carType").text(""+returnData.carType+"");
			$("#u_fareType").val(returnData.type);
			$("#u_operator").val(returnData.operator);
			$("#u_expense").val(returnData.expense);
			$("#u_date").val(returnData.date);
			$("#u_company").text(""+returnData.company+"");
		},
		error:function(returnData) {
			alert("error");
		}
	});
	$('#updateFareDiv').modal('show');
}

//update Json方式
function update()
{
	//alert($('#updateFareForm').serialize()) ;
	var isEdit=$("#isEdit").val();
	$.ajax({
		cache:true ,
		type :"POST",
		url: context+'/fare/submitJSON',
		data :$('#updateFareForm').serialize(),
		async:true,
		success:function(data)
		{
			window.location.href="list?isEdit="+isEdit+"" ;
		},
		error : function(request) {
			$('#addErrorMsg').html("<font color='red'>Failed!</font>");
		},
		dataType:"json"
	});
	return false ;
}