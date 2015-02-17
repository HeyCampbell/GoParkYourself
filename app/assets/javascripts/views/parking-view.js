var View = {}

View.ParseRegulations = function(todayRegs) {
  var html = " "
  if (todayRegs.Suspended === false ) {
    html += "<h2> Alternative Side Parking in effect </h2>"
  }else {
    html += "<h2> Alternative Side Parking not effect</h2>"
  }

  html += "</h2>"
  html += "<table id='regs_table'>"
  html += "<tr>"
  html += "<td>" + todayRegs.sideOneName + " Side" + "</td>"

  if (todayRegs.sideTwoName !== undefined) {
     html += "<td>" + todayRegs.sideTwoName + " Side" + "</td>"
  }

  html += "</tr>"
  html += "<tr>"

  if (todayRegs.sideOneStart.toUpperCase() === '12AM') {
    html += "<td> No Parking All Day </td>"
  } else if (todayRegs.sideOneStart === '0') {
    html += "<td> Parking All Day! </td>"
  } else {
    html += "<td>" + todayRegs.sideOneStart + " to " + todayRegs.sideOneEnd + "</td>"
  }

  if (todayRegs.sideTwoStart !== undefined) {
    if (todayRegs.sideTwoStart.toUpperCase() === '12AM') {
      html += "<td> No Parking All Day </td>"
    } else if (todayRegs.sideTwoStart === '0') {
      html += "<td> Parking All Day! </td>"
    } else {
      html += "<td>" + todayRegs.sideTwoStart + " to " + todayRegs.sideTwoEnd + "</td>"
    }
  }

  html += "</tr>"
  html += "</table>"
  return html
}

//data
// sideOneEnd: "4PM"
// sideOneName: "N"
// sideOneStart: "7AM"
// sideTwoEnd: "12am"
// sideTwoName: "S"
// sideTwoStart: "12am"

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