$(document).ready(function() {

  $('#send-latlng').click(function(event) {
    event.preventDefault();
    //interstitialGif.show();
    var $form = $(event.target);
    var url = $form.attr("action");
    var data = $form.serialize();
    var type = $form.attr("method");

    var ajaxRequest = $.ajax({
      type: type,
      url: url,
      data: data
    });
    ajaxRequest.done(loadParkingStatus);
    ajaxRequest.fail(loadNotSuccessful);
  });
});

function loadParkingStatus(response) {
  //interstitialGif.hide()
  //append the response to the page
}

function loadNotSuccessful(response) {
  //interstitialGif.hide()
  //append the error message to the page
}
