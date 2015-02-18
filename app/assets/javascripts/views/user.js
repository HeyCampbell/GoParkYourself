View.UserMove = function(response) {
  var moveTime = response.move_by[0].i_can_park_until

  return "<h4> Move your car by " + "<span id='move_by_time'>" + moveTime + "</span> </h4>"
}