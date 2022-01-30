$(".containerNav_print").hide();

$(".containerNav_patientPayment").on("click", function () {
    $(".containerNav_print").hide();
    $.ajax({
        type: "GET",
        url: "/management/reportpage/patientpayment",
        dataType: "html",
        success: function (response) {
            $(".mainContainer_subContainer").html(response);

            $(".containerNav_search").on("click", async function () {
                if (isNaN(parseInt($(".containerNav_searchPhone").val()))) {
                    alert("Please enter a valid phone number!")
                    return
                }
                if ($(".containerNav_searchPhone").val() !== "") {
                    await $.ajax({
                        type: "GET",
                        url: "/management/patientpage/search",
                        data: {
                            q: $(".containerNav_searchPhone").val()
                        },
                        dataType: "html",
                        success: function (response) {
                            $(".patientList").html(response);

                            $(".searchTable tbody tr").on("click", async function () {
                                let selectedPatient = parseInt($(this)[0].firstElementChild.innerHTML)
                                await $.ajax({
                                    type: "GET",
                                    url: `/management/reportpage/patientpayment/${selectedPatient}`,
                                    dataType: "html",
                                    success: function (response) {
                                        $(".mainContainer_subContainer").html(response);
                                        $(".containerNav_print").show();
                                    },
                                    error: function (error) {
                                        $(".patientList").html(error.responseText)
                                    }
                                });
                            });
                        },
                        error: function (error) {
                            $(".mainContainer_subContainer").html(error.responseText)
                        }
                    })

                }
            })
        },
        error: function (error) {
            $(".mainContainer_subContainer").html(error.responseText);
        }
    })
});

$(".containerNav_print").on("click", function () {
    console.log(screen.width)
    let winPrint = window.open("", "", `left=0, top=0, width=${screen.width}, height=${screen.height}`);
    winPrint.document.write($(".mainContainer_subContainer")[0].innerHTML)
    winPrint.document.close()
    winPrint.addEventListener("load", async function () {
        this.focus()
        this.print()
        this.close()
    })
});