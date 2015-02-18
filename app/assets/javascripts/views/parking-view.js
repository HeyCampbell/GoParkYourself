var View = {}

View.Table = function() {
  return $('#table_ct')
}

View.ParseRegulations = function(todayRegs) {
  var sideOneArray = todayRegs.sideOneCanPark;
  var sideTwoArray = todayRegs.sideTwoCanPark;
  var html = "<h4> " + todayRegs.Address + " </h4>"
  html += View.AltSuspended(todayRegs.Suspended);
  html += "<table id='regs_table'>"
  html += "<thead>"
  html += "<tr>"
  html += "<td class='table_head'>Time</td>"
  html += "<td class='table_head'>" + todayRegs.sideOneName + " Side<br>" + todayRegs.sideOneStart + " to " + todayRegs.sideOneEnd + "</td>"
  html += "<td class='table_head'>" + todayRegs.sideTwoName + " Side<br>" + todayRegs.sideTwoStart + " to " + todayRegs.sideTwoEnd + "</td>"
  html += "</tr>"
  html += "</thead>"

  html += View.ColorizeWithTime(sideOneArray, sideTwoArray);

  html += "</tr>"
  html += "</table>"
  return html
}

View.ColorizeWithTime = function(sideOneArray, sideTwoArray) {
  var html = '<tr>'
  var timeArray = ["9pm", "6pm", "3pm", "12pm", "9am", "6am", "3am", "12am"]
  var canParkCounter = 0

  for (var i = timeArray.length - 1; i >= 0; i--) {
    html += "<td class='table_time' rowspan='7'>" + timeArray[i]+ "</td>"
    html += "<tr>"
    for (var j = 0; j < 6; j++) {

      if (sideOneArray[canParkCounter] === true) {
        html += "<td class='can_park'></td>"
      } else {
        html += "<td class='cant_park'></td>"
      }

      if (sideTwoArray[canParkCounter] === true) {
        html += "<td class='can_park'></td>"
      } else {
        html += "<td class='cant_park'></td>"
      }

      html += "</tr>"
      canParkCounter++
    }
  };
  return html;

}

View.ReturnSpotHtml = function() {
  $spot = $('#table_ct').html();
  return $spot;
}

View.AltSuspended = function(suspendedStatus) {
  var html = ''
     if (suspendedStatus.Suspended === false ) {
     html += "<h4> Alternative Side Parking in effect </h4>"
   } else {
     html += "<h4> Alternative Side Parking not in effect</h4>"
   }

   return html;
}

//TO IMPLEMENT
// <h3>Alternative Side Parking in Effect!</h3>
// <h4>You need to move by <span id="move_by_time">6:00 pm</span></h4>