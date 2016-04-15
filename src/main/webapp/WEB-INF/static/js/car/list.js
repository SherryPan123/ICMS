var xmlHttpReq;

function createXmlHttpRequest() {
	if (window.XMLHttpRequest)
		xmlHttpReq = new XMLHttpRequest();// 非IE
	else
		xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
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

function search(status, isEdit, company_id) {
	var carType = document.getElementById("inputCarType").value;
	var plateNumber = document.getElementById("inputPlateNumber").value;
	window.location.href = 'list?status=' + status + '&isEdit=' + isEdit
			+ '&carType=' + carType + '&searchPlateNumber=' + plateNumber
			+ '&company_id=' + company_id;
}
// 对日期格式进行验证，不能使用未来的时间
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

jQuery(function($) {
	$('#carList').footable();
});

$(document).ready(function() {
	$("#btnAdd").click(function() {
		$('#carAddDiv').modal('show');
	});
});

/* Add Car */
function addCar() {
	$.ajax({
		cache : true,
		type : "POST",
		url : context + '/car/addJSON.html',
		data : $('#addCarForm').serialize(),
		async : false,
		dataType : "json",
		success : function(data) {
			setTimeout(function() {
				history.go(0);
			}, 0)
		},
		error : function(data) {
			setTimeout(function() {
				history.go(0);
			}, 0)
		}
	});
}

var flagTime = false, flagCarType = false, flagPlateNumber = false;// 用来判断当前表单是否正确

// 检测车牌号是否重复，是否为空
function checkPlateNumber() {
	var submit = document.getElementById("submit");
	var plateNumber = document.getElementById("plateNumber").value;
	var plateNumber_result = document.getElementById("plateNumber_result");

	if (plateNumber == "") {
		plateNumber_result.innerHTML = "<font style='color:#a94442; font-size:12px; font-weight: 400'>The Plate Number Can't Be Empty!</font>";
		flagPlateNumber = false;
		submit.setAttribute('disabled', 'disabled');
		return;
	} else {
		plateNumber_result.innerHTML = "";
	}

	if (plateNumber.length < 5 || plateNumber.lentgh > 10) {
		plateNumber_result.innerHTML = "<font style='color:#a94442; font-size:12px; font-weight: 400'>The length of plateNumber is between 5 and 10!</font>";
		flagPlateNumber = false;
		submit.setAttribute('disabled', 'disabled');
		return;
	} else {
		plateNumber_result.innerHTML = "";
	}
	createXmlHttpRequest();
	xmlHttpReq.onreadystatechange = handle;
	var url = "/icms/car/check?plateNumber=" + plateNumber;
	xmlHttpReq.open("get", url, false);
	xmlHttpReq.send(null);
}

function handle() {
	var submit = document.getElementById("submit");
	if (xmlHttpReq.readyState == 4) {
		if (xmlHttpReq.status == 200) {
			var res = xmlHttpReq.responseText;
			var plateNumber_result = document
					.getElementById("plateNumber_result");
			if (res == "The Plate Number is available!") {
				plateNumber_result.innerHTML = "<font color=green>" + res
						+ "</font><br/>";
				flagPlateNumber = true;
				if (flagCarType && flagTime && flagPlateNumber) {
					submit.removeAttribute('disabled');
				}
			} else {
				plateNumber_result.innerHTML = "<font style='color:#a94442; font-size:12px; font-weight: 400'>" + res
						+ "</font>";
				flagPlateNumber = false;
				submit.setAttribute('disabled', 'disabled');
			}
		}
	}
}

function checkCarType() {
	var carType = document.getElementById("carType").value;
	var carType_result = document.getElementById("carType_result");
	var submit = document.getElementById("submit");
	if (carType == "") {
		carType_result.innerHTML = "<font style='color:#a94442; font-size:12px; font-weight: 400'>Car Type Can't Be Empty!</font>";
		submit.setAttribute('disabled', 'disabled');
		flagCarType = false;
	} else {
		carType_result.innerHTML = "";
		flagCarType = true;
		if (flagCarType && flagTime && flagPlateNumber)
			submit.removeAttribute('disabled');
	}
}
function checkDate() {
	var date = document.getElementById("buyTime").value;
	var submit = document.getElementById("submit");
	if (date.length == 0) {
		flagTime = false;
		$('#time_result').html(
				"<font style='color:#a94442; font-size:12px; font-weight: 400'>Please input the buy time!</font>");
		submit.setAttribute('disabled', 'disabled');
		return false;
	}
	var myDate = new Date().format('yyyy-MM-dd');
	var submit = document.getElementById("submit");
	var time_result = document.getElementById("time_result");
	if (myDate >= date) {
		flagTime = true;
		time_result.innerHTML = "";
		if (flagCarType && flagTime && flagPlateNumber)
			submit.removeAttribute('disabled');
	} else {
		flagTime = false;
		time_result.innerHTML = "<font style='color:#a94442; font-size:12px; font-weight: 400'>Please use the past time!</font>";
		submit.setAttribute('disabled', 'disabled');
	}
}

/* Add Car 结束 */

/* Update Car 开始 */
function getUpdateCar(car_id) {
	$.ajax({
		cache : true,
		type : "GET",
		url : context + '/car/getCarInJsonById.html',
		async : false,
		dataType : "json",
		data : {
			"car_id" : car_id
		},
		success : function(data) {
			$('#u_id').val(data.id);
			$('#u_plateNumber').val(data.plateNumber);
			$('#u_carType').val(data.carType);
			//alert(new Date(data.buyTime));
			$('#u_buyTime').val(new Date(data.buyTime).format('yyyy-MM-dd'));
			if (data.status == 0) {
				// alert(data.status);
				$("input[id='u_carStatus'][value=0]").attr("checked", true);
			} else if (data.status == 1) {
				// alert(data.status);
				$("input[id='u_carStatus'][value=1]").attr("checked", true);
			}
		},
		error : function(data) {
			alert("error");
		}
	});
	$('#carUpdateDiv').modal('show');
}

var u_flagPlateNumber, u_flagTime, u_flagCarType;

function updateCar() {
	u_flagPlateNumber = u_flagTime = u_flagCarType = true;
	u_checkPlateNumber();
	u_checkCarType();
	u_checkDate();
	if (!(u_flagTime && u_flagPlateNumber && u_flagCarType)) {
		// alert("进不去ajax");
		return false;
	} else {
		$.ajax({
			cache : true,
			dataType : "json",
			url : context + '/car/addJSON.html',
			data : $('#updateCarForm').serialize(),
			async : false,
			type : "POST",
			success : function(data) {
				if (data.success) {
					setTimeout(function() {
						history.go(0);
					});
				} else {
					$('#u_addErrorMsg')
							.html("<font color='red'>Failed!</font>");
				}
			},
			error : function() {
				$('#u_addErrorMsg').html("<font color='red'>Failed!</font>");
			}
		});
	}
	return false;
}

// 检测车牌号是否重复，是否为空
function u_checkPlateNumber() {
	var id = document.getElementById("u_id").value;
	var plateNumber = document.getElementById("u_plateNumber").value;
	var plateNumber_result = document.getElementById("u_plateNumber_result");

	if (plateNumber == "") {
		plateNumber_result.innerHTML = "<font style='color:#a94442; font-size:12px; font-weight: 400'>The Plate Number Can't Be Empty!</font>";
		u_flagPlateNumber = false;
		return;
	} else {
		plateNumber_result.innerHTML = "";
	}

	if (plateNumber.length < 5 || plateNumber.lentgh > 10) {
		plateNumber_result.innerHTML = "<font style='color:#a94442; font-size:12px; font-weight: 400'>The length of plateNumber is between 5 and 10!</font>";
		u_flagPlateNumber = false;
		return;
	} else {
		plateNumber_result.innerHTML = "";
	}
	createXmlHttpRequest();
	xmlHttpReq.onreadystatechange = u_handle;
	var url = "/icms/car/check?plateNumber=" + plateNumber + "&id=" + id;
	xmlHttpReq.open("get", url, false);
	xmlHttpReq.send(null);
}

function u_handle() {
	if (xmlHttpReq.readyState == 4) {
		if (xmlHttpReq.status == 200) {
			var res = xmlHttpReq.responseText;
			var plateNumber_result = document
					.getElementById("u_plateNumber_result");
			if (res == "The Plate Number is available!") {
				plateNumber_result.innerHTML = "<font color=green>" + res
						+ "</font>";
				u_flagPlateNumber = true;
			} else {
				plateNumber_result.innerHTML = "<font style='color:#a94442; font-size:12px; font-weight: 400'>" + res
						+ "</font>";
				u_flagPlateNumber = false;
			}
		}
	}
}

function u_checkCarType() {
	var carType = document.getElementById("u_carType").value;
	var carType_result = document.getElementById("u_carType_result");
	if (carType == "") {
		carType_result.innerHTML = "<font style='color:#a94442; font-size:12px; font-weight: 400'>Car Type Can't Be Empty!</font><br/>";
		u_flagCarType = false;
	} else {
		carType_result.innerHTML = "";
		u_flagCarType = true;
	}
}

// 对日期格式进行验证，不能为空，不能是未来时间
function u_checkDate() {
	var date = document.getElementById("u_buyTime").value;
	if (date.length == 0) {
		u_flagTime = false;
		$('#u_time_result').html(
				"<font style='color:#a94442; font-size:12px; font-weight: 400'>Please input the buy time!</font>");
		return false;
	}
	var myDate = new Date().format('yyyy-MM-dd');
	var time_result = document.getElementById("u_time_result");
	if (myDate >= date) {
		u_flagTime = true;
		time_result.innerHTML = "";
	} else {
		u_flagTime = false;
		time_result.innerHTML = "<font style='color:#a94442; font-size:12px; font-weight: 400'>Please use the past time!</font><br/>";
	}
	/*
	 * var reg = /^(\d{4})-(\d{1,2})-(\d{1,2})$/; var submit =
	 * document.getElementById("submit"); var time_result =
	 * document.getElementById("time_result"); if(reg.test(date)) { flagTime =
	 * true; time_result.innerHTML = "";
	 * if(flagCarType&&flagTime&&flagPlateNumber)submit.removeAttribute('disabled'); }
	 * else { flagTime = false; time_result.innerHTML = "<font color =
	 * red>Please use the fromat!</font><br/>";
	 * submit.setAttribute('disabled','disabled'); }
	 */
}
