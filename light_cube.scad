board_x=66.2;
board_y=67.2;

c_offset=74.1/2;
x_offest=24.75;
y_offset=24.75;
peg_length=8;
include <fhex.scad>

//rotate([0,180,0]) cover_test();
glue_test();
//rotate([0,180,0]) translate([0,0,-3]) matrix();
//rotate([0,180,0]) backer();
//translate([35+2,0,-35-3]) rotate([0,90,0]) cover_test();
//translate([0,0,-3]) matrix();
//model();
//inner_mount();
//imr18500();
//translate([-31,0,0]) 
//  frame_lid();

module model(){
//  for(R=[0,180]) rotate([0,0,R]) 
    %translate([-c_offset,0,0])
      rotate([0,-90,0]) cover_test();
//  for(R=[0,90,180,270]) rotate([R,0,0])
//    translate([0,c_offset,0])
//      rotate([-90,0,0]) cover_test();
  inner_mount();
//  rotate([0,90,0]) battery_pack();
  
}

module glue_test(cube_size=75, radius=8, thickness=1.5, height=20,bthickness=0){
  difference(){
    union(){
      cube([cube_size+thickness*2,cube_size+thickness*2,height], center=true);
      for(X=[-1,1], Y=[-1,1]) 
        translate([(cube_size/2)*X, (cube_size/2)*Y, 0]) 
          cylinder(d=radius,h=height,center=true,$fn=60);
    }
    for(X=[-1,1], Y=[-1,1]) 
      translate([(cube_size/2)*X, (cube_size/2)*Y, bthickness]) 
        cylinder(d=radius-thickness*1.5,h=height+1,center=true,$fn=60);
    translate([0,0,bthickness]) 
      cube([cube_size+0.5,cube_size+0.5,height], center=true);
    translate([0,0,-1])
      cube([cube_size-19,cube_size-19,height], center=true);
  }
}

module frame_lid(thickness=2,lid_offset=6){
  difference(){
    union(){
      for(Y=[-1,1], Z=[-y_offset-1,0,y_offset])
      translate([-lid_offset/2,x_offest*Y,Z]) 
        rotate([0,90,0]) 
          cylinder(d=6, h=lid_offset, $fn=60);
      hull() for(Z=[-1,1], Y=[-1,1]){
      translate([thickness/2,32*Y,15*Z])
        rotate([0,90,0])
          cylinder(d=6,h=thickness,$fn=60);
      translate([thickness/2,15*Y,32*Z])
        rotate([0,90,0])
          cylinder(d=6,h=thickness,$fn=60);
        }
    }

    for(Y=[-1,1], Z=[-y_offset-1,0,y_offset])
      translate([0,x_offest*Y,Z]) 
        rotate([0,90,0]) 
          cylinder(d=2.75, h=16, center=true, $fn=60);
    for(Z=[-1,1], Y=[-1,1]){
      translate([0.5,32*Y,15*Z])
        rotate([0,90,0])
          cylinder(d=3.4,h=thickness+1,$fn=60);
      translate([0.5,15*Y,32*Z])
        rotate([0,90,0])
          cylinder(d=3.4,h=thickness+1,$fn=60);
    }
    translate([0.5,0,0]) rotate([0,90,0])
      cylinder(d=35,h=thickness+1,$fn=60);
  }
    
}

module inner_mount(){
  difference(){
    hull(){
  for(Z=[-1,1])
    translate([0,0,c_offset*Z]) mirror([0,0,1-Z]){
      backer();
    }
  for(X=[1])
    translate([c_offset*X,0,0]) mirror([1-X,0,0]){
      rotate([0,90,0]) backer();
    }
  for(Y=[-1,1])
    translate([0,c_offset*Y,0]) mirror([0,1-Y,0]){
      rotate([-90,0,0]) backer();
    }
  }
  rotate([0,90,0])
    for(X=[-1,1], Y=[-y_offset-1,0,y_offset])
      translate([x_offest*X,Y,-8.1]) 
        cylinder(d=2.75, h=100, center=true, $fn=60);
  rotate([90,0,0])
    for(X=[-1,1], Y=[-y_offset-1,0,y_offset])
      translate([x_offest*X,Y,-8.1]) 
        cylinder(d=2.75, h=100, center=true, $fn=60);
  
    for(X=[-1,1], Y=[-y_offset-1,0,y_offset])
      translate([x_offest*X,Y,-8.1]) 
        cylinder(d=2.75, h=100, center=true, $fn=60);
    translate([-3,0,0]) cube([60,58,58], center=true);
    
    for(Z=[-1,1], Y=[-1,1]){
      translate([-25,15*Y,0]) 
        cube([m3_nut_height,m3_hex_nut,150], center=true);
      translate([-25,0,15*Z]) 
        cube([m3_nut_height,150,m3_hex_nut], center=true);
      translate([-22,32*Y,15*Z])
        rotate([0,90,0])
          cylinder(d=3.4,h=16,center=true,$fn=60);
      translate([-22,15*Y,32*Z])
        rotate([0,90,0])
          cylinder(d=3.4,h=16,center=true,$fn=60);
    }
    for(Y=[90,0], X=[0,90]) rotate([X,Y,0])
      cylinder(d=35, h=150, center=true,$fn=60);
    for(RX=[0,90,180,270]) rotate([RX,0,0])
      hull() for(X=[-1,1]) translate([10*X,0,35])
        rotate([90,0,0]) 
          cylinder(d=6,h=150,$fn=60,center=true);
  }
}

module battery_pack(boffset=18){
  for(X=[-1,1], Y=[-1,1]){
    translate([boffset*X, boffset*Y, 0]) imr18500();
  }
}

module backer(){
//  difference(){
//    hull(){
      for(X=[-1,1], Y=[-y_offset-1,0,y_offset])
        translate([x_offest*X,Y,-8]) 
          cylinder(d=6, h=6, $fn=60);
//    }
//    for(X=[-1,1], Y=[-y_offset-1,0,y_offset])
//        translate([x_offest*X,Y,-8.1]) 
//          cylinder(d=2.75, h=8, $fn=60);
//  }
}

module cover_test(){
  cube([70,70,1], center=true);
  translate([0,0,-1.5])
  difference(){
    hull(){
//      %cube([70,70,4], center=true);
      
      translate([0,0,-2]) cube([67,67,0.1], center=true);
      translate([0,0,2]) cube([75,75,0.1], center=true);
    }
    translate([0,0,-0.5]) cube([board_x,board_y,4], center=true);
//    for(X=[-3.5,-2.5,-1.5,-0.5,0.5,1.5,2.5,3.5], 
//        Y=[-3.5,-2.5,-1.5,-0.5,0.5,1.5,2.5,3.5])
//      translate([X*8,Y*8,1.2]) cube([5.6, 5.6, 1.65], center=true);
  }
  difference(){
    union(){
      for(X=[-3,-2,-1,0,1,2,3])
        translate([8.25*X,0,-1.25]) 
          cube([2,70,1.5], center=true);
      for(X=[-1,1], Y=[-y_offset-1,0,y_offset])
        translate([x_offest*X,Y,-peg_length]) 
          cylinder(d=2.7, h=peg_length, $fn=60);
      %for(X=[-1,1], Y=[-y_offset,0,y_offset])
        translate([x_offest*X,Y,-peg_length]) 
          cylinder(d=2.7, h=peg_length, $fn=60);
    }
//    for(X=[-1,1], Y=[-1,0,1])
//      translate([x_offest*X,y_offset*Y,-peg_length-0.01]) 
//        cylinder(d=1.7, h=peg_length, $fn=60);
  }
}

module matrix(){
  color("grey") cube([board_x,board_y,1.6], center=true);
  for(X=[-3.5,-2.5,-1.5,-0.5,0.5,1.5,2.5,3.5], 
      Y=[-3.5,-2.5,-1.5,-0.5,0.5,1.5,2.5,3.5])
  translate([X*8,Y*8,1.5]) ws2812b();
}

module ws2812b(){
    color("white") cube([5,5,1.6], center=true);
    for(X=[-1,1], Y=[-1,1])
      translate([(0.45+1.7)*X,1.7*Y,-0.4]) 
        color("silver") cube([0.9,0.9,0.8], center=true);
}

module imr18500(l=50){
  cylinder(d=18.3, h=l, center=true);
}

