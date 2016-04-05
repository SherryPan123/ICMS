//validate employee form
function employee_validate() {
	var employeeId = $("#employeeId");
	var name = $("#name");
	if("" == employeeId.val()){
		alert("Employee Id Cannot Empty!");
		return false;
	}
	if(name.val() == ""){
		alert("Employee Name Cannot Empty!");
		return false;
	}
}

jQuery(function($){
	$('#employeeList').footable();
});