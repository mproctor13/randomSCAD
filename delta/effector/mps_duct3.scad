// Fan duct for the PolyStroooder Tri Hotend heatsink.
//
// This work is licensed under a Creative Commons
// Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
// Visit: http://creativecommons.org/licenses/by-nc-sa/4.0/
//
// Uses the fan_holder_v2.scad OPENSCAD Library file by DoomMeister
// http://www.thingiverse.com/thing:18273
//
// Additions and modifications for HeffaBot & PolyStroooder Tri Hotend by Håkan Berg
// hakan.berg.666@gmail.com
//
// Holds one 25mm fan to the PolyStroooder Tri Hotend heatsink.
// The fan duct is rather thin, so I'd recommend to print in a tough material, like Nylon or similar.
//
// 2016-03-08 Håkan berg
// - Added the option for adding a connection lug for a Blower Fan.
// - moved some generic parameters to configuration.scad

$fn = 360/4;
include <configuration.scad>;
use <fan_holder_v2.scad>;

fanSize         = 25;
heatSinkRadius  = 26/2;
fanDuctDepth    = 26;
ducts           = 3;

module cooler(){
// create the HeffaBot Fan Duct for PolyStroooder heatsink
  difference(){
    union(){
      difference(){
        // start with the basic cylinder shape
        translate([heatSinkRadius, heatSinkRadius, 0])
          rotate([0,0,0]) cylinder(r=heatSinkRadius+4,h=25);
      }
      // add fan duct
      translate([heatSinkRadius, heatSinkRadius, -smidge*3])
        for (a = [0:120:(ducts*100)]) {
          rotate([0, 0, a]) translate([0, -(mount_radius*2)+4, 0.5]) duct_0();
        }
    }
    translate([heatSinkRadius, heatSinkRadius, -smidge*3])
      for (a = [0:120:(ducts*100)]) {
        rotate([0, 0, a]) translate([0, -(mount_radius*2)+4, 0.5]) 
          duct_inside_0();
    }
    
    //translate([-10, -10, 0]) cube(size=[21,30,43], center=false);
    translate([heatSinkRadius, heatSinkRadius, -1])  rotate([0,0,0])
      cylinder(r=heatSinkRadius,h=26+(smidge*4));
    
    // holes for PolyStroooder mount clamp bolts
    translate([heatSinkRadius, heatSinkRadius, -smidge*3])
      for (a = [30:60:360]) {
        rotate([0, 0, a]) translate([0, mount_radius, 0]) cylinder(r=5.7/2, h=3);
    }
  }
}


module duct_inside_0(){
  hull(){
    translate([-fanSize/2, 0, 8]) hull(){
      translate([4, 1, 4]) rotate([90, 0, 0]) cylinder(r=2.5, h=1.1);
      translate([4, 1, 21]) rotate([90, 0, 0]) cylinder(r=2.5, h=1.1);
      
      translate([21, 1, 4]) rotate([90, 0, 0]) cylinder(r=2.5, h=1.1);
      translate([21, 1, 21]) rotate([90, 0, 0]) cylinder(r=2.5, h=1.1);
    }
    translate([-(23/2)+1, (25/2), 1]) cube(size=[21,1,23], center=false);
  }
  translate([-(23/2)+1, (25/2), 1]) cube(size=[21,17,23], center=false);
}

module duct_0p(){
  hull(){
    translate([-fanSize/2, 0, 8]) hull(){
      translate([2, 1, 2]) rotate([90, 0, 0]) cylinder(r=2.5, h=1);
      translate([2, 1, 23]) rotate([90, 0, 0]) cylinder(r=2.5, h=1);
      
      translate([23, 1, 2]) rotate([90, 0, 0]) cylinder(r=2.5, h=1);
      translate([23, 1, 23]) rotate([90, 0, 0]) cylinder(r=2.5, h=1);
    }
    translate([-fanSize/2, 0, 8]) cube(size=[fanSize,1,fanSize], center=false);
    translate([-24/2, (25/2), 0]) cube(size=[24,1,25], center=false);
  }
  translate([-24/2, (25/2), 0]) cube(size=[24,10,25], center=false);
}

module duct_0(hollow=false){
  difference(){
    union(){
      translate([-fanSize/2, 0, 8]) rotate([90, 0, 0])  fan_mount(size=fanSize,thick=4,cutter=true);
      duct_0p();
    }
    if (hollow) {
      duct_inside_0();
    }
  }
}

cooler();



