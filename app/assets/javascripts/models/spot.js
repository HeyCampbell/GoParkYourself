// var Spot = function(json) {
//    this.sideOne = {}
//      this.sideOne.Side = json.regs[0].side;
//      // this.sideOne.AlternativeParking = json.regs[0].altparking;
//      this.sideOne.MondayStart = json.regs[0].rules['mon'].start;
//      this.sideOne.MondayStop = json.regs[0].rules['mon'].stop;
//      this.sideOne.TuesdayStart = json.regs[0].rules['tue'].start;
//      this.sideOne.TuesdayStop = json.regs[0].rules['tue'].stop;
//      this.sideOne.WednesdayStart = json.regs[0].rules['wed'].start;
//      this.sideOne.WednesdayStop = json.regs[0].rules['wed'].stop;
//      this.sideOne.ThursdayStart = json.regs[0].rules['thu'].start;
//      this.sideOne.ThursdayStop = json.regs[0].rules['thu'].stop;
//      this.sideOne.FridayStart = json.regs[0].rules['fri'].start;
//      this.sideOne.FridayStop = json.regs[0].rules['fri'].stop;
//      this.sideOne.SaturdayStart = json.regs[0].rules['sat'].start;
//      this.sideOne.SaturdayStop = json.regs[0].rules['sat'].stop;
//      this.sideOne.SundayStart = json.regs[0].rules['sun'].start;
//      this.sideOne.SundayStop = json.regs[0].rules['sun'].stop;

//    this.sideTwo = {}
//      this.sideTwo.Side = json.regs[1].side;
//      // this.sideTwo.AlternativeParking = json.regs[1].altparking;
//      this.sideTwo.MondayStart = json.regs[1].rules['mon'].start;
//      this.sideTwo.MondayStop = json.regs[1].rules['mon'].stop;
//      this.sideTwo.TuesdayStart = json.regs[1].rules['tue'].start;
//      this.sideTwo.TuesdayStop = json.regs[1].rules['tue'].stop;
//      this.sideTwo.WednesdayStart = json.regs[1].rules['wed'].start;
//      this.sideTwo.WednesdayStop = json.regs[1].rules['wed'].stop;
//      this.sideTwo.ThursdayStart = json.regs[1].rules['thu'].start;
//      this.sideTwo.ThursdayStop = json.regs[1].rules['thu'].stop;
//      this.sideTwo.FridayStart = json.regs[1].rules['fri'].start;
//      this.sideTwo.FridayStop = json.regs[1].rules['fri'].stop;
//      this.sideTwo.SaturdayStart = json.regs[1].rules['sat'].start;
//      this.sideTwo.SaturdayStop = json.regs[1].rules['sat'].stop;
//      this.sideTwo.SundayStart = json.regs[1].rules['sun'].start;
//      this.sideTwo.SundayStop = json.regs[1].rules['sun'].stop;
// }

// desserts = {"apples" => "Apple Strudel", "oranges" =>
// }


var Spot = function(json) {
   this.sideOne = {}
     this.sideOne.Side = json.regs[0].side;
     // this.sideOne.AlternativeParking = json.regs[0].altparking;
     this.sideOne.Regulations = {
           Monday : [json.regs[0].rules['mon'].start, json.regs[0].rules['mon'].stop],
           Tuesday : [json.regs[0].rules['tue'].start, json.regs[0].rules['tue'].stop],
           Wednesday : [json.regs[0].rules['wed'].start, json.regs[0].rules['wed'].stop],
           Thursday : [json.regs[0].rules['thu'].start, json.regs[0].rules['thu'].stop],
           Friday : [json.regs[0].rules['fri'].start, json.regs[0].rules['fri'].stop],
           Saturday : [json.regs[0].rules['sat'].start, json.regs[0].rules['sat'].stop],
           Sunday : [json.regs[0].rules['sun'].start, json.regs[0].rules['sun'].stop]
     }
}

Date.prototype.getDayName = function() {
  var d = ['Sunday','Monday','Tuesday','Wednesday',
  'Thursday','Friday','Saturday'];
  return d[this.getDay()];
}

Spot.getCurrentDayRegs = function() {
  var today = new Date();
  var todayName = today.getDayName();

  for (var dayReg in this.sideOne.Regulations) {
    if (dayReg === todayName) { //matches property name against today's name
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