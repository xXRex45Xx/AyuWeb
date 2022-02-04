let selectedReception = null

attachReceptionEvents()

$(".containerNav_transactions").hide();

$(".containerNav_search").on("click", async function () {
    if($(".containerNav_searchPhone").val() === ""){
        location.reload()
    }
    else if ($(".containerNav_searchPhone").val().length > 10 || isNaN(parseInt($(".containerNav_searchPhone").val()))) {
        selectedReception = null
        
        alert("Please enter a valid phone number!")
        return
    }
    if ($(".containerNav_searchPhone").val() !== "") {
        selectedReception = null
        
        $(".containerNav_transactions").hide();
        await $.ajax({
            type: "GET",
            url: "/management/employeepage/search",
            data: {
                q: $(".containerNav_searchPhone").val()
            },
            dataType: "html",
            success: function (response) {
                $(".mainContainer_subContainer").html(response);
                attachReceptionEvents()
            },
            error: function (error) {
                $(".mainContainer_subContainer").html(error.responseText)
            }
        })
        
    }
})

$(".containerNav_new").on("click", async function () {
    await $.ajax({
        type: "GET",
        url: "/management/employeepage/new",
        dataType: "html",
        success: function (response) {
            $(".mainContainer_subContainer").html(response);

            let eighteen = new Date()
            eighteen.setFullYear(eighteen.getFullYear() - 18)
            eighteen = eighteen.toISOString().slice(0,10)
            $(".newEmployeeForm_speciality").hide();
            $("#dateOfBirth").attr("max", eighteen);
            
            $("#type").on('change', function () {
                if($(this).val() === "2")
                    $(".newEmployeeForm_speciality").show();
                else
                    $(".newEmployeeForm_speciality").hide();
            });

            $(".newEmployeeForm").on("submit", function (e) {
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
        },
        error: function (error) {
            $(".mainContainer_subContainer").html(error.responseText);
        }
    })
});

$(".containerNav_transactions").on("click", async function () {
    if (selectedReception) {
        $.ajax({
            type: "GET",
            url: `/management/employeepage/${selectedReception}/transactions`,
            dataType: "html",
            success: function (response) {
                $(".mainContainer_subContainer").html(response)
            },
            error: function (error) {
                $(".mainContainer_subContainer").html(error.responseText);
            }
        })
    }
    else {
        alert("Please, select a receptionist.")
        $(".containerNav_payment").toggleClass("containerNav_link--active")
    }
});

function attachReceptionEvents(){
    $(".showReception").on("click", function () {
        let receptionData = $(this).attr("data-bs-target");
        if(receptionData){
            console.log(receptionData)
            if(selectedReception !== null){
                selectedReception = null
                $(".containerNav_transactions").hide();
            }
            else{
                selectedReception = $(`${receptionData} .infoBox_receptionNumber`)[0].innerText
                $(".containerNav_transactions").show();
            }
        }
    });
}