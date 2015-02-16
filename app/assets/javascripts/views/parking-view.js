var View = {}

View.ParseRegulations = function(todaysRegulations) { //today's regulations is an array

  if (todaysRegulations[0] === 0) {
    return "<h2> All day parking </h2>"
  } else if (todaysRegulations[0] === '12am') {
    return "<h2> No Parking Dawg! </h2>"
  } else {
    var html = "<table id='regs_table'>"
    html += "<thead>"
    html += "Restricted Parking Times"
    html += "</thead>"
    html += "<tr>"
    html += "<td>Day</td>"
    html += "<td>" + todaysRegulations[0] + " to " + todaysRegulations[1] + "</td>"
    html += "</tr>"
    return html
  }
}


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