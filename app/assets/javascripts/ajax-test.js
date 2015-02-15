$(document).ready(function() {

  $('#send-latlng').click(function(event) {
    event.preventDefault();
    $('#time_to_move').html("");
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
      console.log(response)
      var spot = new Spot(response)
      $('#time_to_move').html(View.drawParkingStatus(spot));
    });
    ajaxRequest.fail(loadNotSuccessful());
  });
});

function loadNotSuccessful() {
  //interstitialGif.hide()
  $('#time_to_move').html("Sorry this spot has not yet been indexed")
}

var View = {}

View.drawParkingStatus = function(spot) {
  var html = 'Side of Street: '
  html += spot.sideOne.Side + '<br>'
  html += 'Monday Start: '
  html += spot.sideOne.MondayStart + '<br>'
  html += 'Monday Stop: '
  html += spot.sideOne.MondayStop
  return html
}

var Spot = function(json) {
   this.sideOne = {}
     this.sideOne.Side = json.regs[0].side;
     this.sideOne.MondayStart = json.regs[0].rules[0]['mon'].start;
     this.sideOne.MondayStop = json.regs[0].rules[0]['mon'].stop;
     this.sideOne.TuesdayStart = json.regs[0].rules[1]['tue'].start;
     this.sideOne.TuesdayStop = json.regs[0].rules[1]['tue'].stop;
     this.sideOne.WednesdayStart = json.regs[0].rules[2]['wed'].start;
     this.sideOne.WednesdayStop = json.regs[0].rules[2]['wed'].stop;
     this.sideOne.ThursdayStart = json.regs[0].rules[3]['thu'].start;
     this.sideOne.ThursdayStop = json.regs[0].rules[3]['thu'].stop;
     this.sideOne.FridayStart = json.regs[0].rules[4]['fri'].start;
     this.sideOne.FridayStop = json.regs[0].rules[4]['fri'].stop;
     this.sideOne.SaturdayStart = json.regs[0].rules[5]['sat'].start;
     this.sideOne.SaturdayStop = json.regs[0].rules[5]['sat'].stop;
     this.sideOne.SundayStart = json.regs[0].rules[6]['sun'].start;
     this.sideOne.SundayStop = json.regs[0].rules[6]['sun'].stop;

   this.sideTwo = {}
     this.sideTwo.Side = json.regs[0].side;
     this.sideTwo.MondayStart = json.regs[1].rules[0]['mon'].start;
     this.sideTwo.MondayStop = json.regs[1].rules[0]['mon'].stop;
     this.sideTwo.TuesdayStart = json.regs[1].rules[1]['tue'].start;
     this.sideTwo.TuesdayStop = json.regs[1].rules[1]['tue'].stop;
     this.sideTwo.WednesdayStart = json.regs[1].rules[2]['wed'].start;
     this.sideTwo.WednesdayStop = json.regs[1].rules[2]['wed'].stop;
     this.sideTwo.ThursdayStart = json.regs[1].rules[3]['thu'].start;
     this.sideTwo.ThursdayStop = json.regs[1].rules[3]['thu'].stop;
     this.sideTwo.FridayStart = json.regs[1].rules[4]['fri'].start;
     this.sideTwo.FridayStop = json.regs[1].rules[4]['fri'].stop;
     this.sideTwo.SaturdayStart = json.regs[1].rules[5]['sat'].start;
     this.sideTwo.SaturdayStop = json.regs[1].rules[5]['sat'].stop;
     this.sideTwo.SundayStart = json.regs[1].rules[6]['sun'].start;
     this.sideTwo.SundayStop = json.regs[1].rules[6]['sun'].stop;
}

