include <fhex.scad>;
cleat_thickness=18.6;
cleat_width=45-cleat_thickness;
shelf_width=16*25.4;
shelf_depth=254;
shelf_height=6*25.4;
shelf_front_height=75;
mount_offset=60;
thickness=5;

cleat_shelf();

//shelf_back();
//shelf_front();
//screw_cutout();
//shelf_bottom();
//shelf_backing();
//cleat_mount();

module cleat_mount(){
  difference(){
//    cube([11.4,11,11],center=true);
//    linear_extrude(10)
    
  }
//rotate([0,90,0]) 
translate([-47.75,-26,0])
import("/home/mproctor/cad/printer/panel/RepBox2PrintedPartsSet_v2.1.4/RepBox2PrintedPartsSet_v2.1.4/13PCS- RB2- MegaBracket_v1.45.stl");
}

module cleat_shelf(){
//difference(){
  for(X=[-1,1]) translate([(shelf_width/2-thickness/2)*X, 0, -thickness]) 
        rotate([0,90,0]) shelf_side();
  for(X=[-1,-0.5,0,0.5,1])
    translate([(shelf_width/2-thickness*2-0.8)*X,shelf_depth/2+thickness*2,111.5])
      rotate([-45,0,0]) cleat_mount();
//}
  translate([0,shelf_depth/2,shelf_height/2-thickness]) 
    rotate([-90,0,0]) shelf_back();
  translate([0,0,thickness/2]) shelf_bottom();
  translate([0,-shelf_depth/2,shelf_front_height/2-5]) 
    rotate([-90,0,0]) shelf_front();
  translate([0,shelf_depth/2,shelf_height/2-thickness]) 
    rotate([-90,0,0]) shelf_back();
  translate([0,shelf_depth/2+12.5,66.5+mount_offset])
    shelf_backing();
//  for(Z=[0,6.25*25.4])
//    translate([-609.6/2,shelf_depth/2+cleat_thickness/2-thickness/2,117-Z])
//      rotate([0,90,0]) cleat(length=609.6);
}

module shelf_bottom(){
  difference(){
    union(){
      cube([shelf_width-thickness, shelf_depth-thickness, thickness], center=true);
      for(X=[-1,-0.5,0,0.5,1])
        translate([(shelf_width/2-40)*X,0,0])
          cube([20, shelf_depth+thickness, thickness], center=true);
      for(Y=[-1,-0.5,0,0.5,1])
        translate([0,(shelf_depth/2-40)*Y,0])
          cube([shelf_width, 20, thickness], center=true);
    }
    for(X=[-1,1], Y=[-1,1]) translate([(shelf_width/2-thickness)*X,40*Y,0])
      mirror([1-X,0,0]) screw_cutout();
    
    for(X=[-1,1], Y=[-1,1]) translate([55*Y,(shelf_depth/2-thickness/2)*X,0])
      mirror([0,1-X,0]) rotate([0,0,90]) screw_cutout();
  }
}

module shelf_front(){
  difference(){
    union(){
      cube([shelf_width-thickness*2, shelf_front_height, thickness], center=true);
      for(Y=[-1,1]) translate([0,(shelf_front_height/2-20)*Y,0])
        cube([shelf_width, 20, thickness], center=true);
    }
    for(X=[-1,1]) translate([(shelf_width/2-thickness)*X,0,0])
      mirror([1-X,0,0]) screw_cutout();
    for(X=[-1,-0.5,0,0.5,1])
      translate([(shelf_width/2-40)*X,shelf_front_height/2-thickness/2-thickness,0])
        cube([20, thickness, thickness+2], center=true);
    for(X=[-1,1]) translate([55*X,shelf_front_height/2-thickness/2-thickness,0])
      cylinder(d=3.3, h=50, center=true, $fn=60);
  }
}

module shelf_back(){
  difference(){
    union(){
      cube([shelf_width-thickness*2, shelf_height, thickness], center=true);
      for(Y=[-1,0,1]) translate([0,(shelf_height/2-20)*Y,0])
        cube([shelf_width, 20, thickness], center=true);
    }
    for(X=[-1,-0.5,0,0.5,1], Y=[thickness, 69+mount_offset])
      translate([(shelf_width/2-40)*X,shelf_height/2-thickness/2-Y,0])
        cube([20, thickness, thickness+2], center=true);
    for(X=[-1,1], Y=[-1,1]) translate([(shelf_width/2-thickness)*X,30*Y,0])
      mirror([1-X,0,0]) screw_cutout();
    for(X=[-1,1]) translate([55*X,shelf_height/2-thickness/2-thickness,0])
      cylinder(d=3.3, h=40, center=true, $fn=60);
    for(X=[-1,-0.5,0,0.5,1]) translate([(shelf_width/2-thickness*2-0.8)*X,11.4-mount_offset,0])
      cylinder(d=3.3, h=60, center=true, $fn=60);
  }
}

module shelf_backing(){
  difference(){
    union(){
      cube([shelf_width-thickness*2,cleat_thickness,thickness],center=true);
      for(X=[-1,-0.5,0,0.5,1])
        translate([(shelf_width/2-40)*X,-cleat_thickness/2-thickness/2,0])
        cube([20, thickness, thickness], center=true);
      cube([shelf_width, cleat_thickness/2, thickness], center=true);
    }
    for(X=[-1,-0.5,0,0.5,1])
      translate([(shelf_width/2-thickness*2-0.8)*X,5.5,0])
        cylinder(d=3.3, h=60, center=true, $fn=60);
  }
}

module shelf_side(diameter=5){
//  translate([-shelf_height/2-thickness,10,0])
//    %cube([shelf_height+thickness*2, shelf_depth+20+thickness*2, thickness], center=true);
  difference(){
    hull(){
      translate([-diameter/2,-(shelf_depth/2+thickness-diameter/2),0])
        cylinder(d=diameter, h=thickness, center=true, $fn=60);
      translate([-diameter/2,shelf_depth/2+thickness+17-diameter/2,0])
        cylinder(d=diameter, h=thickness, center=true, $fn=60);
      translate([-(shelf_height-diameter/2),shelf_depth/2+thickness+17-diameter/2,0])
        cylinder(d=diameter, h=thickness, center=true, $fn=60);
      translate([-(shelf_height-diameter/2),shelf_depth/2,0])
        cylinder(d=diameter, h=thickness, center=true, $fn=60);
      translate([-(shelf_front_height+thickness-diameter/2),-(shelf_depth/2+thickness-diameter/2),0])
        cylinder(d=diameter, h=thickness, center=true, $fn=60);
    }
    for(X=[-1,0,1]) translate([-shelf_height/2+(shelf_height/2-20)*X,shelf_depth/2,0])
      cube([20,thickness,thickness+1], center=true);
    
    for(X=[-1,1]) translate([-shelf_front_height/2+(shelf_front_height/2-20)*X,-shelf_depth/2,0])
      cube([20,thickness,thickness+1], center=true);
    translate([-shelf_front_height/2,-shelf_depth/2,0]) 
      cylinder(d=3.3,h=40,center=true,$fn=60);
    for(X=[-1,1]) translate([-shelf_height/2+30*X,shelf_depth/2,0]) 
      cylinder(d=3.3,h=40,center=true,$fn=60);
    
    for(Y=[-1,-0.5,0,0.5,1])
      translate([-thickness*1.5,(shelf_depth/2-40)*Y,0])
        cube([thickness, 20, thickness+2], center=true);
    
    for(Y=[-1,1]) translate([-thickness*1.5,40*Y,0])
      cylinder(d=3.3, h=40, center=true, $fn=60);
    translate([-thickness/2-69-mount_offset,(shelf_depth/2+12.5),0])
      cube([thickness, cleat_thickness/2, thickness+1], center=true);
    translate([-45-cleat_thickness-mount_offset,shelf_depth/2+cleat_thickness/2-thickness*1.25,-thickness/2-1]) cleat(length=thickness+2,cleat_width=45+cleat_thickness, cleat_thickness=19);
    translate([-cleat_thickness-26-mount_offset,shelf_depth/2+cleat_thickness,0])
      cube([10,10,thickness+2], center=true);
    translate([-cleat_thickness-40.5-mount_offset,shelf_depth/2+12.5,0])
      cylinder(d=3.3, h=40, center=true, $fn=60);
  }
}

module screw_cutout(length=12,offset=thickness, thickness=thickness){
  translate([-(length+m3_nut_height)/2,0,0]){
    cube([length+m3_nut_height, 3.3, thickness+1], center=true);
  translate([(length+m3_nut_height)/2-m3_nut_height/2-offset,0,0])
    cube([m3_nut_height, m3_hex_nut, thickness+1], center=true);
  }
}

module cleat(length=10,cleat_thickness=cleat_thickness,cleat_width=cleat_width){
  linear_extrude(length) cleat_fill(cleat_width=cleat_width, cleat_thickness=cleat_thickness);
}

module cleat_fill(cleat_width=cleat_width,cleat_thickness=cleat_thickness){
  polygon(points=[[0,0],[cleat_thickness+cleat_width,0],
            [cleat_thickness+cleat_width,cleat_thickness],
            [cleat_thickness,cleat_thickness]]);
}