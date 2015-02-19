$(document).ready(function() {

  $('#reminderModal').click(function() {
    var ajaxRequest = $.ajax({
      type: 'GET',
      url: '/spots/current.json'
    });
    ajaxRequest.done(function(response){
      var spot = new Spot(response);
      console.log(response);
      var sideOne = spot.sideOne.Side
      var sideTwo = spot.sideTwo.Side
      var sideOneMove = response.move_by[0].i_can_park_until
      if (response.move_by[1].i_can_park_until !== undefined) {
        var sideTwoMove = response.move_by[1].i_can_park_until
      }
      var sideOneParkNow = response.park_right_now[0].i_can_has_park
      var sideTwoParkNow = response.park_right_now[1].i_can_has_park

      $('#phone-form-update').html(updatePhoneForm(sideOne, sideOneMove, sideOneParkNow, sideTwo, sideTwoMove, sideTwoParkNow));
    });
  });

});


function updatePhoneForm(sideOne, sideOneMove, sideOneParkNow, sideTwo, sideTwoMove, sideTwoParkNow) {
  var html = ""

  if (sideOneParkNow === true) {
    html += "<input type='radio' name='side_of_street' value='" + sideOne + "'>" + " " + sideOne + " Side | Park until " + sideOneMove + "<br>"
  }

  if (sideTwo !== undefined) {
    if (sideTwoParkNow === true) {
      html += "<input type='radio' name='side_of_street' value='" + sideTwo + "'>" + " " + sideTwo + " Side | Park until " + sideTwoMove
    }
  }
  return html
}

   // <input type="radio" name="side-of-street" value='sideOne'> SideOne
   //    <input type="radio" name="side-of-street" value='sideTwo'> SideTwo