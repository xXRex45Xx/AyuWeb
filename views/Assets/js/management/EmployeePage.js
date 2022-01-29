let selectedEmployee = null
let selectedEmployeeRole = null

$(".containerNav_transactions").hide();

$(".containerNav_search").on("click", async function () {
    if (isNaN(parseInt($(".containerNav_searchPhone").val()))) {
        selectedEmployee = null
        selectedEmployeeRole = null
        alert("Please enter a valid phone number!")
        return
    }
    if ($(".containerNav_searchPhone").val() !== "") {
        selectedEmployee = null
        selectedEmployeeRole = null
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

                $(".searchTable tbody tr").on("click", function () {
                    $(".searchTable tbody tr").removeClass("selected");
                    $(this).toggleClass("selected");
                    selectedEmployee = parseInt($(".selected > td")[0].innerHTML)
                    selectedEmployeeRole = $(".selected > td")[3].innerHTML
                    if(selectedEmployeeRole === "Receptionist")
                        $(".containerNav_transactions").show();
                    else
                        $(".containerNav_transactions").hide();
                });
            },
            error: function (error) {
                $(".mainContainer_subContainer").html(error.responseText)
            }
        })
        
    }
})

$(".containerNav_info").on("click", async function () {
    if (selectedEmployee) {
        $.ajax({
            type: "GET",
            url: `/management/employeepage/${selectedEmployee}/info`,
            data:{
                role: selectedEmployeeRole
            },
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
        alert("Please, select an employee.")
        $(".containerNav_info").toggleClass("containerNav_link--active")
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
            console.log(eighteen)
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
                else if (isNaN($("#phoneNo").val())) {
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
    if (selectedEmployee) {
        $.ajax({
            type: "GET",
            url: `/management/employeepage/${selectedEmployee}/transactions`,
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