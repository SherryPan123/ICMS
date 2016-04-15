//validate employee form
function employee_validate() {
	$.ajax({
		cache : true,
		type : "POST",
		url : context + '/employee/submitJSON.html',
		data : $('#addEmployeeForm').serialize(),
		async : true,
		error : function(request) {
			$('#addErrorMsg').html("<font color='red'>Failed!</font>");
		},
		success : function(data) {
			if (data.success) {
				history.go(0);
			} else {
				$('#addErrorMsg').html("<font color='red'> " + data.msg + "</font>");
			}
		},
		dataType : "json"
	});
	return false;
}

//add employee pop up
$(document).ready(function(){
    $("#btnAdd").click(function(){
        $("#employeeAddForm").modal('show');
    });
});

jQuery(function($){
	$('#employeeList').footable();
	$('#employee_conditionsList').footable();
	$('#employee_accidentList').footable();
});


