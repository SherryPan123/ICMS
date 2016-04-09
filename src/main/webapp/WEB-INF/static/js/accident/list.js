jQuery(function($){
		$('#accidentlist').footable();
});

//Add Accident Pop
$(document).ready(function(){
	$("#addButton").click(function(){
		$("#addAccident").modal('show') ;
	});
});

//Add
function add()
{
	alert($('#addAccidentForm').serialize()) ;
	$.ajax({
		cache:true ,
		type:"POST",
		url:context+'/accident/addJSON',
		data: $('#addAccidentForm').serialize(),
		async:true,
		success:function(data)
		{
			window.location.href="list" ;
		},
		error:function(request) {
			$('#addErrorMsg').html("<font color='red'>Failed!</font>");
		},
		dataType:"json" 
	});
	return false ;
}