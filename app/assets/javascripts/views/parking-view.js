var View = {}

View.ParseRegulations = function(todayRegs) {
  var sideOneArray = todayRegs.sideOneCanPark;
  var sideTwoArray = todayRegs.sideTwoCanPark;
  var html = "<table id='regs_table'>"
  html += "<thead>"
  html += "<tr>"
  html += "<td class='table_head'>Time</td>"
  html += "<td class='table_head'>" + todayRegs.sideOneName + " Side</td>"
  html += "<td class='table_head'>" + todayRegs.sideTwoName + " Side</td>"
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

// View.ColorizeWithTime = function(sideOneArray, sideTwoArray) {
//   var html = '<tr>'
//   var timeArray = ["11pm", "10pm", "9pm", "8pm", "7pm", "6pm", "5pm", "4pm", "3pm", "2pm", "1pm", "12pm", "11am", "10am", "9am", "8am", "7am", "6am", "5am", "4am", "3am", "2am", "1am", "12am"]
//   var canParkCounter = 0

//   for (var i = timeArray.length - 1; i >= 0; i--) {
//     html += "<td class='table_time' rowspan='3'>" + timeArray[i]+ "</td>"
//     html += "<tr>"
//     for (var j = 0; j < 2; j++) {

//       if (sideOneArray[canParkCounter] === true) {
//         html += "<td class='can_park'></td>"
//       } else {
//         html += "<td class='cant_park'></td>"
//       }

//       if (sideTwoArray[canParkCounter] === true) {
//         html += "<td class='can_park'></td>"
//       } else {
//         html += "<td class='cant_park'></td>"
//       }

//       html += "</tr>"
//       canParkCounter++
//     }
//   };
//   return html;

// }