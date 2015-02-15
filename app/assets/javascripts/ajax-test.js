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
      var spot = new Spot(response)
      $('#time_to_move').html(View.drawParkingStatus(spot));
    });
    // ajaxRequest.fail(loadNotSuccessful);
  });
});

function loadNotSuccessful(response) {
  //interstitialGif.hide()
  //append the error message to the page
}

var View = {}

View.drawParkingStatus = function(spot) {
  var html = ""
}

var Spot = function(json) {
   this.sideOne = {}
     this.sideOne.Side = json.regs[0].side;
     this.sideOne.MondayRegs = json.regs[0].rules[0]['mon'];
     this.sideOne.TuesdayRegs = json.regs[0].rules[1]['tue'];
     this.sideOne.WednesdayRegs = json.regs[0].rules[2]['wed'];
     this.sideOne.ThursdayRegs = json.regs[0].rules[3]['thu'];
     this.sideOne.FridayRegs = json.regs[0].rules[4]['fri'];
     this.sideOne.SaturdayRegs = json.regs[0].rules[5]['sat'];
     this.sideOne.SundayRegs = json.regs[0].rules[6]['sun'];

   this.sideTwo = {}
     this.sideTwo.Side = json.regs[1].side;
     this.sideTwo.MondayRegs = json.regs[1].rules[0]['mon'];
     this.sideTwo.TuesdayRegs = json.regs[1].rules[1]['tue'];
     this.sideTwo.WednesdayRegs = json.regs[1].rules[2]['wed'];
     this.sideTwo.ThursdayRegs = json.regs[1].rules[3]['thu'];
     this.sideTwo.FridayRegs = json.regs[1].rules[4]['fri'];
     this.sideTwo.SaturdayRegs = json.regs[1].rules[5]['sat'];
     this.sideTwo.SundayRegs = json.regs[1].rules[6]['sun'];
}

