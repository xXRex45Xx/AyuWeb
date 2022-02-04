let selectedPatient = null
let selectedPayment = null

$(".containerNav_search").on("click", async function () {
    if ($(".containerNav_searchPhone").val().length > 10 || isNaN(parseInt($(".containerNav_searchPhone").val()))) {
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

                $(".infoBox_addQueue").on("click", function () {
                    $.ajax({
                        type: "POST",
                        url: "/reception/patientpage/queue",
                        data: {
                            doctorType: $(".doctorType").val(),
                            patientId: selectedPatient
                        },
                        proccessData: false,
                        dataType: "html",
                        success: function (response) {
                            $(".mainContainer_subContainer").prepend(response);
                        },
                        error: function(error){
                            $(".mainContainer_subContainer").html(error.responseText);
                        }
                    });                    
                });
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

                $(".paymentContainer_pendingTable tbody tr").on("click", function (e) {
                    if (!e.ctrlKey)
                        $(".paymentContainer_pendingTable tbody tr").removeClass("selectedPayment");
                    $(this).toggleClass("selectedPayment");
                    selectedPayment = new Array()
                    $(".selectedPayment").each(function (index, element) {
                        selectedPayment.push(element.firstElementChild.innerText)
                    });
                });

                $(".paymentContainer_print").on("click", function () {
                    if (selectedPayment && selectedPayment.length && selectedPayment.length > 0) {
                        $.ajax({
                            type: "GET",
                            url: "/reception/patientpage/payment/reciept",
                            data: {
                                selectedPayment
                            },
                            dataType: "html",
                            success: function (response) {
                                let winPrint = window.open("", "", `left=0, top=0, width=${screen.width}, height=${screen.height}`);
                                winPrint.document.write(response)
                                winPrint.document.close()
                                winPrint.addEventListener("load", async function () {
                                    this.focus()
                                    this.print()
                                    this.close()
                                })
                                $(".containerNav_payment").click();
                            },
                            error: function (error) {
                                $(".mainContainer_subContainer").html(error.responseText);
                            }
                        });
                    }
                });

                $(".paymentContainer_register").on("click", function () {
                    if (selectedPayment) {
                        $.ajax({
                            type: "GET",
                            url: `/reception/patientpage/payment/register`,
                            data: {
                                selectedPayment
                            },
                            dataType: "html",
                            success: function (response) {
                                if(response === "success"){
                                    $(".containerNav_payment").click();
                                }
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
                else if ($("#phoneNo").val().length > 10 || isNaN($("#phoneNo").val())) {
                    $("#phoneNoValidationFeedback").html(`${$('#phoneNo').val()} is not a valid phone number.`)
                    $('#phoneNo').addClass("is-invalid")
                    $('#phoneNo').val("");
                    e.preventDefault()
                    e.stopPropagation()
                }
                $(this).addClass('was-validated');
            })

            let date = new Date().toISOString().slice(0, 10)
            $("#dateOfBirth").attr('max', date);
        },
        error: function (error) {
            $(".mainContainer_subContainer").html(error.responseText);
        }
    })
});