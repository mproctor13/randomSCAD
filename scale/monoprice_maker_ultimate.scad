
include <fhex.scad>
include <hx711.scad>
include <load_cell.scad>
include <spool_mount.scad>

mmu_assembly();

module mmu_assembly(){
  base_plate();
  translate([0,0,-4]) mmu_scale_mount();
  spool_mount_assembly();
  translate([0,-35,5]) rotate([0,0,180]) hx711();
}

module base_plate(side="right"){
  translate([0,-20,0]) difference(){
//    %cube([60,80,4], center=true);
    union(){
      hull() for(X=[-1,1], Y=[-1,1]) translate([27.5*X,37.5*Y,0]) 
        cylinder(d=5,h=4, center=true);
      for(X=[-1,1]) translate([14.5/2*X,-27,0]){
        cylinder(d=5,h=5);
        cylinder(d=10,h=4);
      }
      translate([0,-12,0]) cylinder(d=5,h=5);
    }
    translate([0,20,0]){
      rotate([0,0,22.5]) cylinder(d=32.5, h=4,$fn=8);
      for(R=[45,135,225,315]) rotate([0,0,R]) translate([12,0,-5.875])
        cylinder(d=3.3,h=10);
      cube([load_cell[0]+sensor_offset,load_cell[1]+sensor_offset,10], center=true);
    }
    translate([-20,0,2.8]) rotate([90,0,90]) 
      ziptie_channel(width=2,depth=0,radius=5);
    translate([0,-35,2.8]) rotate([90,0,0]) 
      ziptie_channel(width=2,depth=0,radius=5);
    translate([0,-27,0]){
      for(X=[-1,1]) translate([14.5/2*X,0,0]){
        cylinder(d=3.3,h=10);
        translate([0,0,-0.35]) fhex(m3_hex_nut+0.2,m3_nut_height*1.5);
      }
    }
    for(X=[-1,1]) translate([15*X,-14,0]){
      cylinder(d=3.3,h=10);
      translate([0,0,-0.35]) fhex(m3_hex_nut+0.2,m3_nut_height*1.5);
    }
  }
  for(X=[-1,1]) translate([14.5/2*X,-47,1.3375])
        cylinder(d=5,h=0.3);
  for(X=[-1,1]) translate([15*X,-34,1.3375])
        cylinder(d=5,h=0.3);
}

module mmu_scale_mount(length=8){
  difference(){
    union(){
      intersection(){
        translate([0,0,-3.3]) fhex(36, 6.6);
        rotate([0,0,30]) translate([0,0,-3]) fhex(40, 10);
      }
      cylinder(d=30,h=2.5);
//  %translate([0,0,5]) cube([load_cell[0],load_cell[1],length], center=true);
      hull() for(X=[-1,1], Y=[-1,1]) 
        translate([(load_cell[0]/2-2)*X,(load_cell[1]/2-2)*Y,0])
          cylinder(d=4,h=length);
    }
    for(R=[45,135,225,315]) rotate([0,0,R]) translate([12,0,0]){
      cylinder(d=3.3,h=20,center=true);
      translate([0,0,-3]) rotate([0,180,0]) cylinder(d=8, h=10);
    }
  }
  for(R=[45,135,225,315]) rotate([0,0,R]) translate([12,0,-2.9]){
    cylinder(d=8,h=0.3,center=true);
  }
}

