var Spot = function(json) {
   this.sideOne = {}
     this.sideOne.Side = json.regs[0].side;
     this.sideOne.Suspended = json.suspended;
     this.sideOne.Regulations = {
           Monday : [json.regs[0].rules['mon'].start, json.regs[0].rules['mon'].stop],
           MondayBooleanTime: json.regs[0].rules['mon'].boolean_time,
           MondayCanIPark: json.regs[0].rules['mon'].can_i_park,

           Tuesday : [json.regs[0].rules['tue'].start, json.regs[0].rules['tue'].stop],
           TuesdayBooleanTime: json.regs[0].rules['tue'].boolean_time,
           TuesdayCanIPark: json.regs[0].rules['tue'].can_i_park,

           Wednesday : [json.regs[0].rules['wed'].start, json.regs[0].rules['wed'].stop],
           WednesdayBooleanTime: json.regs[0].rules['wed'].boolean_time,
           WednesdayCanIPark: json.regs[0].rules['wed'].can_i_park,

           Thursday : [json.regs[0].rules['thu'].start, json.regs[0].rules['thu'].stop],
           ThursdayBooleanTime: json.regs[0].rules['thu'].boolean_time,
           ThursdayCanIPark: json.regs[0].rules['thu'].can_i_park,

           Friday : [json.regs[0].rules['fri'].start, json.regs[0].rules['fri'].stop],
           FridayBooleanTime: json.regs[0].rules['fri'].boolean_time,
           FridayCanIPark: json.regs[0].rules['fri'].can_i_park,

           Saturday : [json.regs[0].rules['sat'].start, json.regs[0].rules['sat'].stop],
           SaturdayBooleanTime: json.regs[0].rules['sat'].boolean_time,
           SaturdayCanIPark: json.regs[0].rules['sat'].can_i_park,

           Sunday : [json.regs[0].rules['sun'].start, json.regs[0].rules['sun'].stop],
           SundayBooleanTime: json.regs[0].rules['sun'].boolean_time,
           SundayCanIPark: json.regs[0].rules['sun'].can_i_park,
     };


  this.sideTwo = {}
     if (json.regs[1] !== undefined) {
     this.sideTwo.Side = json.regs[1].side;
     this.sideTwo.Suspended = json.suspended;
     this.sideTwo.Regulations = {
           Monday : [json.regs[1].rules['mon'].start, json.regs[1].rules['mon'].stop],
           Tuesday : [json.regs[1].rules['tue'].start, json.regs[1].rules['tue'].stop],
           Wednesday : [json.regs[1].rules['wed'].start, json.regs[1].rules['wed'].stop],
           Thursday : [json.regs[1].rules['thu'].start, json.regs[1].rules['thu'].stop],
           Friday : [json.regs[1].rules['fri'].start, json.regs[1].rules['fri'].stop],
           Saturday : [json.regs[1].rules['sat'].start, json.regs[1].rules['sat'].stop],
           Sunday : [json.regs[1].rules['sun'].start, json.regs[1].rules['sun'].stop]
          };
     };
};

Date.prototype.getDayName = function() {
  var d = ['Sunday','Monday','Tuesday','Wednesday',
  'Thursday','Friday','Saturday'];
  return d[this.getDay()];
}

Spot.prototype.getCurrentDayRegs = function() {
  var today = new Date();
  var todayName = today.getDayName();
  var bothSides = {};

  for (var dayReg in this.sideOne.Regulations) {
    if (dayReg === todayName) {
      bothSides.sideOneName = this.sideOne.Side;
      bothSides.sideOneStart = this.sideOne.Regulations[todayName][0];
      bothSides.sideOneEnd = this.sideOne.Regulations[todayName][1];
    }
  }

  for (var dayReg in this.sideTwo.Regulations) {
    if (dayReg === todayName) {
      bothSides.sideTwoName = this.sideTwo.Side;
      bothSides.sideTwoStart = this.sideTwo.Regulations[todayName][0];
      bothSides.sideTwoEnd = this.sideTwo.Regulations[todayName][1];
    }
  }
  bothSides.Suspended = this.sideOne.Suspended;
  return bothSides;
}

// Spot.timeUntilRegulationOver = function() {
//   var today = new Date();
//   var hourNow = today.getHours();
//   var todayRegTime = parseInt(currentdayregulations[1].match(/\d+/).join());
//   var todayTimeIndicator = currentdayregulations[1].slice(currentdayregulations[1].length - 2)

//   if (todayTimeIndicator.toUpperCase() === 'PM' )
//     todayRegTime = todayRegTime + 12;
//   }

//   return todayRegTime - hourNow //will return the hours until the regulation is over
// }

// monday[0,0] // all day free parking
// monday[12am,12am] // no parking all day
// monday[8am,6pm] // the regulated times