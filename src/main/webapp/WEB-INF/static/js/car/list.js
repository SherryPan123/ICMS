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
