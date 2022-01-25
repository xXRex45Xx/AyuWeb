$(".loginFormBox_form").on("submit", function (e) {
    if (!this.checkValidity()) {
        e.preventDefault()
        e.stopPropagation()
        
    }
    else if ($("#newPassword").val() !== $("#confirmPassword").val()) {
        $("#passwordConfirmationFeedback").html(`Passwords don't match.`)
        $('#confirmPassword').addClass("is-invalid")
        $("#confirmPassword").val("");
        e.preventDefault()
        e.stopPropagation()
    }
    $(this).addClass('was-validated');
})

// $("#newPassword").on("focusout", function (e) {
//     if ($(this).val() !== $("#confirmPassword").val())
//         $("#confirmPassword").removeClass("is-valid").addClass("is-invalid");
//     else
//         $("#confirmPassword").removeClass("is-invalid").addClass("is-valid");
// })

// $("#confirmPassword").on("keypress", function (e) {
//     if ($(this).val() !== $("#password").val())
//         $("#confirmPassword").removeClass("valid").addClass("is-invalid");
//     else
//         $("#confirmPassword").removeClass("is-invalid").addClass("valid");
// })