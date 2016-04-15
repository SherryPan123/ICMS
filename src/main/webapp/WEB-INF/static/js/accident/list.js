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
	if(!u_checkDate())
	{
		return false;
	}
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

//对日期格式进行验证，不能使用未来的时间
Date.prototype.format = function(format) {
	var o = {
		"M+" : this.getMonth() + 1, // month
		"d+" : this.getDate(), // day
		"h+" : this.getHours(), // hour
		"m+" : this.getMinutes(), // minute
		"s+" : this.getSeconds(), // second
		"q+" : Math.floor((this.getMonth() + 3) / 3), // quarter
		"S" : this.getMilliseconds()
	// millisecond
	}
	if (/(y+)/.test(format))
		format = format.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	for ( var k in o)
		if (new RegExp("(" + k + ")").test(format))
			format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k]
					: ("00" + o[k]).substr(("" + o[k]).length));
	return format;
}

function u_checkDate()
{
	var date = document.getElementById("u_date").value ;
	var myDate = new Date().format('yyyy-MM-dd');
	var date_result =document.getElementById("u_date_result");
	
	if(date == ""){
		$('#u_date_result').html("<font style='color:#a94442; font-size:12px; font-weight: 400'>Date can't be empty!</font>") ;
		return false ;
	}else{
		if (myDate >= date) {
			date_result.innerHTML = "";
			return true;
		} else {
			date_result.innerHTML = "<font style='color:#a94442; font-size:12px; font-weight: 400'>Please use the past time!</font>";
			return false;
		}
	}
}