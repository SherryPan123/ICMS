function pageGo(page,totalPage,type)
{
	var currentPage=document.getElementById('currentPage').value;
	if(type=='first') page=1 ;
	else if(type=='final') page=totalPage;
	else if(type=='go')page = currentPage;
	else if(type=='next')page++;
	else if(type=='pre')page--;
	page=page<1?1:page ;
	page=page>totalPage?totalpage:page; 
	window.location.href='list?page='+page ;
}

jQuery(function($){
	$('.table').footable({
		"filtering": {
			"enabled": true
		}
	});
});
jQuery(function($){
		$('#farelist').footable();
});