$(".loginFormBox_form").on("submit", function (e) {
    if (!this.checkValidity()) {
        e.preventDefault()
        e.stopPropagation()
    }
    $(this).addClass('was-validated');
})