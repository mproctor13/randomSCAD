$fn=120;
tank_dia=135;
support_height=100;
support_length=200;
include <fhex.scad>

//%cube([300,300,300], center=true);
tank_support();

module tank_support(){
  difference(){
    union(){
      cylinder(d=tank_dia+10, h=support_height);
      hull(){
        cylinder(d=tank_dia+10, h=5);
        translate([support_length-25,0,0]) cylinder(d=50, h=5);
      }
      hull(){
        translate([support_length-2.5,0,0]) cylinder(d=5, h=5);
        translate([tank_dia/2,0,0]) cylinder(d=5, h=support_height);
      }
      for(Z=[-1,1]) rotate([0,0,25*Z]) 
        translate([tank_dia/2+4,0,support_height/2]) rotate([90,180,90]) lock_mount();
    }
    translate([0,0,2.5]) cylinder(d=tank_dia, h=support_height);
    for(Z=[-1,1]) rotate([0,0,25*Z]) translate([0,0,support_height/2]){
      rotate([0,90,0]) cylinder(d=5, h=40, center=true);
      rotate([0,90,0]) translate([0,0,tank_dia/2-1]) fhex(m5_hex_nut,10);
      %rotate([0,90,0]) translate([0,0,tank_dia/2+2]) fhex(m5_hex_nut,m5_nut_height);
    }
  }
}

module lock_mount(thickness=7.5){
  difference(){
  translate([0,5,0]) hull(){
    cube([15,25,1], center=true);
    translate([0,-5,thickness]) cube([15,15,1], center=true);
  }
    cylinder(d=5, h=20, center=true);
  }
}



