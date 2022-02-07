const navLink = $(".containerNav_link");
let selectedPatient = null;
let selectedPayment = null;
navLink.on("click", function () {
  changeButtonClass($(this));
});

async function changeButtonClass(button) {
  if (!button.hasClass("search")) {
    await clearSelection();
    button.toggleClass("containerNav_link--active");
  } else clearSelection();
}

async function clearSelection() {
  navLink.each(function () {
    $(this).removeClass("containerNav_link--active");
  });
}


$(".containerNav_search").on("click", async function () {
  if (isNaN(parseInt($(".containerNav_searchPhone").val()))) {
    selectedPatient = null;
    alert("Please enter a valid phone number!");
    return;
  }
  if ($(".containerNav_searchPhone").val() !== "") {
    selectedPatient = null;
    await $.ajax({
      type: "GET",
      url: "/laboratorist/patientpage/search",
      data: {
        q: $(".containerNav_searchPhone").val(),
      },
      dataType: "html",
      success: function (response) {
        $(".mainContainer_subContainer").html(response);
        $(".searchTable tbody tr").on("click", function () {
          $(".searchTable tbody tr").removeClass("selected");
          $(this).toggleClass("selected");
          selectedPatient = parseInt($(".selected > td")[0].innerHTML);
        });
      },
      error: function (error) {
        $(".mainContainer_subContainer").html(error.responseText);
      },
    });
  }
});

$(".containerNav_info").on("click", async function () {
  if (selectedPatient) {
    $.ajax({
      type: "GET",
      url: `/laboratorist/patientpage/${selectedPatient}/info`,
      dataType: "html",
      success: function (response) {
        $(".mainContainer_subContainer").html(response);
      },
      error: function (error) {
        $(".mainContainer_subContainer").html(error.responseText);
      },
    });
  } else {
    alert("Please, select a patient.");
    $(".containerNav_info").toggleClass("containerNav_link--active");
  }
});

$(".containerNav_labReport").on("click",  function () {
  if (selectedPatient) {
    $.ajax({
      type: "GET",
      url: `/laboratorist/patientpage/${selectedPatient}/labReport`,
      dataType: "html",
      success: function (response) {
        $(".mainContainer_subContainer").html(response);
        $(".btnLabReportSave").on("click",  () => {
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
                    $(".mainContainer_subContainer").html(response);
                    $(".containerNav_labReport").click();
                  },
                  error: function (error) {
                      $(".mainContainer_subContainer").html(error.responseText);
                  },
              });
          }
      });
      
      
      },
      error: function (error) {
        $(".mainContainer_subContainer").html(error.responseText);
      },
    });
  } else {
    alert("Please, select a patient.");
    $(".containerNav_labReport").toggleClass("containerNav_link--active");
  }
});






