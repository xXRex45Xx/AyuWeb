const navLink = $(".containerNav_link")
let selectedPatient = null
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
            url: "/patientpage/search",
            data: {
                q: $(".containerNav_searchPhone").val()
            },
            dataType: "html",
            success: function (response) {
                $(".mainContainer_subContainer").html(response);
            },
            error: function (error) {
                $(".mainContainer_subContainer").html(error.responseText)
            }

        }).catch(e => { });
        $(".searchTable tbody tr").on("click", function () {
            $(".searchTable tbody tr").removeClass("selected");
            $(this).toggleClass("selected");
            selectedPatient = parseInt($(".selected > td")[0].innerHTML)
        });
    }
})

$(".containerNav_info").on("click", async function () {
    if (selectedPatient) {
        $.ajax({
            type: "GET",
            url: `/patientpage/${selectedPatient}/info`,
            dataType: "html",
            success: function (response) {
                $(".mainContainer_subContainer").html(response);
            },
            error: function(error){
                $(".mainContianer_subContainer").html(error.responseText)
            }
        }).catch(e => { });;
    }
    else {
        alert("Please, select a patient.")
        $(".containerNav_info").toggleClass("containerNav_link--active")
    }

})

$(".containerNav_payment").on("click", async function () {
    if(selectedPatient){
        $.ajax({
            type: "GET",
            url: `/patientpage/${selectedPatient}/payment`,
            dataType: "html",
            success: function (response) {
                $(".mainContainer_subContainer").html(response)
            },            
            error: function(error){
                $(".mainContianer_subContainer").html(error.responseText)
            }
        }).catch(e => { });;
    }
    else{
        alert("Please, select a patient.")
        $(".containerNav_payment").toggleClass("containerNav_link--active")        
    }
});

$(".containerNav_new").on("click", async function () {
    await $.ajax({
        type: "GET",
        url: "/patientpage/new",
        dataType: "html",
        success: function (response) {
            $(".mainContainer_subContainer").html(response);
        },        
        error: function(error){
            $(".mainContianer_subContainer").html(error.responseText)
        }
    }).catch(e => { });

    $(".newPatientForm").on("submit", function(e){
        if(!this.checkValidity()){
            e.preventDefault()
            e.stopPropagation()
        }
        $(this).addClass('was-validated');
    })
    
    let date = new Date()
    let dd = date.getDate()
    let mm = date.getMonth() + 1
    let yyyy = date.getFullYear()
    if(dd < 10)
        dd = '0' + dd
    if(mm < 10)
        mm = '0' + mm
    $("#dateOfBirth").attr('max', `${yyyy}-${mm}-${dd}`);

});