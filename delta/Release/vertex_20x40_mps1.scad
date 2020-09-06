// Delta-Six 3D Printer 
// Created by Sage Merrill
// Released on Openbuilds.com
// Based on orginal design by Johann C. Rocholl (Kossel Printer)
// License = Attribution Share Alike - CC BY SA

include <configuration.scad>;
//include <misumibeam.scad>;
include <end_cap1.scad>;

//include <vertex.scad>;
include <middle_vortex.scad>;
include <bottom_vortex.scad>;

module Nema23(length=2.08)
{
	inch = 25.4; // inch to mm
	translate([0,0,length]*inch){
		difference(){
			hull() for(x=[-1,1],y=[-1,1])
				translate([x*1.8,y*1.8,-length]*.5*inch)
				cylinder(d=.4*inch,h=length*inch,center=true,$fn=36); // Main Motor Body
			for(x=[-1,1],y=[-1,1]){
				translate([x*1.85,y*1.85,-length+1]*.5*inch)
					cylinder(d=.197*inch,h=length*inch,center=true,$fn=36); // Screw Holes
				translate([x*1.87,y*1.87,-length-.2*2]*.5*inch)
					cube([.37,.37,length]*inch,center=true); // Motor Body inset parts
			}
		}
		cylinder(d=1.5*inch,h=.063*inch,$fn=90); // Motor Circle Thing
		cylinder(d=.25*inch,h=1*inch,$fn=36); // Rod
		translate([1.10,-.41,-length]*inch) cube([.2,.82,.45]*inch); // Cable Connector
	}
}


//translate([0, 10, 10]) color([1,0,1]) rotate([0,45,0]) cube([152, 152, 152], center=true);


module top_vortex(width=1) {
  //beam test
  //color([0, 1, 0]) translate([-97, 40, 5]) rotate([0, 0, 120]) cube([70, 20, 10], center=true);
  rotate([0, 180, 0])
  difference(){
    translate([0, 0, height/2]) rotate([0, 0, 0]) vertex(width);
    translate([0, 40, 19]) color([0,1,0]) cylinder(r=12, h=5, center=true, $fn=60);
    translate([0, 40, 19]) color([0,1,0]) cylinder(r=6.5, h=40, center=true, $fn=60);
  }
}
// Primary Placement
//top_vortex();

module nema23_plate(){
  difference(){
    hull() for(x=[-1,1],y=[-1,1]) translate([23*x, 23*y, 0]) cylinder(r=5, h=5, center=true, $fn=60);
    translate([0, 0, -5]) cylinder(d=(1.5*25.4)+.1,h=10,$fn=90);
    //bolt holes
    for(a = [-1, 1]){
      translate([23.5*a, -23.5, 19]) color([0,1,0]) cylinder(r=2.5, h=50, center=true, $fn=60);
      translate([23.5*a, 23.5, 19]) color([0,1,0]) cylinder(r=2.5, h=50, center=true, $fn=60);
    }
  }
}
// Primary Placement
//bottom_vortex(2);

module nema23_spacer(height=30){
  translate([0, 0, 2.5]) nema23_plate();
  for(a = [-1, 1]){
    linear_extrude(height) {
      polygon([[28*a,8],[28*a,13],[13*a,28],[8*a,28]], paths=[[0,1,2,3]], h=10);
    }
  }
  translate([-28, -17, 0]) cube([5,30,height]);
  translate([23, -17, 0]) cube([5,30,height]);
  translate([0, 0, height-2.5]) nema23_plate();
}
//nema23_spacer(30);
//translate([0, 40, -50]) color([1,0,0]) rotate([0, 0, 90]) Nema23();
//color([1,0,0]) rotate([0, 0, 90]) Nema23();
// Full Setup
for (a = [0:120:360]) rotate([0, 0, a]) {
  translate([0, delta_radius+45, 0]) rotate([0, 0, 180]) middle_vortex();
  translate([0,-235,10]) rotate([0, 90, 0]) color([0,0,0]) misumibeam(20, 20, 500);
*  translate([0,delta_radius+45,250]) color([0,0,0]) misumibeam(20, 20, 1500);
*  translate([0,delta_radius+5,500]) color([0.5,0.5,0.5]) cylinder(r=8, h=980, center=true, $fn=60);
    
*  translate([0, delta_radius+5, 20]) color([0,0,1]) end_cap1();
*  translate([0, delta_radius+5, -25]) color([1,0.5,0]) rotate([0, 0, 90]) nema23_spacer(25);
*  translate([0, delta_radius+5, -75]) color([1,0,0]) rotate([0, 0, 270]) Nema23(); //15mm overlap
    
  //Top plane
*  translate([0, delta_radius+45, 1010]) rotate([0, 0, 180]) top_vortex();
*  translate([0,-235,1000]) rotate([0, 90, 0]) color([0,0,0]) misumibeam(20, 20, 500);
    
    
*  translate([0, delta_radius+45, -120]) rotate([0, 0, 180]) bottom_vortex();
*  translate([0,-235,-110]) rotate([0, 90, 0]) color([0,0,0]) misumibeam(20, 20, 500);
  
  translate([-150,360,0]) color([1,0,0]) cube([300, 25.4+6, 1000]);
    
}
  rotate([0, 0, 120]) translate([-240, -320,0])  color([0,1,0]) cube([475, 25.4+6, 1000]);
  rotate([0, 0, -120]) translate([-240, -320,0])  color([0,1,0]) cube([475, 25.4+6, 1000]);
  

//measure
union() {
*	translate([0, 0, 0]) rotate([0, 0, 0])
 	 cylinder(r=delta_radius, h=5, $fn=30, center=true);
// glass plate
	translate([0, 0, 30]) rotate([0, 0, 0])
 	 color([.45, .45, .45]) cylinder(r=292.1, h=5, $fn=90); //23" table top
}