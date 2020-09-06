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

fanSize         = 40;
heatSinkRadius  = 26/2;
fanDuctDepth    = 26;

addBlowerFanLugs        = true; // change this to false if blower fan lugs are not needed

// create fan lugs for a blower fan
module blowerFanLugs()
{
	difference() 
    {
        // Fan attachment to body.
		hull() 
        {
			translate([19, -15, 0])
			cylinder(r=fanLugRadiusInner, h=fanThickness+2*fanLugThickness, center=true);
			cylinder(r=fanLugRadiusOuter, h=fanThickness+2*fanLugThickness, center=true);
            
            translate([0, -15, 0])
			cylinder(r=fanLugRadiusInner, h=fanThickness+2*fanLugThickness, center=true);
        }

		// Screw hole.
        cylinder(r=m3LooseRadius, h=fanThickness+2*fanLugThickness+smidge, center=true);
	}
}

module cooler(){
// create the HeffaBot Fan Duct for PolyStroooder heatsink
  difference(){
    union(){
//        translate([5, 26.5, 2]) cylinder(r=7/2, h=4, center=true);
//        translate([21, 26.5, 2]) cylinder(r=7/2, h=4, center=true);
        difference(){
            // start with the basic cylinder shape
            translate([heatSinkRadius, heatSinkRadius, 0])
            rotate([0,0,0]) cylinder(r=heatSinkRadius+2,h=25);
            
            // open up the cylinder at fan side
            translate([1, 25/2+2+smidge, 0]) cube(size=[23,55/2,25], center=false);
        }

        // add fan duct
        //translate([0, fanDuctDepth+4, 0]) rotate([90, 0, 0])
        //fan_mount(size=fanSize,thick=heatSinkRadius,cutter=true );
        translate([13, fanDuctDepth+12, 0]) rotate([0, 0, 180]) duct_1();
        // lugs to connect an external blower fan for plastic cooling to the fan duct
        if (addBlowerFanLugs)
            translate([heatSinkRadius, -11, 22.5])
            rotate([180, 90, 0])
            blowerFanLugs();
    
    }
    
    //translate([10, 10, 0]) cube(size=[21,60,43], center=false);
    // cut out cylinder & blower fan lugs at outlet side
    translate([heatSinkRadius, -6, heatSinkRadius])
    cube(size=[15,20,27], center=true);
    
    // hollow out the zylinder for the heatsink
    translate([heatSinkRadius, heatSinkRadius, -1])  rotate([0,0,0])
    cylinder(r=heatSinkRadius,h=26+(smidge*4));
    
    // holes for PolyStroooder mount clamp bolts
    translate([heatSinkRadius, heatSinkRadius, -smidge*3])
    for (a = [30:60:360]) {
        rotate([0, 0, a])translate([0, mount_radius, 0]) cylinder(r=5.7/2, h=3);
    }

  }
}

module duct_inside_90(){
  
  translate([0,-8,24]) cylinder(r1=18, r2=15, h=10);
  hull(){
    translate([0,-8,24]) cylinder(d=35, h=1);
    translate([-(23/2)+1, (25/2)+2, 0]) cube(size=[21,7,23], center=false);
  }
}

module duct_90p(){
  hull(){
    translate([-fanSize/2, -(fanSize/2)-8, 24]) fan_mount(size=fanSize,thick=1,cutter=true);
    translate([-23/2, (25/2), 0]) cube(size=[23,10,25], center=false);
  }
}

module duct_90(){
  
  difference(){
    union(){
      translate([-fanSize/2, -(fanSize/2)-8, 25]) fan_mount(size=fanSize,thick=4,cutter=true);
      duct_90p();
    }
    duct_inside_90();
  }
}

module duct_inside_0(){
  
  translate([0,0,28]) rotate([90, 0, 0]) cylinder(r1=18, r2=15, h=10);
  hull(){
    translate([0,0,28]) rotate([90, 0, 0]) cylinder(d=35, h=1);
    translate([-(23/2)+1, (25/2), 0]) cube(size=[21,1,23], center=false);
  }
  translate([-(23/2)+1, (25/2), 0]) cube(size=[21,7,23], center=false);
}

module duct_0p(){
  hull(){
    translate([-fanSize/2, 0, 8]) rotate([90, 0, 0]) fan_mount(size=fanSize,thick=1,cutter=true);
    translate([-24/2, (25/2), 0]) cube(size=[24,1,25], center=false);
  }
  translate([-24/2, (25/2), 0]) cube(size=[24,10,25], center=false);
}

module duct_0(){
  
  //duct_inside_0();
  difference(){
    union(){
      translate([-fanSize/2, 0, 8]) rotate([90, 0, 0])  fan_mount(size=fanSize,thick=4,cutter=true);
      duct_0p();
    }
    duct_inside_0();
  }
}

module duct_inside_1(){
  
  translate([0,5,28]) rotate([90, 0, 0]) cylinder(r1=18, r2=15, h=10);
  hull(){
    translate([0,5,28]) rotate([90, 0, 0]) cylinder(d=35, h=1);
    translate([-(23/2)+1, (25/2), 0]) cube(size=[21,1,23], center=false);
  }
  translate([-(23/2)+1, (25/2), 0]) cube(size=[21,7,23], center=false);
}

module duct_1p(){
  hull(){
    translate([-fanSize/2, 5, 8]) rotate([90, 0, 0]) fan_mount(size=fanSize,thick=1,cutter=true);
    translate([-24/2, (25/2), 0]) cube(size=[24,1,25], center=false);
  }
  translate([-24/2, (25/2), 0]) cube(size=[24,10,25], center=false);
}

module duct_1(){
  
  //duct_inside_0();
  difference(){
    union(){
      translate([-fanSize/2, 5, 8]) rotate([90, 0, 0])  fan_mount(size=fanSize,thick=4,cutter=true);
      duct_1p();
    }
    duct_inside_1();
  }
}

cooler();



