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

fanSize         = 30;
heatSinkRadius  = 25/2;
fanDuctDepth    = 20;

addBlowerFanLugs        = true; // change this to false if blower fan lugs are not needed

// create fan lugs for a blower fan
module blowerFanLugs()
{
	difference() 
    {
        // Fan attachment to body.
		hull() 
        {
			translate([1, 0, 0]) cylinder(r=fanLugRadiusOuter, h=fanThickness+2*fanLugThickness, center=true);
            
            translate([0, -15, 0])
			cylinder(r=fanLugRadiusInner, h=fanThickness+2*fanLugThickness, center=true);
            
            translate([10, -15, 0])
			cylinder(r=fanLugRadiusInner, h=fanThickness+2*fanLugThickness, center=true);
        }

		// Screw hole.
        translate([1, 0, 0]) cylinder(r=m3LooseRadius, h=fanThickness+2*fanLugThickness+smidge, center=true);
	}
}
 rotate([0, 0, 150]) translate([-12, -12, 3]){
 //translate([heatSinkRadius, heatSinkRadius, 0]) color([0,0,0]) cylinder(r=heatSinkRadius,h=25);
        
          translate([-2.5, fanDuctDepth+20, 11]) rotate([115, 0, 0]) {
            
            //translate([15, 40, 15]) cube([40,20,30],center=true);
          }
// create the HeffaBot Fan Duct for PolyStroooder heatsink
difference()
{
    union()
    {
        difference()
        {
            // start with the basic cylinder shape
            translate([heatSinkRadius, heatSinkRadius, 0])
            rotate([0,0,0])
            cylinder(r=heatSinkRadius+4,h=35);
          translate([-1, 14, 3]) cube(size=[27,22,22], center=false);
            // open up the cylinder at fan side
          translate([-2.5, fanDuctDepth+20, 11]) rotate([115, 0, 0]) {
            
            //translate([-5, 30, 0]) cube(20,50,0);
              hull(){
              translate([3, 3, 5]) cylinder(r=1.5, h=25);
              translate([27, 3, 5]) cylinder(r=1.5, h=25);
              translate([3, 18, 5]) cylinder(r=1.5, h=20);
              translate([27, 18, 5]) cylinder(r=1.5, h=20);
            }
          }
        }

        // add fan duct
        translate([-2.5, fanDuctDepth+20, 8]) rotate([115, 0, 0]) {
        difference(){
              fan_mount(size=fanSize,thick=fanDuctDepth,cutter=true);
              hull(){
              translate([3, 3, 5]) cylinder(r=1.5, h=25);
              translate([27, 3, 5]) cylinder(r=1.5, h=25);
              translate([3, 22, 5]) cylinder(r=1.5, h=20);
              translate([27, 22, 5]) cylinder(r=1.5, h=20);
            }
          }
        }
        
        // lugs to connect an external blower fan for plastic cooling to the fan duct
        if (addBlowerFanLugs)
            translate([heatSinkRadius, -11, fanSize-6])
            rotate([180, 90, 0])
            blowerFanLugs();
    
    }
    
    // cut out cylinder & blower fan lugs at outlet side
    translate([heatSinkRadius, -6, heatSinkRadius]) cube(size=[15,20,55], center=true);
    
    // hollow out the zylinder for the heatsink
    translate([heatSinkRadius, heatSinkRadius, -1])
    rotate([0,0,0])
    cylinder(r=heatSinkRadius,h=40+(smidge*4));
    
    // holes for PolyStroooder mount clamp bolts
    translate([heatSinkRadius, heatSinkRadius, -smidge*3])
    for (a = [30:60:360]) 
    {
        rotate([0, 0, a])
        translate([0, mount_radius, 0])
        cylinder(r=5.7/2, h=3);
    }

  }
}
