function del(id) {
	var v = window.confirm('Delete this company？');
	if (v) {
		if (v) {
			window.location.href = 'delete?id=' + id;
		}
	}
}
function search(isEdit)
{
	var name=document.getElementById('searchInput').value;
	window.location.href = 'list?name='+name+"&isEdit="+isEdit;
}

jQuery(function($){
	$('.table').footable({
		"filtering": {
			"enabled": true
		}
	});
});
jQuery(function($){
		$('#companyList').footable();
});

