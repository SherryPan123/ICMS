function pageGo(page, totalPage, type, isEdit, status, company_id)
{
	var currentPage = document.getElementById('currentPage').value;
	var searchPlateNumber = document.getElementById('searchPlateNumber').value;
	var carType = document.getElementById('carType').value;
	if (type == 'first')
		page = 1;
	else if (type == 'previous')
		page--;
	else if (type == 'go')
		page = currentPage;
	else if (type == 'next')
		page++;
	else
		page = totalPage;
	page = page < 1 ? 1 : page;
	page = page > totalPage ? totalPage : page;
	var url =  'list?page=' + page + '&isEdit=' + isEdit
	+ '&status=' + status + '&company_id=' + company_id;
	if(searchPlateNumber!="" )
	{
		url=url+'&searchPlateNumber'+searchPlateNumber;
	}
	if(carType!="")
	{
		url=url+'&carType'+carType;
	}
	
	window.location.href =url;
}
function changeStatus(status, isEdit) {
	window.location.href = "list?isEdit=" + isEdit + "&status=" + status;
}
// 进入编辑页面
function edit(page, totalPage, isEdit, status, company_id) {
	window.location.href = 'list?page=' + page + '&totalPage=' + totalPage
			+ '&isEdit=' + isEdit + '&status=' + status + '&company_id='
			+ company_id;
}
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

function search(status, isEdit) {
	var carType = document.getElementById("inputCarType").value;
	var plateNumber = document.getElementById("inputPlateNumber").value;
	window.location.href = 'list?status='+status+'&isEdit='+isEdit+'&carType='+carType+'&searchPlateNumber='+plateNumber;
}
