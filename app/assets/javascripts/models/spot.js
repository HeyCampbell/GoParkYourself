var Spot = function(json) {
   this.sideOne = {}
     this.sideOne.Side = json.regs[0].side;
     this.sideOne.Suspended = json.suspended;
     this.sideOne.Regulations = {
           Monday : [json.regs[0].rules['mon'].start, json.regs[0].rules['mon'].stop],
           Tuesday : [json.regs[0].rules['tue'].start, json.regs[0].rules['tue'].stop],
           Wednesday : [json.regs[0].rules['wed'].start, json.regs[0].rules['wed'].stop],
           Thursday : [json.regs[0].rules['thu'].start, json.regs[0].rules['thu'].stop],
           Friday : [json.regs[0].rules['fri'].start, json.regs[0].rules['fri'].stop],
           Saturday : [json.regs[0].rules['sat'].start, json.regs[0].rules['sat'].stop],
           Sunday : [json.regs[0].rules['sun'].start, json.regs[0].rules['sun'].stop]
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