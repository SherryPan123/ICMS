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
	alert($('#addFareForm').serialize()) ;
	$.ajax({
		cache:true ,
		type :"POST",
		url: context+'/fare/addJSON',
		data :$('#addFareForm').serialize(),
		async:true,
		success:function(data)
		{
			window.location.href="list" ;
		},
		error : function(request) {
			$('#addErrorMsg').html("<font color='red'>Failed!</font>");
		},
		dataType:"json"
	});
	return false ;
}