// Delta-Six 3D Printer 
// Created by Sage Merrill
// Released on Openbuilds.com
// Based on orginal design by Johann C. Rocholl (Kossel Printer)
// License = Attribution Share Alike - CC BY SA

include <configuration.scad>;
//include <misumibeam.scad>;
include <end_cap1.scad>;

include <top_vortex.scad>;
include <middle_vortex.scad>;
include <bottom_vortex.scad>;


include <nema23.scad>;
include <nema23_spacer.scad>;


// Full Setup
for (a = [0:120:360]) rotate([0, 0, a]) {
  translate([0, delta_radius+45, 0]) rotate([0, 0, 180]) middle_vortex();
  translate([0,-235,10]) rotate([0, 90, 0]) color([0,0,0]) misumibeam(20, 20, 500);
  translate([0,delta_radius+45,250]) color([0,0,0]) misumibeam(20, 20, 1500);
  translate([0,delta_radius+5,500]) color([0.5,0.5,0.5]) cylinder(r=8, h=980, center=true, $fn=60);
    
  translate([0, delta_radius+5, 20]) color([0,0,1]) end_cap1();
  translate([0, delta_radius+5, -25]) color([1,0.5,0]) rotate([0, 0, 90]) nema23_spacer(25);
  translate([0, delta_radius+5, -75]) color([1,0,0]) rotate([0, 0, 270]) Nema23(); //15mm overlap
    
  //Top plane
  translate([0, delta_radius+45, 1010]) rotate([0, 0, 180]) top_vortex();
  translate([0,-235,1000]) rotate([0, 90, 0]) color([0,0,0]) misumibeam(20, 20, 500);
    
    
  translate([0, delta_radius+45, -120]) rotate([0, 0, 180]) bottom_vortex();
  translate([0,-235,-110]) rotate([0, 90, 0]) color([0,0,0]) misumibeam(20, 20, 500);
  
*  translate([-150,360,0]) color([1,0,0]) cube([300, 25.4+6, 1000]);
    
}
*  rotate([0, 0, 120]) translate([-240, -320,0])  color([0,1,0]) cube([475, 25.4+6, 1000]);
*  rotate([0, 0, -120]) translate([-240, -320,0])  color([0,1,0]) cube([475, 25.4+6, 1000]);
  

//measure
union() {
*	translate([0, 0, 0]) rotate([0, 0, 0])
 	 cylinder(r=delta_radius, h=5, $fn=30, center=true);
// glass plate
//	translate([0, 0, 30]) rotate([0, 0, 0])
// 	 color([.45, .45, .45]) cylinder(r=292.1, h=5, $fn=90); //23" table top
}