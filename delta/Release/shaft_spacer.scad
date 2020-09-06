
include <ISOThreadUM2.scad>;

module shaft_spacer(length=10){
  difference(){
    translate([0, 0, 0]) cylinder(r=5, h=length, center=false, $fn=60);
    translate([0, 0, -2]) cylinder(r=3.0, h=length+10, center=false, $fn=60);
  }
}

shaft_spacer(10);
//translate([-10, 0, 0]) rotate([0, 90, 0]) hex_bolt(5,25);
