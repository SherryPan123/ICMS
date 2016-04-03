function del(id) {
	var v = window.confirm('Delete this company？');
	if (v) {
		if (v) {
			window.location.href = 'delete?id=' + id;
		}
	}
}
function update(id) {
	window.location.href = "update?id=" + id;
}
function pageGo(page,totalPage,type,isEdit)
{
	var currentPage = document.getElementById('currentPage').value;
	if(type=='first') page=1;
	else if(type=='last')page--;
	else if(type=='go')page=currentPage;
	else if(type=='next')page++;
	else page=totalPage;
	page=page<1?1:page;
	page=page>totalPage?totalPage:page;
	window.location.href='list?page='+page+'&isEdit='+isEdit;
}

function search(isEdit)
{
	var name=document.getElementById('searchInput').value;
	window.location.href = 'list?name='+name+"&isEdit="+isEdit;
}

