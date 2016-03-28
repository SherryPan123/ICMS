function del(id) {
	var v = window.confirm('Delete this company？');
	if (v) {
		if (v) {
			window.location.href = 'delete?id=' + id;
		}
	}
}
function update(name) {
	window.location.href = "update?name=" + name;
}
