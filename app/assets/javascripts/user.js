$(document).ready(function() {

  if (document.getElementById('last_spot_info')) {
    var ajaxRequest = $.ajax({
      type: 'GET',
      url: '/spots/current.json'
    });
    ajaxRequest.done(function(response) {
      var spot = new Spot(response);
      console.log(spot);
      //below will append the view
      // $('#table_ct').html(View.ParseRegulations(spot.getCurrentDayRegs()))
    })
  };
});