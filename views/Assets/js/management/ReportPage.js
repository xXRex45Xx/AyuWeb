$(".containerNav_selectDate").attr("max", new Date().toISOString().slice(0,10));
$(".containerNav_print").hide();
$(".containerNav_search").hide();
$(".containerNav_searchPhone").hide();
$(".containerNav_selectDate").hide();
let searchType = null;


$(".containerNav_patientPayment").on("click", function () {
    $(".containerNav_search").show();
    $(".containerNav_searchPhone").show();
    $(".containerNav_selectDate").hide();
    searchType = "patient"
});

$(".containerNav_receptionistTransaction").on("click", function () {
    $(".containerNav_search").show();
    $(".containerNav_searchPhone").show();
    $(".containerNav_selectDate").hide();
    searchType = "reception"
});

$(".containerNav_dailyIncome").on("click", function () {
    $(".containerNav_search").show();
    $(".containerNav_selectDate").show();
    $(".containerNav_searchPhone").hide();
    searchType = "date"
});

$(".containerNav_search").on("click", async function () {
    $(".containerNav_print").hide();
    if (searchType) {
        if (searchType === "patient") {
            if (isNaN($(".containerNav_searchPhone").val())) {
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
                        $(".mainContainer_subContainer").html(response);

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
                                    $(".mainContainer_subContainer").html(error.responseText)
                                }
                            });
                        });
                    },
                    error: function (error) {
                        $(".mainContainer_subContainer").html(error.responseText)
                    }
                })

            }
            else{
                alert("Please, enter a phone number!")
            }
        } else if (searchType === "reception") {
            if (isNaN(parseInt($(".containerNav_searchPhone").val()))) {
                alert("Please enter a valid phone number!")
                return
            }
            if ($(".containerNav_searchPhone").val() !== "") {
                await $.ajax({
                    type: "GET",
                    url: "/management/reportpage/reception/search",
                    data: {
                        q: $(".containerNav_searchPhone").val()
                    },
                    dataType: "html",
                    success: function (response) {
                        $(".mainContainer_subContainer").html(response);

                        $(".searchTable tbody tr").on("click", async function () {
                            let selectedReception = parseInt($(this)[0].firstElementChild.innerHTML)
                            await $.ajax({
                                type: "GET",
                                url: `/management/reportpage/receptiontransaction/${selectedReception}`,
                                dataType: "html",
                                success: function (response) {
                                    $(".mainContainer_subContainer").html(response);
                                    $(".containerNav_print").show();
                                },
                                error: function (error) {
                                    $(".mainContainer_subContainer").html(error.responseText)
                                }
                            });
                        });
                    },
                    error: function (error) {
                        $(".mainContainer_subContainer").html(error.responseText)
                    }
                })
            }
            else{
                alert("Please, enter a phone number!")
            }
        }
        else if(searchType === "date"){
            if ($(".containerNav_selectDate").val() !== "") {
                await $.ajax({
                    type: "GET",
                    url: `/management/reportpage/dailyreport/${$(".containerNav_selectDate").val()}`,
                    dataType: "html",
                    success: function (response) {
                        $(".mainContainer_subContainer").html(response);
                        $(".containerNav_print").show();
                    },
                    error: function (error) {
                        $(".mainContainer_subContainer").html(error.responseText)
                    }
                })
            }   
            else{
                alert("Please, select a date!")
            } 
        }
        else
            searchType = null
    }
    else {
        alert("Please, select search type!")
        $(".containerNav_search").hide();
        $(".containerNav_searchPhone").hide();
        $(".containerNav_selectDate").hide();
    }
})

$(".containerNav_print").on("click", function () {
    let winPrint = window.open("", "", `left=0, top=0, width=${screen.width}, height=${screen.height}`);
    winPrint.document.write($(".mainContainer_subContainer")[0].innerHTML)
    winPrint.document.close()
    winPrint.addEventListener("load", async function () {
        this.focus()
        this.print()
        this.close()
    })
});