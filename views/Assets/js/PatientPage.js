const navLink = $(".containerNav_link")
navLink.on("click", function () {
    changeButtonClass($(this))
})

async function changeButtonClass(button) {

    if (!button.hasClass("search")) {
        await clearSelection()
        button.toggleClass("containerNav_link--active")
    } else
        clearSelection()
}

async function clearSelection() {
    navLink.each(function () {
        $(this).removeClass("containerNav_link--active");
    });
}