$(function(){
    $("#close-modal").click(function(){
        $("#loginModal").hide();
    });
    $(window).on('click', function(event) {
        if ($(event.target).is('#loginModal')) {
            $('#loginModal').hide();
        }
    });
    // modal
});
