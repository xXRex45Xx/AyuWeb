const navLink = $(".containerNav_link")
let selectedPatient = null
let selectedPayment = null
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
            url: "/reception/patientpage/search",
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
            url: `/reception/patientpage/${selectedPatient}/info`,
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
            url: `/reception/patientpage/${selectedPatient}/payment`,
            dataType: "html",
            success: function (response) {
                $(".mainContainer_subContainer").html(response)

                $(".paymentContainer_pendingTable tbody tr").on("click", function () {
                    $(".paymentContainer_pendingTable tbody tr").removeClass("selectedPayment");
                    $(this).toggleClass("selectedPayment");
                    selectedPayment = parseInt($(".selectedPayment > td")[0].innerHTML)
                });
                $(".paymentContainer_cancel").on("click", function () {
                    if(selectedPayment){
                    $.ajax({
                        type: "POST",
                        url: `/reception/patientpage/${selectedPatient}/payment/${selectedPayment}?_method=DELETE`,
                        dataType: "html",
                        success: function (response) {
                            $(".mainContainer_subContainer").html(response)
                        },
                        error: function (error) {
                            $(".mainContainer_subContainer").html(error.responseText);
                        }
                    });}
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

$(".containerNav_new").on("click", async function () {
    await $.ajax({
        type: "GET",
        url: "/reception/patientpage/new",
        dataType: "html",
        success: function (response) {
            $(".mainContainer_subContainer").html(response);

            $(".newPatientForm").on("submit", function (e) {
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
        
            let date = new Date()
            let dd = date.getDate()
            let mm = date.getMonth() + 1
            let yyyy = date.getFullYear()
            if (dd < 10)
                dd = '0' + dd
            if (mm < 10)
                mm = '0' + mm
            $("#dateOfBirth").attr('max', `${yyyy}-${mm}-${dd}`);
        },
        error: function (error) {
            $(".mainContainer_subContainer").html(error.responseText);
        }
    })
});