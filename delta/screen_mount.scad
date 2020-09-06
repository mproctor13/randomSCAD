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

module 7inch_screen(){
  difference(){
    union(){
      color("silver") translate([0, 0, 4.75]) cube([165,107,6.5], center=true);
      color("blue") translate([0, 0, 0.75]) cube([165,107,1.5], center=true);
      color("blue") hull(){
        translate([78.35, 57, 0.75]) cylinder(d=8.3, h=1.5, center=true, $fn=60);
        translate([78.35, -57, 0.75]) cylinder(d=8.3, h=1.5, center=true, $fn=60);
      }
      color("blue") hull(){
        translate([-78.35, 57, 0.75]) cylinder(d=8.3, h=1.5, center=true, $fn=60);
        translate([-78.35, -57, 0.75]) cylinder(d=8.3, h=1.5, center=true, $fn=60);
      }
      
      color("silver") translate([77, 36, -3.1]) cube([12,15,6.25], center=true);
      color("silver") translate([79.5, 17, -1.1]) cube([5.5,7.5,3.2], center=true);
      color("silver") translate([79.5, 3.5, -1.1]) cube([3.71,9.15,4.65], center=true);
//      color("black") translate([77, 8, -3.75]) cube(5.3);
    }
    translate([78.5, 57, 0.74]) cylinder(d=3, h=1.7, center=true, $fn=60);
    translate([78.5, -57, 0.74]) cylinder(d=3, h=1.7, center=true, $fn=60);
    translate([-78.5, 57, 0.74]) cylinder(d=3, h=1.7, center=true, $fn=60);
    translate([-78.5, -57, 0.74]) cylinder(d=3, h=1.7, center=true, $fn=60);
  }
}


module 7inch_screen_mount(){
  difference(){
    hull(){
      translate([0,57,5]) rotate([0,90,0]) cylinder(d=20, h=150, center=true, $fn=60);
      translate([0,-57,5]) rotate([0,90,0]) cylinder(d=20, h=150, center=true, $fn=60);
    
      translate([79,0,5]) rotate([90,0,0]) cylinder(d=20, h=100, center=true, $fn=60);
      translate([-79,0,5]) rotate([90,0,0]) cylinder(d=20, h=100, center=true, $fn=60);
      translate([78.5, 57, 5]) sphere(d=20, center=true, $fn=60);
      translate([78.5, -57, 5]) sphere(d=20, center=true, $fn=60);
      translate([-78.5, 57, 5]) sphere(d=20, center=true, $fn=60);
      translate([-78.5, -57, 5]) sphere(d=20, center=true, $fn=60);
    }
    translate([0, 4, 11]) cube([150,88,10], center=true); //front cutout
    translate([0, 0, -1.5]) cube([167,109,20], center=true);
    hull(){
      translate([78.35, 57, -3.5]) cylinder(d=9.3, h=10.5, center=true, $fn=60);
      translate([78.35, -57, -3.5]) cylinder(d=9.3, h=10.5, center=true, $fn=60);
    }
    hull(){
      translate([-78.35, 57, -3.5]) cylinder(d=9.3, h=10.5, center=true, $fn=60);
      translate([-78.35, -57, -3.5]) cylinder(d=9.3, h=10.5, center=true, $fn=60);
    }
    //alignment cube
//    translate([78.5, 57, 0.74]) %cylinder(d=3, h=30.7, center=true, $fn=60);
//    translate([72.5, 48, 8.74]) %cube(9);
  }
}

include <mps_delta_belt.scad>;
for (a = [0:120:360]) rotate([0, 0, a]) {
  // bottom frame
  translate([-(beam_lengthb/2),-delta_radiusb+63,10]) rotate([0,90,0]) vslot20x20(beam_lengthb, vslot_color_black);
  translate([-(beam_lengthb/2),-delta_radiusb+63,50]) rotate([0,90,0]) vslot20x20(beam_lengthb, vslot_color_black);
  translate([0, delta_radiusb+50, 0]) rotate([0, 0, 180]) import("griffin/frame_motor_2020sw.STL");
  // uprights
  translate([-(beam_lengthb/2),-delta_radiusb+63,50]) 
    rotate([0,0,30]) translate([-8,24,-50]) vslot20x20(beam_heightb, vslot_color_black);
//  // top frame
//  translate([-(beam_lengthb/2),-delta_radiusb+63,beam_heightb-10]) 
//    rotate([0,90,0]) vslot20x20(beam_lengthb, vslot_color_black);
//  translate([0, delta_radiusb+50, beam_heightb]) rotate([0, 0, 180]) translate([0,3,-20]) import("griffin/frame_top_2020sw.STL");
  
//  belts();
//    corner();
//    curve_beam();
}
// glass plate
//translate([0, 0, 60]) rotate([0, 0, 0])
// color([.45, .45, .45]) cylinder(d=508, h=5, $fn=90); //20" table top
//translate([0, 0, 60]) rotate([0, 0, 0])
// color([.45, .45, .45]) cylinder(d=558.8, h=5, $fn=90); //20" table top
//translate([0, 0, 65]) cube([300,300,5], center=true);
//translate([0, 0, 60])  %cylinder(d=508, h=500, $fn=90); //20" table top

//table
//color("grey") translate([0,-275,-30]) cube([500,500,1], center=true);
//translate([0,0,65]) cube([381,381,6], center=true);
//
//translate([0,0,60]) cube([419.1,355.6,6], center=true);
//
//rotate([0,0,120]) translate([0, delta_radiusb+90,150]){
//  cube([18,10,100], center=true);
//  rotate([0,0,-30]) hull(){
//    cube([1,10,70], center=true);
//    translate([-25, 5, 0])  rotate([90,0,0]) cylinder(d=20, h=10, $fn=90);
//  }
//  translate([-40,0,0]) rotate([90,0,240]) 7inch_screen();
//  translate([-40,0,0]) rotate([90,0,240]) 7inch_screen_mount();
//}


translate([0, 0, 60]) color([.45, .45, .45]) cylinder(r=305, h=5, $fn=90); //20" table top


