// Delta-Six 3D Printer 
// Created by Sage Merrill
// Released on Openbuilds.com
// Based on orginal design by Johann C. Rocholl (Kossel Printer)
// License = Attribution Share Alike - CC BY SA

include <configuration.scad>;


height = 21;
thickness = 5;
motor_offset = 48.7;
triangle_side = 316;
printer_height = 680;
delta_radius = 212.4;

module slot_fill(length = 20) {
	difference() {
		translate([0, 0, 0]) rotate([0, 0, 0])
		 cylinder(r=4.5, h=length, center=true,  $fn=4);	

//plane sides
		translate([-3.8, 0, 0]) rotate([0, 0, 0])
		 cube([4, 20, length*2], center=true);
		translate([3, 0, 0]) rotate([0, 0, 0])
		 cube([6, 20, length*2], center=true);
	}
}

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

//translate([0, 90, 0]) color([1,0,0]) Nema23();

module vertex() {
  union() {
    difference() {
	  union() {
// Corner Section
		intersection() {
		  minkowski() {
			translate([0, 40, 0]) rotate([0, 0, 0])
			  cylinder(r=63-thickness, h=height-1, center=true, $fn=6);					
			  cylinder(r=thickness, h=1, center=true, $fn=60);
		  }
		  translate([0, -20, 0]) rotate([0, 0, 30])
		  cylinder(r=50, h=height+1, center=true, $fn=6);
 		}
		translate([-45, 0, 0]) intersection() {
		  minkowski() {
			translate([0, 40, 0]) rotate([0, 0, 0])
			  cylinder(r=63-thickness, h=height-1, center=true, $fn=6);					
			  cylinder(r=thickness, h=1, center=true, $fn=60);
		  }
		  translate([0, -20, 0]) rotate([0, 0, 30])
		  cylinder(r=50, h=height+1, center=true, $fn=6);
 		}
		translate([45, 0, 0]) intersection() {
		  minkowski() {
			translate([0, 40, 0]) rotate([0, 0, 0])
			  cylinder(r=63-thickness, h=height-1, center=true, $fn=6);					
			  cylinder(r=thickness, h=1, center=true, $fn=60);
		  }
		  translate([0, -20, 0]) rotate([0, 0, 30])
		  cylinder(r=50, h=height+1, center=true, $fn=6);
 		}

// A Frame
        
*				translate([0, 40, 40]) intersection() { 
				    translate([0, 40, 0]) rotate([0, 0, -90])
					 cylinder(r=70, h=height, center=true, $fn=3);
					translate([0, 357, 0]) rotate([0, 0, 30])
					 cylinder(r=64, h=height*2, center=true, $fn=6);
					translate([0, 35, 0])  rotate([0, 0, 0])
					 cube([200, 60, height*2], center=true);
				}
*				intersection() { 
					translate([0, 40, 0]) rotate([0, 0, -90])
					 cylinder(r=70, h=height, center=true, $fn=3);
					translate([0, 35, 0]) rotate([0, 0, 30])
					 cylinder(r=64, h=height*2, center=true, $fn=6);
					translate([0, 35, 0])  rotate([0, 0, 0])
					 cube([200, 60, height*2], center=true);
				}
                 //beam test
                 color([0, 1, 0]) translate([-97, 40, 5]) rotate([0, 0, 120]) cube([70, 20, 10], center=true);
                
				union() { 
                     translate([-80, 50, 0]) rotate([0, 0, 120]) cube([70, 20, 21], center=true);
                     translate([80, 50, 0]) rotate([0, 0, -120]) cube([70, 20, 21], center=true);
                     translate([0, 75, 0]) rotate([0, 0, 0]) cube([181, 20, 21], center=true);
                     translate([0, 30, 0]) rotate([0, 0, 0]) cube([140, 70, 21], center=true);
                     translate([0, 60, 0]) rotate([0, 0, 0]) cube([160, 30, 21], center=true);
				}

// Slot Fill
			for (a = [-1, 1]) translate([0, 40, 0]) rotate([0, 0, 30*a]) scale([a, 1, 1]) {
				translate([-74, 53.75, 0]) rotate([90, 0, 0])
					 slot_fill(60);
			}

		}
  for (a = [-1, 1]){
    translate([-60*a, 40, 0]) rotate([0, 90, 30*a]){
      hull(){
        translate([10, 0, 0]) cylinder(r=6, h=30, center=true, $fn=60);
        cylinder(r=6, h=30, center=true, $fn=60);
      }
    }
    translate([-80*a, 71, 0]) rotate([0, 90, 30*a]){
      hull(){
        translate([10, 0, 0]) cylinder(r=6, h=30, center=true, $fn=60);
        cylinder(r=6, h=30, center=true, $fn=60);
      }
    }
  }

// Side Screw Sockets
			for (a = [-1, 1]) translate([0, 0, 0]) rotate([0, 0, 30*a]) {
				translate([-63.5*a, 111, 0]) rotate([0, 0, 0]) {
					for (y = [-46, -9]) {
						translate([a*7, y, 0]) rotate([0, a*90, 0])
						 cap_bolt_boolean(m5_bolt_boolean, 10);
			         }
				}
			}
// Beam Screw Sockets 
    for (a = [-1, 1]) translate([0, 0, 0]) rotate([180, 0, 30*a]) {
      //for (z = [-10, 10]) translate([-25.1*a, 0.5, z]) rotate([90, 0, 0]) {
      translate([-65.1*a, -25.5, 0]) rotate([90, 0, 0]) {
        cap_bolt_boolean(m5_bolt_boolean, 40);
      }
    }

//Upper A Frame Hole
*			translate([0, 90, 0]) rotate([0, 0, 0]){
				minkowski() {
					intersection() {
						translate([0, 0, 0]) rotate([0, 0, -90])
						 cylinder(r=100, h=height, center=true, $fn=3);
						translate([0, -62, 0])  rotate([0, 0, 0])
						 cube([150, 16, height], center=true);
					}
				cylinder(r=thickness, h=1, center=true, $fn=60);
				}

//Lower A Frame Hole
*				minkowski() {
					intersection() {
						translate([0, 0, 0]) rotate([0, 0, -90])
						 cylinder(r=100, h=height, center=true, $fn=3);
						translate([0, -28.5, 0]) rotate([0, 0, 0])
						 cube([250, 16, height*2], center=true);
					}
					cylinder(r=thickness, h=1, center=true, $fn=60);
				}
			}

// Misumi Beam Boolean 
			difference() {
				translate([0, 0, 330-height+5]) rotate([0, 0, 90])
				 cube([20.1+extra_boolean, 40.1+extra_boolean, 660],center=true);
//			 misumibeam(20, 40, 660, extra_boolean);
			
// 			front slot fill
			for (a = [-1, 1])
			 translate([-10*a, -(20.1+extra_boolean)/2, 0]) rotate([0, 0, -90]) {
			  slot_fill(height);
				}
			}

// M3 Nut channels
*			for (a = [-1, 1]) translate([26*a, 8, -1.24]) rotate([0, 0, 150*a]) {
				hull() {	
					for (h = [-1,1]) {
						translate([0, 10*h-9.5, 0]) rotate([0, 0, 30])
						 flat_nut_boolean(m3_bolt_boolean);
					}
				}
			}



// Corner Screw Sockets
			for (z = [-1, 1]) scale([1, 1, z]) {
				for (a = [-1, 1]) translate([10*a, -16, 0]) rotate([90, 0, 180]) {
				 cap_bolt_boolean(m5_bolt_boolean, 10);
				}
 			}

// Wire runs 
*			for (a = [-1, 1]) translate([0, 0, 0]) rotate([0, 0, 30*a]) {
				translate([1*a, 30, 0]) rotate([90, 30, 0])
				 cylinder(r=5, h=60, center=true, $fn=30);
			}
		}
	}


// Beam Supports 
*#			for (a = [-1, 1]) translate([0, 0, 0]) rotate([0, 0, 30*a]) {
			 translate([-25.1*a, triangle_side/2+25.9, 0]) rotate([90, 0, 0])
			  misumibeam(20, 40, triangle_side, 0);
			}

// Fix overhang Pads 
	for (m = [1, -1]) translate([0, 0, 0]) scale([1, 1, m]) {
		for (a = [-1, 1]) translate([26*a, 8, height/2-19.25]) rotate([0, 0, 0]) {
			translate([0, 0, 0]) rotate([0, 0, 0])
			 cylinder(r=5, h=0.2, $fn=30);
		}
	}
}


// Primary Placement
translate([0, 0, height/2]) rotate([0, 0, 0])
 vertex();




// Full Setup
*	for (a = [0:120:360]) rotate([0, 0, a]) {
		translate([0, delta_radius, 0]) rotate([0, 0, 180])
		 vertex();
	}
//measure
*%union() {
*	translate([0, 0, 0]) rotate([0, 0, 0])
 	 cylinder(r=delta_radius, h=10, $fn=30, center=true);
// glass plate
	translate([0, 0, 30]) rotate([0, 0, 0])
 	 cylinder(r=350/2, h=10, $fn=90);
}