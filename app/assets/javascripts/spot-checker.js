$(document).ready(function() {

  $('#send-latlng').click(function(event) {
    event.preventDefault();
    $('#table_ct').html("");
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
      console.log(response);
      loadChecker(response);
    });
    ajaxRequest.fail(function(){
      loadNotSuccessful()
    })
  });

  //"show map?"
});

function loadChecker(response) {
  if (response.regs[0] === undefined || response.regs[0].rules === "error parsing rules" ) {
    loadNotSuccessful();
  }
  else {
    var spot = new Spot(response)
    console.log(spot)
    $('#table_ct').html(View.ParseRegulations(spot.getCurrentDayRegs()))
  }
}

function loadNotSuccessful() {
  //interstitialGif.hide()
  $('#table_ct').html("<h2>Sorry this spot has not yet been indexed</h2>")
}
