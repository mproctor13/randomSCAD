use <cleat_shelf.scad>;
include <fhex.scad>;
$fn = $preview ? 60 : 360;

box_length=380;
box_width=245;
//cleat_bin_mount();
//front_brace(part=2);
//side(side="right");
//%translate([-31.5,0,-10]) cube([50,10,10]);
side(side="left");
//back_brace(part=2);

module cleat_bin_mount(){
  %translate([0,-box_width/2,-40])
    cube([box_length,box_width,100],center=true);
// box
  color("brown") translate([-250,0,0]) 
    rotate([0,90,0]) cleat(length=500);
  translate([0,-box_width-5,0]) front_brace();
  translate([0,18.6/2,0]) back_brace();
//  translate([box_length/2,-box_width,0])
//    cube([10,box_width,10]);
  translate([-box_length/2-1,0,-18.6]) rotate([0,-90,0])  side();
  translate([box_length/2+1,0,-18.6]) rotate([0,-90,0])  side(side="right");
}

module side(side="left"){
  if(side == "left"){
    translate([0,0,5]) side_internal();
  }
  if(side == "right"){
    translate([0,0,-5]) mirror([0,0,1]) side_internal();
  }
}

module side_internal(){
  difference(){
    union(){
    translate([0,18.6,5]) rotate([180,0,0]) 
      cleat(length=10,cleat_width=10);
    translate([-31.4,-10,-5]) cube([60,10,10]);
    translate([-41.4,-10,-5]) cube([10,10+18.6,10]);
    translate([23.6,-box_width/2,0]) 
      cube([10,box_width,10], center=true);
    translate([13.6,-box_width-5,0]) hull(){
      translate([14,0,0]) cube([2,10,10], center=true);
      cylinder(d=10, h=10, center=true);
    }
    hull(){
      translate([-21.4,-10,-5]) cube([50,10,4]);
      translate([13.6,-box_width-5,-3]) union(){
        translate([14,0,0]) cube([2,10,4], center=true);
        cylinder(d=10, h=4, center=true);
      }
    }
    }
    for(Y=[-box_width-5,18.6/2])
    translate([18.6,Y,0]) for(X=[-1,1])
      translate([5*X,0,0]) 
        cylinder(d=3.3,h=20,center=true);
  }
}

module back_brace(part=0){
  if(part == 1){
    difference(){
      back_brace_internal();
      translate([box_length/4+10,0,0]) 
        cube([box_length/2,20,41], center=true);
      translate([0,-5,0]) cube([20,10,21], center=true);
    }
  }
  else if(part == 2){
    intersection(){
      back_brace_internal();
      union(){
        translate([box_length/4+10,0,0]) 
          cube([box_length/2,20,41], center=true);
        translate([0,-5,0]) cube([20,10,31], center=true);
      }
    }
  }
  else{
    back_brace_internal();
  }
}

module back_brace_internal(length=box_length){
  difference(){
    translate([-box_length/2,18.6/2,-18.6]) rotate([0,-90,180]) 
      cleat(length=length,cleat_width=10);
     
    for(X=[-1,1]) translate([(box_length/2-5)*X,0,0])
      cube([m3_nut_height,m3_hex_nut,50],center=true);
    for(X=[-1,1], Z=[-1,1])
      translate([(box_length/2-5)*X,0,5*Z]) 
        rotate([0,90,0]) cylinder(d=3.3,h=20,center=true);
    for(X=[-1,1]) translate([5*X,0,5]) rotate([90,0,0]){
      cylinder(d=3.3,h=20,center=true);
      translate([0,0,-9]) 
        cylinder(d=7,h=10,center=true);
      translate([0,0,7.5]) rotate([0,0,30]) 
        fhex(wid=m3_hex_nut,height=m3_nut_height*2);
    }
  }
}

module front_brace(part=0){
  if(part == 1){
    difference(){
      front_brace_internal();
      translate([box_length/4+5,0,0]) 
        cube([box_length/2,12,21], center=true);
      translate([0,-5,0]) cube([10,10,21], center=true);
    }
  }
  else if(part == 2){
    intersection(){
      front_brace_internal();
      union(){
        translate([box_length/4+5,0,0]) 
          cube([box_length/2,12,21], center=true);
        translate([0,-5,0]) cube([10,10,21], center=true);
      }
    }
  }
  else{
    front_brace_internal();
  }
}

module front_brace_internal(length=box_length){
  difference(){
    hull(){
      translate([-length/2,-5,8]) cube([length,10,2]);
      translate([0,0,-5]) rotate([0,90,0])
        cylinder(d=10, h=length, center=true);
    }
    for(X=[-1,1]) translate([(box_length/2-5)*X,0,0])
      cube([m3_nut_height,m3_hex_nut,50],center=true);
    for(X=[-1,1], Z=[-1,1])
      translate([(box_length/2-5)*X,0,5*Z]) 
        rotate([0,90,0]) cylinder(d=3.3,h=20,center=true);
    for(Z=[-1,1]) translate([0,0,5*Z]) rotate([90,0,0]){
      cylinder(d=3.3,h=20,center=true);
      translate([0,0,-3.7]) 
        cylinder(d1=7,d2=3.3,h=3,center=true);
      translate([0,0,4]) rotate([0,0,30]) 
        fhex(wid=m3_hex_nut,height=m3_nut_height);
    }
  }
}
