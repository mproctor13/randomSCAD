
include <vslot.scad>

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

module fhex(wid,height){
  hull(){
    cube([wid/1.7,wid,height],center=true);
    rotate([0,0,120]) cube([wid/1.7,wid,height], center=true);
    rotate([0,0,240]) cube([wid/1.7,wid,height], center=true);
  }
}

module endstop(){
  difference(){
    union(){
      translate([0,0,8]) color("red") cube([1.5,39,16], center=true);
      translate([.75,-12.75,0]) color("black") cube([5.5,12.75,6]);
        
      translate([.75,9.2,1.5]) color("white") cube([5.5,6.88,12.5]);
    }
    translate([0,-16,3.15]) rotate([0, 90, 0]) cylinder(d=3.15, h=2, center=true,  $fn=60);
    translate([0,3,3.15]) rotate([0, 90, 0]) cylinder(d=3.15, h=2, center=true,  $fn=60);
    
    translate([0,17.5, 13.7]) rotate([0, 90, 0]) cylinder(d=3.3, h=2, center=true,  $fn=60);
    translate([0,17.5, 2.3]) rotate([0, 90, 0]) cylinder(d=3.3, h=2, center=true,  $fn=60);
  }
}

module endstop_mount(){
  difference(){
    union(){
//      translate([2.5,0,12.5]) cube([5,25,25], center=true);
//      translate([0,0,9.65]) cube([4,20,22], center=true);
      translate([0,0,4.15]) cube([4,11,10], center=true);
      hull(){
        translate([0,7.5,18.65]) rotate([0, 90, 0]) cylinder(d=5, h=4, center=true,  $fn=60);
        translate([0,-7.5,18.65]) rotate([0, 90, 0]) cylinder(d=5, h=4, center=true,  $fn=60);
        
        translate([0,7.5,11.65]) rotate([0, 90, 0]) cylinder(d=5, h=4, center=true,  $fn=60);
        translate([0,-7.5,11.65]) rotate([0, 90, 0]) cylinder(d=5, h=4, center=true,  $fn=60);
        
        translate([0,0,5]) rotate([0, 90, 0]) cylinder(d=10, h=4, center=true,  $fn=60);
      }
      hull(){
         translate([3.5,9.5,3.15]) rotate([0, 90, 0]) cylinder(d=8, h=4, center=true,  $fn=60);
         translate([3.5,-9.5,3.15]) rotate([0, 90, 0]) cylinder(d=8, h=4, center=true,  $fn=60);
      }
      translate([-2,0,10.15]) slot_fill(length=22);
    }
    // mount holes
    translate([2.5,-9.5,3.15]) rotate([0, 90, 0]) cylinder(d=3.15, h=10, center=true,  $fn=60);
    translate([2.5,9.5,3.15]) rotate([0, 90, 0]) cylinder(d=3.15, h=10, center=true,  $fn=60);
    //nut holes
    translate([2.2,9.5,3.15]) rotate([0, 90, 0]) fhex(5.7,3);
    translate([2.2,-9.5,3.15]) rotate([0, 90, 0]) fhex(5.7,3);
    //nut cutouts
    translate([-1.45,9.5,3.15]) rotate([0, 90, 0]) cylinder(d=8, h=6, center=true,  $fn=60);
    translate([-1.45,-9.5,3.15]) rotate([0, 90, 0]) cylinder(d=8, h=6, center=true,  $fn=60);
    
    // mount hole
    translate([0,0,17.5]) rotate([0, 90, 0]) cylinder(d=3.2, h=10, center=true,  $fn=60);
  }
}

//translate([7,6.5,0]) endstop();
endstop_mount();
//translate([-10,0,0]) rotate([0,0,0]) vslot20x20(200, vslot_color_black);