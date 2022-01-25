$(".mainNav_userControls").hide()
$(".mainNav_userLink").on("click", function () {
    if(!$(".mainNav_userControls").is(":visible"))
        $(".mainNav_userControls").show(300);
    else
        $(".mainNav_userControls").hide(300)
});