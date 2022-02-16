
include <threads.scad>
include <mps_bearing.scad>
include <load_cell.scad>
sq_nutX=5.5+0.7;
sq_nutY=2.4;

$fn=$preview ? 30 : 120;
//spool_mount_assembly();
//strain_mount();
//spool_mount();
nut();

module spool_mount_assembly(){
  translate([0,0,10]){
    spool_mount();
    spool_internal();
    strain_mount();
  }
  strain_gauge();
}

module strain_mount(thread_dia=40){
  difference(){
    rotate([0,0,22.5]) union(){
      translate([0,0,-10]) cylinder(d=32, h=20,$fn=8);
      translate([0,0,10]) cylinder(d1=32,d2=thread_dia-17,h=7,$fn=8);
    }
    translate([0,0,15]) cylinder(d=32,h=10);
    cube([load_cell[0]+sensor_offset,load_cell[1]+sensor_offset,load_cell[2]+6], center=true);
    translate([0,-load_cell[0]/2+sensor_offset,-11]) cylinder(d=11,h=40);
    translate([0,-load_cell[0]/2+sensor_offset,-4])
      rotate([90,30,0]) cylinder(d=8,h=20,$fn=6);
    translate([0,-load_cell[0]/2+sensor_offset,12]) 
      cube([load_cell[0]+sensor_offset,4,20], center=true);
    translate([0,0,25]) for(Z=[-1,1])
      translate([0,0,-load_cell_holes[1]+load_cell_holes[0]*Z])
        rotate([0,90,0]){
          cylinder(d=5, h=100, center=true);
          translate([0,0,10]) cylinder(d=8, h=10);
        }
    for(R=[45,135,225,315]) rotate([0,0,R]) translate([12,0,-12]){
      cylinder(d=3.3,h=12);
      translate([sq_nutX/2,0,5])
        cube([sq_nutX*2,sq_nutX,sq_nutY], center=true);
    }
  }
  for(R=[45,135,225,315]) rotate([0,0,R]) translate([12,0,-5.875])
        cylinder(d=4,h=0.3);
}

module nut(thread_dia=40,tangle=50){
  difference(){
    union(){
      cylinder(d=70, h=5);
      translate([0,0,5]) cylinder(d1=70, d2=thread_dia+2, h=20);
    }
    metric_thread(diameter=thread_dia+1, pitch=4, angle=tangle, length=50, square=false);
  }
}

module spool_internal(thread_dia=40,length=75,tangle=50){
  difference(){
    union(){
      translate([0,0,20]) cylinder(d=thread_dia-15,h=length+7);
      translate([0,0,10]) cylinder(d1=46,d2=thread_dia-15,h=10);
      translate([0,0,0]) cylinder(d=46,h=10);
    }
    translate([0,0,length+15]) 
      cutout_race(diameter=13,pushout=200,bextra=0.5);
    translate([0,0,10]) rotate([0,180,0]) 
      cutout_race(diameter=23,bextra=0.5);
    translate([0,0,19]) cube([16,16,45], center=true);
    
    translate([0,0,-1]) cylinder(d=35, h=11);
    translate([0,0,9.99]) cylinder(d1=35,d2=thread_dia-15,h=7);
    translate([0,13,-1]) cylinder(d=7.5, h=length+10);
    translate([0,13,length+9]) cylinder(d1=7.5, d2=3, h=5);
    
    translate([0,0,length+12.2]) cylinder(d=2, h=10);
    translate([0,0,length+22.1]) cylinder(d=15, h=5, $fn=6);
    
//load_cell_holes
    translate([0,0,25]){
      cube([load_cell[0]+sensor_offset,load_cell[1]+sensor_offset,load_cell[2]+6], center=true);
      for(Z=[-1,1])
        translate([0,0,load_cell_holes[1]+load_cell_holes[0]*Z])
          rotate([0,90,0]){
            cylinder(d=5, h=100, center=true);
            translate([0,0,10]) cylinder(d=8, h=10);
          }
    }
  }
  if( !$preview ){
    translate([0,0,16.99]) cylinder(d=thread_dia-15, h=0.3);
    translate([0,0,45/2+19.15]) cube([16,16,0.3],center=true);
  }
}

module spool_mount(thread_dia=40,length=75,tangle=50){
  internal_cutout=thread_dia-10;
  difference(){
    union(){
      translate([0,0,25]) intersection(){
        union(){
          translate([0,0,length-5])
            cylinder(d1=thread_dia, d2=thread_dia-5, h=10);
          cylinder(d=thread_dia+5, h=length-5);
        }
        metric_thread(diameter=thread_dia, pitch=4, length=length, angle=tangle);
      }
      cylinder(d=70, h=5);
      translate([0,0,5]) cylinder(d1=70, d2=thread_dia+2, h=20);
    }
    translate([0,0,-1]) cylinder(d=thread_dia-14,h=length+27);
    translate([0,0,10]) cylinder(d=internal_cutout,h=4+length);
    translate([0,0,14+length]) 
      cylinder(d1=internal_cutout,d2=internal_cutout-10,h=4);
    translate([0,0,length+15]) cutout_race(diameter=13);
    translate([0,0,10]) rotate([0,180,0]) 
      cutout_race(diameter=23,pushout=50);
    
    translate([0,0,9.99]) cylinder(d=47,h=2);
    translate([0,0,11.99]) cylinder(d1=47,d2=internal_cutout,h=10);
    translate([0,0,-1]) cylinder(d=46.5,h=11);
    
    translate([0,0,25]) for(Z=[-1,0,1])
      translate([0,0,load_cell_holes[1]+load_cell_holes[0]*Z])
        rotate([0,90,0]){
          cylinder(d=5, h=50);
          translate([0,0,10]) cylinder(d=10, h=12, $fn=6);
        }
    translate([0,13,-1]) cylinder(d=7.5, h=length+10);
    translate([0,13,length+9]) cylinder(d1=7.5, d2=3, h=5);
  }
}