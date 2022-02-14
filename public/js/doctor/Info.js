$("#btnSaveAppointment").on("click", async () => {
    const date = $("#appointmentDate").val();
    const time = $("#appointmentTime").val();
    const today = new Date()
    if (date == "" || time == "") {
        alert("Please enter a valid Date and Time")
    }
    else if (Date.parse(date) - today.getTime() < 0) {
        alert("Please enter a day forward")
    }
    else {
        $.ajax({
            type: "POST",
            url: `/doctor/patientpage/${selectedPatient}/appointment`,
            dataType: "html",
            data: {
                appointmentDate: date, appointmentTime: time, patientId: selectedPatient
            },
            proccessData: false,
            success: function (response) {
                $(".mainContainer_subContainer").html(response);
            },
            error: function (error) {
                $(".mainContainer_subContainer").html(error.responseText);
            }
        });
    }

})