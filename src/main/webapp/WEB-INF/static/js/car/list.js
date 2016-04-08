function deleteCar(car_id, company_id, status) {
	var v = window.confirm('Delete this car？');
	if (v) {
		if (v) {
			window.location.href = 'delete?car_id=' + car_id + '&company_id?'
					+ company_id + '&status=' + status;
		}
	}
}
function updateCar(car_id, company_id, status) {
	window.location.href = 'update?car_id=' + car_id + '&company_id='
			+ company_id + '&status=' + status;
}

function search(status, isEdit,company_id) {
	var carType = document.getElementById("inputCarType").value;
	var plateNumber = document.getElementById("inputPlateNumber").value;
	window.location.href = 'list?status='+status+'&isEdit='+isEdit+'&carType='+carType+'&searchPlateNumber='+plateNumber+'&company_id='+company_id;
}
jQuery(function($){
	$('.table').footable({
		"filtering": {
			"enabled": true
		}
	});
});
jQuery(function($){
		$('#carList').footable();
});
