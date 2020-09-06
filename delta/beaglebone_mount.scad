include <vslot.scad>
include <MCAD/shapes.scad>

module slot_fill(length = 20){
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

module beagle_bone_mount(){
  difference(){
    union(){
      translate([12,0,31]) rotate([0,90,0]) roundedBox(56, 70, 4, 2);
      translate([75,0,5]) rotate([0,90,0]) roundedBox(4, 70, 125, 2);
      //slot fills
      translate([10,0,10]) rotate([90,0,0]) slot_fill(length=65);
      translate([10,0,50]) rotate([90,0,0]) slot_fill(length=65);
      for(Y=[-1,1]){
        translate([55,24.1*Y,7]) cylinder(d=6, h=8, center=true, $fn=30);
        translate([121,20.95*Y,7]) cylinder(d=6, h=8, center=true, $fn=30);
      }
      for(Y=[-1,1]){
        translate([0,33*Y,0])
          hull(){
            translate([12,0,6]) sphere(d=4, $fn=60);
            translate([41,0,6]) sphere(d=4, $fn=60);
            translate([12,0,38]) sphere(d=4, $fn=60);
          }
      }
    }
    translate([12,0,30]) rotate([0,90,0]) roundedBox(22, 50, 6, 2);
    for(Y=[-1,1], Z=[10,50]){
      translate([10,25*Y,Z]) rotate([0,90,0]) cylinder(d=5, h=10, center=true, $fn=30);
      translate([19,25*Y,10]) rotate([0,90,0]) cylinder(d=8, h=10, center=true, $fn=30);
    }
    for(Y=[-1,1]){
      translate([55,24.1*Y,5]) cylinder(d=3.2, h=20, center=true, $fn=30);
      translate([121,20.95*Y,5]) cylinder(d=3.2, h=20, center=true, $fn=30);
      translate([133,30*Y,5]) cylinder(d=3.2, h=20, center=true, $fn=30);
    }
    translate([70,0,5]) rotate([0,0,0]) roundedBox(100, 35, 6, 5);
  }
}

//translate([0,100,10]) rotate([90,0,0]) vslot20x20(200, vslot_color_black);
//translate([0,100,50]) rotate([90,0,0]) vslot20x20(200, vslot_color_black);
//
//include <griffin/beagleboneblack.scad>
//translate([40.5,-27.4,11.5]) beagleboneblack();
//
beagle_bone_mount();
