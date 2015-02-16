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
     }

    this.sideTwo = {}
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
     }
}

Date.prototype.getDayName = function() {
  var d = ['Sunday','Monday','Tuesday','Wednesday',
  'Thursday','Friday','Saturday'];
  return d[this.getDay()];
}

Spot.prototype.getCurrentDayRegs = function() {
  var today = new Date();
  var todayName = today.getDayName();

  for (var dayReg in this.sideOne.Regulations) {
    if (dayReg === todayName) {
      return this.sideOne.Regulations[todayName];
      //expecting to return 9am or 8pm type data
    }
  }

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