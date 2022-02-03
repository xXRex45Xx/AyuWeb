$(".btnLabReportSave").on("click", async () => {
    const row = document.querySelector(".btnLabReportSave").parentElement.parentElement
    const normalValue = row.querySelector("[name=normalValue]").value
    const result = row.querySelector("[name=result]").value
    const type = row.querySelector(".reportType").innerHTML
    if (normalValue == "" || result == "")
        alert("Please Fill Both The Normal Value and The Result")
    else {
        $.ajax({
            type: "POST",
            url: `/laboratorist/patientpage/${selectedPatient}/labReportResponse`,
            dataType: "html",
            data: {
                normal: normalValue, result: result, patientId: selectedPatient, reportType: type
            },
            proccessData: false,
            success: function (response) {
                $(".containerNav_labReport").click();
                $(".mainContainer_subContainer").html(response);
            },
            error: function (error) {
                $(".mainContainer_subContainer").html(error.responseText);
            },
        });
    }
});

