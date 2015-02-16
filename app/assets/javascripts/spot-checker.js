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
  });
});

function loadChecker(response) {
  if (response.regs[0] === undefined) {
    loadNotSuccessful();
  }
  else {
    var spot = new Spot(response)
    console.log(spot)
    $('#table_ct').html(View.ParseRegulations(spot.getCurrentDayRegs()))
    // $('#table_ct').html(View.drawParkingStatus(spot));
  }
}

function loadNotSuccessful() {
  //interstitialGif.hide()
  $('#table_ct').html("<h2>Sorry this spot has not yet been indexed</h2>")
}

// var View = {}

// View.drawParkingStatus = function(spot) {
//   var html = "<table id='regs_table'>"
//   html += "<tr>"
//   html += "<td>Day</td>"
//   html += "<td>" + spot.sideOne.Side + "</td>"
//   html += "<td>" + spot.sideTwo.Side + "</td>"
//   html += "</tr>"
//   html += "<tr>"
//   html += "<td>Mon</td>"
//   html += "<td>" + spot.sideOne.MondayStart + " to " + spot.sideOne.MondayStop + "</td>"
//   html += "<td>" + spot.sideTwo.MondayStart + " to " + spot.sideTwo.MondayStop + "</td>"
//   html += "</tr>"
//   html += "<tr>"
//   html += "<td>Tue</td>"
//   html += "<td>" + spot.sideOne.TuesdayStart + " to " + spot.sideOne.TuesdayStop + "</td>"
//   html += "<td>" + spot.sideTwo.TuesdayStart + " to " + spot.sideTwo.TuesdayStop + "</td>"
//   html += "</tr>"
//   html += "<tr>"
//   html += "<td>Wed</td>"
//   html += "<td>" + spot.sideOne.WednesdayStart + " to " + spot.sideOne.WednesdayStop + "</td>"
//   html += "<td>" + spot.sideTwo.WednesdayStart + " to " + spot.sideTwo.WednesdayStop + "</td>"
//   html += "</tr>"
//   html += "<tr>"
//   html += "<td>Thu</td>"
//   html += "<td>" + spot.sideOne.ThursdayStart + " to " + spot.sideOne.ThursdayStop + "</td>"
//   html += "<td>" + spot.sideTwo.ThursdayStart + " to " + spot.sideTwo.ThursdayStop + "</td>"
//   html += "</tr>"
//   html += "<tr>"
//   html += "<td>Fri</td>"
//   html += "<td>" + spot.sideOne.FridayStart + " to " + spot.sideOne.FridayStop + "</td>"
//   html += "<td>" + spot.sideTwo.FridayStart + " to " + spot.sideTwo.FridayStop + "</td>"
//   html += "</tr>"
//   html += "<tr>"
//   html += "<td>Sat</td>"
//   html += "<td>" + spot.sideOne.SaturdayStart + " to " + spot.sideOne.SaturdayStop + "</td>"
//   html += "<td>" + spot.sideTwo.SaturdayStart + " to " + spot.sideTwo.SaturdayStop + "</td>"
//   html += "</tr>"
//   html += "<tr>"
//   html += "<td>Sun</td>"
//   html += "<td>" + spot.sideOne.SundayStart + " to " + spot.sideOne.SundayStop + "</td>"
//   html += "<td>" + spot.sideTwo.SundayStart + " to " + spot.sideTwo.SundayStop + "</td>"
//   html += "</tr>"
//   html += "</table>"
//   return html
// }

// var Spot = function(json) {
//    this.sideOne = {}
//      this.sideOne.Side = json.regs[0].side;
//      this.sideOne.MondayStart = json.regs[0].rules['mon'].start;
//      this.sideOne.MondayStop = json.regs[0].rules['mon'].stop;
//      this.sideOne.TuesdayStart = json.regs[0].rules['tue'].start;
//      this.sideOne.TuesdayStop = json.regs[0].rules['tue'].stop;
//      this.sideOne.WednesdayStart = json.regs[0].rules['wed'].start;
//      this.sideOne.WednesdayStop = json.regs[0].rules['wed'].stop;
//      this.sideOne.ThursdayStart = json.regs[0].rules['thu'].start;
//      this.sideOne.ThursdayStop = json.regs[0].rules['thu'].stop;
//      this.sideOne.FridayStart = json.regs[0].rules['fri'].start;
//      this.sideOne.FridayStop = json.regs[0].rules['fri'].stop;
//      this.sideOne.SaturdayStart = json.regs[0].rules['sat'].start;
//      this.sideOne.SaturdayStop = json.regs[0].rules['sat'].stop;
//      this.sideOne.SundayStart = json.regs[0].rules['sun'].start;
//      this.sideOne.SundayStop = json.regs[0].rules['sun'].stop;

//    this.sideTwo = {}
//      this.sideTwo.Side = json.regs[1].side;
//      this.sideTwo.MondayStart = json.regs[1].rules['mon'].start;
//      this.sideTwo.MondayStop = json.regs[1].rules['mon'].stop;
//      this.sideTwo.TuesdayStart = json.regs[1].rules['tue'].start;
//      this.sideTwo.TuesdayStop = json.regs[1].rules['tue'].stop;
//      this.sideTwo.WednesdayStart = json.regs[1].rules['wed'].start;
//      this.sideTwo.WednesdayStop = json.regs[1].rules['wed'].stop;
//      this.sideTwo.ThursdayStart = json.regs[1].rules['thu'].start;
//      this.sideTwo.ThursdayStop = json.regs[1].rules['thu'].stop;
//      this.sideTwo.FridayStart = json.regs[1].rules['fri'].start;
//      this.sideTwo.FridayStop = json.regs[1].rules['fri'].stop;
//      this.sideTwo.SaturdayStart = json.regs[1].rules['sat'].start;
//      this.sideTwo.SaturdayStop = json.regs[1].rules['sat'].stop;
//      this.sideTwo.SundayStart = json.regs[1].rules['sun'].start;
//      this.sideTwo.SundayStop = json.regs[1].rules['sun'].stop;
// }

