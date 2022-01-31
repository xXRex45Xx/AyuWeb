let selectedPatient = null

$(".containerNav_search").on("click", async function () {
    if (isNaN(parseInt($(".containerNav_searchPhone").val()))) {
        selectedPatient = null
        alert("Please enter a valid phone number!")
        return
    }
    if ($(".containerNav_searchPhone").val() !== "") {
        selectedPatient = null
        await $.ajax({
            type: "GET",
            url: "/management/patientpage/search",
            data: {
                q: $(".containerNav_searchPhone").val()
            },
            dataType: "html",
            success: function (response) {
                $(".mainContainer_subContainer").html(response);

                $(".searchTable tbody tr").on("click", function () {
                    $(".searchTable tbody tr").removeClass("selected");
                    $(this).toggleClass("selected");
                    selectedPatient = parseInt($(".selected > td")[0].innerHTML)
                });
            },
            error: function (error) {
                $(".mainContainer_subContainer").html(error.responseText)
            }
        })

    }
})

$(".containerNav_info").on("click", async function () {
    if (selectedPatient) {
        $.ajax({
            type: "GET",
            url: `/management/patientpage/${selectedPatient}/info`,
            dataType: "html",
            success: function (response) {
                $(".mainContainer_subContainer").html(response);
            },
            error: function (error) {
                $(".mainContainer_subContainer").html(error.responseText);
            }
        })
    }
    else {
        alert("Please, select a patient.")
        $(".containerNav_info").toggleClass("containerNav_link--active")
    }

})

$(".containerNav_payment").on("click", async function () {
    if (selectedPatient) {
        selectedPayment = null;
        $.ajax({
            type: "GET",
            url: `/management/patientpage/${selectedPatient}/payment`,
            dataType: "html",
            success: function (response) {
                $(".mainContainer_subContainer").html(response)

                $(".paymentContainer_pendingTable tbody tr").on("click", function () {
                    $(".paymentContainer_pendingTable tbody tr").removeClass("selectedPayment");
                    $(this).toggleClass("selectedPayment");
                    selectedPayment = parseInt($(".selectedPayment > td")[0].innerHTML)
                });
                $(".paymentContainer_cancel").on("click", function () {
                    if (selectedPayment) {
                        $.ajax({
                            type: "POST",
                            url: `/management/patientpage/${selectedPatient}/payment/${selectedPayment}?_method=DELETE`,
                            dataType: "html",
                            success: function (response) {
                                $(".mainContainer_subContainer").html(response)
                            },
                            error: function (error) {
                                $(".mainContainer_subContainer").html(error.responseText);
                            }
                        });
                    }
                    else
                        alert("Please, select a pending payment.")
                });
            },
            error: function (error) {
                $(".mainContainer_subContainer").html(error.responseText);
            }
        })
    }
    else {
        alert("Please, select a patient.")
        $(".containerNav_payment").toggleClass("containerNav_link--active")
    }
});

$(".containerNav_update").on("click", function () {
    if (selectedPatient) {
        $.ajax({
            type: "GET",
            url: `/management/patientpage/${selectedPatient}/edit`,
            dataType: "html",
            success: function (response) {
                $(".mainContainer_subContainer").html(response);
            },
            error: function (error) {
                $(".mainContainer_subContainer").html(error.responseText);

                $(".updatePatientForm").on("submit", function (e) {
                    if (!this.checkValidity()) {
                        e.preventDefault()
                        e.stopPropagation()
                    }
                    else if (isNaN($("#phoneNo").val())) {
                        $("#phoneNoValidationFeedback").html(`${$('#phoneNo').val()} is not a valid phone number.`)
                        $('#phoneNo').addClass("is-invalid")
                        $('#phoneNo').val("");
                        e.preventDefault()
                        e.stopPropagation()
                    }
                    $(this).addClass('was-validated');
                })
    
                let date = new Date().toISOString().slice(0,10)
                $("#dateOfBirth").attr('max', date);
            }
        });
    }
    else {
        alert("Please, select a patient.")
        $(".containerNav_update").toggleClass("containerNav_link--active");
    }
});