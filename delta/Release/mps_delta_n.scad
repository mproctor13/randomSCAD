// Delta-Six 3D Printer 
// Created by Sage Merrill
// Released on Openbuilds.com
// Based on orginal design by Johann C. Rocholl (Kossel Printer)
// License = Attribution Share Alike - CC BY SA

include <configuration.scad>;
//include <misumibeam.scad>;
include <end_cap1.scad>;

include <top_vortex_n.scad>;
include <middle_vortex_n.scad>;
include <bottom_vortex_n.scad>;


include <nema23.scad>;
include <nema23_spacer.scad>;


//translate([0, 10, 10]) color([1,0,1]) rotate([0,45,0]) cube([152, 152, 152], center=true);


// Full Setup
for (a = [0:120:360]) rotate([0, 0, a]) {
    
  //Top plane
  translate([0, delta_radius+18, 1380]) rotate([0, 0, 180]) top_vortex_n();
  translate([0,-184,1370]) rotate([0, 90, 0]) color([0,0,0]) misumibeam(20, 20, 500);
  translate([0, delta_radius-22, 1357]) color([0,0,1]) rotate([0, 180, 0]) end_cap1();
    
  //middle plate
  translate([0, delta_radius+18, 0]) rotate([0, 0, 180]) middle_vortex_n();
  //translate([0,-delta_radius,10]) rotate([0, 90, 0]) color([0,0,0]) misumibeam(20, 20, 500);
  translate([0,-184,10]) rotate([0, 90, 0]) color([0,0,0]) misumibeam(20, 20, 500);
    
  translate([0, delta_radius+18, 630]) color([0,0,0]) misumibeam(20, 20, 1500);
  translate([0, delta_radius-22, 690]) color([0.5,0.5,0.5]) cylinder(r=8, h=1330, center=true, $fn=60);
  translate([0, delta_radius-22, 20]) color([0,0,1]) end_cap1();
  translate([0, delta_radius-22, -25]) color([1,0.5,0]) rotate([0, 0, 90]) nema23_spacer(25);
  translate([0, delta_radius-22, -75]) color([1,0,0]) rotate([0, 0, 270]) Nema23(); //15mm overlap
    
  //bottom plate
  translate([0, delta_radius+18, -120]) rotate([0, 0, 180]) bottom_vortex_n();
  translate([0,-184,-110]) rotate([0, 90, 0]) color([0,0,0]) misumibeam(20, 20, 500);
  
  translate([-150,340,0]) color([1,0,0]) cube([300, 25.4+6, 1380]);
    
}
*  rotate([0, 0, 120]) translate([-240, -320,0])  color([0,1,0]) cube([475, 25.4+6, 1000]);
*  rotate([0, 0, -120]) translate([-240, -320,0])  color([0,1,0]) cube([475, 25.4+6, 1000]);
  

//measure
union() {
*	translate([0, 0, 0]) rotate([0, 0, 0])
 	 cylinder(r=delta_radius, h=5, $fn=30, center=true);
// glass plate
	translate([0, 0, 30]) rotate([0, 0, 0])
 	 color([.45, .45, .45]) cylinder(r=266.7, h=5, $fn=90); //22" table top
}