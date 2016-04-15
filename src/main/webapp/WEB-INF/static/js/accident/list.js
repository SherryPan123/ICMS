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
	var isEdit=$("#isEdit").val();
	$.ajax({
		cache:true ,
		type:"POST",
		url:context+'/accident/addJSON',
		data: $('#addAccidentForm').serialize(),
		async:true,
		success:function(data)
		{
			window.location.href="list?isEdit="+isEdit+"" ;
		},
		error:function(request) {
			$('#addErrorMsg').html("<font color='red'>Failed!</font>");
		},
		dataType:"json" 
	});
	return false ;
}

//Update Pop
function updateAccidentPop(accidentId)
{
	
	$.ajax({
		url : context + "/accident/getAccidentInJson.html",
		type : "GET",
		data : {
			"accidentId" : accidentId
		},
		dataType : "json",
		success:function(returnData) {
			$("#u_id").val(returnData.id);
			$("#u_driverId").text(""+returnData.driverId+"");
			$("#u_driver").text(""+returnData.driver+"");
			$("#u_carModel").text(""+returnData.carModel+"") ;
			$("#u_plateNumber").text(""+returnData.plateNumber+"");
			$("#u_date").val(returnData.date);
			$("#u_company").text(""+returnData.company+"");
			$("#u_description").val(returnData.description);	
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
	var isEdit=$("#isEdit").val();
	//alert($('#updateAccidentForm').serialize()) ;
	$.ajax({
		cache:true ,
		type :"POST",
		url: context+'/accident/submitJSON',
		data :$('#updateAccidentForm').serialize(),
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