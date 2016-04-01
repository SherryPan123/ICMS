//logout
function logout() {
	var data = {};
    data[csrfParameter] = csrfToken;
    $.ajax({
        url: context + '/logout',
        type: "POST",
        data: data,
        success: function(response) {
        	window.location = context;
        }
    });
}

//contact pop up
$(document).ready(function(){
    $("#btnContact").click(function(){
        $("#myModal").modal('show');
    });
     $("#btnContact2").click(function(){
        $("#myModal").modal('show');
    });
});

//login pop up
$(document).ready(function(){
    $("#btnLogin").click(function(){
        $("#loginForm").modal('show');
    });
});