
include <fhex.scad>
include <spool_mount.scad>
include <hx711.scad>
include <MCAD/regular_shapes.scad>
//translate([-9,-148,-2.5])
//import("2pcs-stand-side-repwinder-v213.stl");
//cube([5,102,5],center=true);
////%cube([10,136,10],center=true);
//
//%translate([0,60,0]) cube([5,17.5,10],center=true);

$fn=$preview ? 30 : 120;
length=75;

//stand_mount_assembly();
upright(upside_down=true);
//foot(holes=true);

module stand_mount_assembly(){
//  %cube([102,5,5],center=true);
  for(X=[-1,1]) translate([59.5*X,0,0]) foot();
//  rotate([90,0,180]) upright(octo_mount=true);
//  %translate([-35,0,120]) rotate([90,0,180]) hx711();
//  translate([0,0,120]) rotate([-90,270,0]) spool_mount_assembly();
}

module upright(height=120,octo=true,octo_mount=true,upside_down=false){
  back_thickness=4;
  difference(){
    union(){
      translate([0,height,0]) rotate_extrude(angle=180)
        translate([59.5,0,0]) if( octo ){
          rotate([0,0,25]) octagon(8);
        }
        else{
          circle(d=15);
        }
        
      difference(){
        union(){
          translate([0,height,-7.5+back_thickness/2]) 
            cylinder(d=120,h=back_thickness,center=true);
          translate([0,height/2+25,-7.5+back_thickness/2]) 
            cube([height,50,back_thickness],center=true);
        }
        if( octo ){
          translate([0,height*2-40,-8]) rotate([0,0,22.5]) 
            linear_extrude(height=back_thickness+2) octagon(60);
          translate([0,height-80,-8]) rotate([0,0,22.5]) 
            linear_extrude(height=back_thickness+2) octagon(60);
        }
        else{
          translate([0,height*2-35,-8]) rotate([0,0,0]) 
            cylinder(d=120,h=back_thickness+2);
          translate([0,height-85,-8]) rotate([0,0,0]) 
            cylinder(d=120,h=back_thickness+2);
        }
      }
      for(X=[-1,1]) translate([59.5*X,0,0]){
        if( octo ){
          translate([0,15,0]) rotate([-90,22.5,0]) 
            linear_extrude(height=105) octagon(8);
        }
        else{
          translate([0,15,0]) rotate([-90,0,0]) cylinder(d=15,h=105);
        }
        translate([0,12,0]) rotate([-90,0,0]) cylinder(d=8,h=10,$fn=6);
      }
      translate([0,height,0]) rotate([0,0,22.5]){
        if( octo ){
          translate([0,0,-6]) linear_extrude(height=12,scale=.75) 
            octagon(45/2);
        }
        else{
          cylinder(d1=45, d2=35, h=12, center=true);
        }
      }
      if( upside_down ){
        translate([-35,height,0]) hx711_mount();
      }
      else{
        translate([35,height,0]) hx711_mount();
      }
    }
    translate([0,height,0]){
        if( octo_mount ){
          translate([0,0,2.1]) rotate([0,0,22.5]) 
            linear_extrude(height=4) octagon(32.5/2);
        }
        else{
          translate([0,0,4.1]) cylinder(d=32.5, h=4, center=true);
        }
      for(R=[45,135,225,315]) rotate([0,0,R]) translate([12,0,0])
        cylinder(d=3.3,h=20,center=true);
      
      for(R=[45,135,225,315]) rotate([0,0,R]) translate([12,0,-7.6]) 
        cylinder(d=8,h=6);
    }
    if(upside_down){
      translate([-35,height,0]) hx711_mount("cutout");
    }
    else{
      translate([35,height,0]) hx711_mount("cutout");
    }
    
    for(X=[-1,1]) translate([59.5*X,11.9,0]){
      rotate([-90,0,0]) cylinder(d=3.3,h=15);
      translate([0,6,0])
        cube([sq_nutX+0.25,sq_nutY+0.25,20], center=true);
    }
    if( octo ){
      translate([0,height,-7.75]) cube([200,height*2,1],center=true);
    }
  }
  translate([0,height,-1.45]){
    for(R=[45,135,225,315]) 
      rotate([0,0,R]) translate([12,0,0])
        cylinder(d=5,h=0.3,center=true);
    if( upside_down ){
      translate([-35,0,0]) hx711_mount("plug");
    }
    else{
      translate([35,0,0]) hx711_mount("plug");
    }
  }
}

module foot(length=length+50, holes=false){
  translate([0,length/2-7.5,0])
  difference(){
    hull(){
      translate([0,-length/2+7.5,0]) cylinder(d=15,h=15);
      for(X=[-1,1], Y=[-1,1]) 
        translate([6*X,(length/2-2.5)*Y,0])
          cylinder(d=5,h=2.5,$fn=60);
    }
    translate([0,-length/2+7.5,-0.1]) cylinder(d=10,h=10);
    translate([0,-length/2+7.5,10.2]) cylinder(d=3,h=10);
    translate([0,-length/2+7.5,12]) cylinder(d=8,h=5,$fn=6);
    if( holes ) for(Y=[-1,1]) translate([0,length/4*Y,5]){
      cylinder(d=10,h=10);
      cylinder(d=5,h=30,center=true);
    }
  }
}