// Delta-Six 3D Printer 
// Created by Sage Merrill
// Released on Openbuilds.com
// Based on orginal design by Johann C. Rocholl (Kossel Printer)
// License = Attribution Share Alike - CC BY SA


include <metric_fastners.scad>;
use <nema17.scad>;
use <beam.scad>;
use <timing_belts.scad>;

$fn=20;

// Increase this if your slicer or printer makes the holes too small.
extra_radius = 0.10;
extra_boolean = 0.15;

// Delta Parameters
global_delta_arm_seperation = 55;
global_effector_bore_radius = 21;
global_mounting_hole_radius = 27;

// M5 Hardware
m5_bolt = m5_major_radius*2;
m5_bolt_boolean = m5_bolt+extra_radius;

// M3 Hardware
m3_bolt = m3_major_radius*2;
m3_bolt_boolean = m3_bolt+extra_radius;

// NEMA17 stepper motor
motor_length = 47.5;
motor_shaft_radius= 5.00/2;


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



height = 21;
thickness = 5;
motor_offset = 48.7;
triangle_side = 316;
printer_height = 680;
delta_radius = 300;