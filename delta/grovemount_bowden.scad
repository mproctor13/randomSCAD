
include <MCAD/stepper.scad>

//translate([0,0,0]) rotate([0,0,0]) vslot20x20(200, vslot_color_black);
//translate([0,37,42]) rotate([0,90,0]) color([1,1,1]) motor(Nema17, NemaMedium, dualAxis=false);
//
//translate([0,0,0]) rotate([0,90,0]) color([1,1,1]) motor(Nema17, NemaMedium, dualAxis=false);
//
//
//translate([0,-10,0]) rotate([0,90,0]) cylinder(d=10, h=25, center=true, $fn=30);

translate([-8,0,-8]) color("white") import("griffin/filament_guide_1_75.stl");
//
//translate([0,0,0]) rotate([90,0,0]) cylinder(d=16, h=15, center=true, $fn=120);

translate([0,20,0]) 
hull(){
translate([0,0,0]) rotate([90,0,0]) cylinder(d=15.9, h=1, center=true, $fn=120);
translate([0,6,0]) rotate([90,0,0]) cylinder(d=2.1, h=1, center=true, $fn=120);
}
