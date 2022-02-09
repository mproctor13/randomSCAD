
include <fhex.scad>

//%translate([165,-150,0])
//import("../printer/pi/pi4_bottom.stl");
//
//base_thickness=1;
//screw_hole=4;
//difference(){
//  hull(){
//    translate([47.5,0,0]) cylinder(d=15, h=base_thickness);
//    for(Y=[-1,1]) translate([-47.5,37.5*Y,0]) cylinder(d=15, h=base_thickness);
//  }
//  translate([47.5,0,-1]) cylinder(d=screw_hole, h=base_thickness+2);
//  for(Y=[-1,1]) translate([-47.5,37.5*Y,-1]) 
//    cylinder(d=screw_hole, h=base_thickness+2);
//}

$fn=120;
//%import("../printer/MPMU_D6_Y-Axis_Endstop_Spacer.stl");
//y_offset();
y_offset(false);

module y_offset(top=true,dia=23){
  if(top){
    difference(){
      y_offset_internal(dia=dia);
      translate([15,0,5]) cube([30,30,20],center=true);
    }
  }
  else{
    intersection(){
      y_offset_internal(dia=dia);
      translate([15,0,5]) cube([30,30,20],center=true);
    }
  }
}

module y_offset_internal(dia=23){
  difference(){
    cylinder(d=dia,h=10);
    translate([0,0,-1]) cylinder(d=7,h=12);
    
    for(Y=[-1,1]) translate([0,Y*7.5,5]) rotate([0,90,0]){
      translate([0,0,7]) fhex(m3_hex_nut,10);
      cylinder(d=3.5,h=30,center=true);
      translate([0,0,-14]) cylinder(d=9,h=10);
    }
  }
}