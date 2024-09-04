$(function(){
    // modal
    $("#btnLogin").click(function(){
        console.log("로그인 클릭");
        $("#loginModal").show();
    });
    $("#close-modal").click(function(){
        $("#loginModal").hide();
    });
    $(window).on('click', function(event) {
        if ($(event.target).is('#loginModal')) {
            $('#loginModal').hide();
        }
    });
    
    // call modal
    $(".btn-call-modal").click(function(){
    	console.log("글쓰기 버튼");
		$("#btnLogin").trigger("click");
	});
});
