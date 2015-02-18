$(document).ready(function() {

  $('#reminderModal').click(function() {
    var ajaxRequest = $.ajax({
      type: 'GET',
      url: '/spots/current.json'
    });
    ajaxRequest.done(function(response){
      var spot = new Spot(response);
      var sideOne = spot.sideOne.Side
      var sideTwo = spot.sideTwo.Side
      $('#phone-form-update').html(updatePhoneForm(sideOne, sideTwo));
    });
  });

});


function updatePhoneForm(sideOne, sideTwo) {
  var html = ""
  html += "<input type='radio' name='side_of_street' value='" + sideOne + "'>" + " " + sideOne + " Side <br>"
  html += "<input type='radio' name='side_of_street' value='" + sideTwo + "'>" + " " + sideTwo + " Side"
  return html
}

   // <input type="radio" name="side-of-street" value='sideOne'> SideOne
   //    <input type="radio" name="side-of-street" value='sideTwo'> SideTwo