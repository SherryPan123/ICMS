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