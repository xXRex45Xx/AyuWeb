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
      url: "/doctor/patientpage/search",
      data: {
        q: $(".containerNav_searchPhone").val(),
      },
      dataType: "html",
      success: function (response) {
        $(".mainContainer_subContainer").html(response);
        console.log(response)

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
      url: `/doctor/patientpage/${selectedPatient}/info`,
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

$(".containerNav_labReport").on("click", async function () {
  if (selectedPatient) {
    $.ajax({
      type: "GET",
      url: `/doctor/patientpage/${selectedPatient}/labReport`,
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
    $(".containerNav_labReport").toggleClass("containerNav_link--active");
  }
});

$(".containerNav_labRequest").on("click", async function () {
  if (selectedPatient) {
    $.ajax({
      type: "GET",
      url: `/doctor/patientpage/${selectedPatient}/labRequest`,
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
    $(".containerNav_labReport").toggleClass("containerNav_link--active");
  }
});

