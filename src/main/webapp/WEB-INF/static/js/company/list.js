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
function pageGo(totalPage,isEdit,type)
{
	var page;
	var currentPage = document.getElementById('currentPage').value;
	if(type==0)page = document.getElementById('currentPage').value;
	else if(type==1)page=currentPage-1;
	else if(type==2)page=currentPage+1;
	else if(type==3)page=1;
	else page=totalPage;
	page = page>totalPage?totalPage:page;
	page = page<1?1:page;
	window.location.href = 'list?page='+page+'&isEdit='+isEdit;
}
function search(isEdit)
{
	var name=document.getElementById('searchInput').value;
	window.location.href = 'list?name='+name+"&isEdit="+isEdit;
}


