$(document).ready(function() {

  $('#send-latlng').click(function(event) {
    event.preventDefault();
    //interstitialGif.show();
    var $form = $(event.currentTarget);
    var $url = $form.attr("action");
    var $data = {latitude: marker.position.k,
                 longitude: marker.position.D}
    var $type = $form.attr("method");

    var ajaxRequest = $.ajax({
      type: $type,
      url: $url,
      data: $data
    });
    ajaxRequest.done(function(response) {
      // debugger
      console.log(response)
    });
    // ajaxRequest.done(loadParkingStatus);
    // ajaxRequest.fail(loadNotSuccessful);
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

var View = {}

View.drawParkingStatus = function() {
  //the HTML representation of the response from the server goes here
}
