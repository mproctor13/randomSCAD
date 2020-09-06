include <BOLTS.scad>
include <MCAD/stepper.scad>
include <vslot.scad>

//module vslot20x40(length, finish) { vslot(length, 2, finish); }
//
//module vslot20x60(length, finish) { vslot(length, 3, finish); }
//
//module vslot20x80(length, finish)

frame_depth=600;
frame_width=600;
frame_height=1000;

gantry_depth=540;
gantry_width=530;
gantry_length=600;

bed_level=730;

module frame(){
  for(X=[-10-frame_width/2,10+frame_width/2], Y=[-10-frame_depth/2,10+frame_depth/2]){
    translate([X,Y,0]) vslot20x20(frame_height, vslot_color_black);
    translate([-frame_width/2,Y,40]) rotate([0,90,0]) vslot20x80(frame_width, vslot_color_black);
    translate([X,frame_depth/2,40]) rotate([90,90,0]) vslot20x80(frame_depth, vslot_color_black);
      
    translate([-frame_width/2,Y,frame_height-20]) rotate([0,90,0]) vslot20x40(frame_width, vslot_color_black);
    translate([X,frame_depth/2,frame_height-20]) rotate([90,90,0]) vslot20x40(frame_depth, vslot_color_black);
  }
}
gantry();
module gantry(){
    translate([0,0,frame_height-68]) rotate([90,0,0]) color([0.78,0.78,0.78]) cylinder(d=8, h=gantry_length, center=true, $fn=30);
  translate([0,0,frame_height-50]) rotate([90,0,90]) color([0.78,0.78,0.78]) cylinder(d=8, h=gantry_length, center=true, $fn=30);
  half_width=gantry_width/2;
  half_depth=gantry_depth/2;
  translate([10,half_depth-16,frame_height-50]) rotate([90,0,90]) color([0.78,0.78,0.78]) cylinder(d=8, h=gantry_length, center=true, $fn=30);
  translate([10,-half_depth,frame_height-50]) rotate([90,0,90]) color([0.78,0.78,0.78]) cylinder(d=8, h=gantry_length, center=true, $fn=30);
  half_depth=gantry_depth/2;
    
  translate([-half_width-24,half_depth-16,frame_height-50]) rotate([0,90,270]) pillow_block();
  translate([half_width+24,half_depth-16,frame_height-50]) rotate([0,90,270]) pillow_block();
  translate([half_width+19,half_depth-16,frame_height-50]) rotate([0,90,180]) 16tooth_pully();
  translate([half_width+19,-half_depth,frame_height-50]) rotate([0,90,180]) 16tooth_pully();
  translate([half_width+7, -6, frame_height-50]) rotate([90,0,90]) belt(width=530);
  translate([-half_width-7, -6, frame_height-50]) rotate([90,0,90]) belt(width=530);
    
  translate([-half_width-24,-half_depth,frame_height-50]) rotate([0,270,270]) pillow_block();
  translate([half_width+24,-half_depth,frame_height-50]) rotate([0,270,270]) pillow_block();
    
  for(X=[-1,1], Y=[-1,1]){
    translate([half_width*X,0,frame_height-68]) rotate([90,0,0]) color([0.78,0.78,0.78]) cylinder(d=8, h=gantry_length, center=true, $fn=30);
      
    translate([half_width*X,half_depth+7,frame_height-68]) rotate([0,-90*X,0]) pillow_block();
    translate([half_width*X,half_depth+2,frame_height-68]) rotate([90,0,0]) 16tooth_pully();
      
    translate([half_width*X,-half_depth-25,frame_height-68]) rotate([0,-90*X,0]) pillow_block();
    translate([half_width*X,-half_depth-18,frame_height-68]) rotate([-90,0,0]) 16tooth_pully();
  }
  translate([-half_width-18,-half_depth,frame_height-50]) rotate([-90,0,270]) 16tooth_pully();
  translate([-half_width-18,half_depth-16,frame_height-50]) rotate([-90,0,270]) 16tooth_pully();
  translate([0, -half_depth-7, frame_height-68]) rotate([90,0,0]) belt(width=530);
  translate([0, half_depth-9.5, frame_height-68]) rotate([90,0,0]) belt(width=530);
  
  
  
  
  translate([-half_width,half_depth+14,frame_height-68]) rotate([-90,0,0]) color([0,1,0]) 16tooth_pully(); //XMotor
  
  translate([half_width+29,half_depth-16,frame_height-50]) rotate([0,90,0]) color([0,1,0]) 16tooth_pully(); //YMotor
  
  stub=100;
//  translate([half_width+24,half_depth+7,frame_height-120]) rotate([0,0,0]) color([1,0,0]) vslot20x20(stub, vslot_color_black);
//  translate([half_width+24,-(half_depth+24),frame_height-120]) rotate([0,0,0]) color([1,0,0]) vslot20x20(stub, vslot_color_black);
//  translate([-(half_width+24),half_depth+7,frame_height-120]) rotate([0,0,0]) color([1,0,0]) vslot20x20(stub, vslot_color_black);
//  translate([-(half_width+24),-(half_depth+24),frame_height-120]) rotate([0,0,0]) color([1,0,0]) vslot20x20(stub, vslot_color_black);
  
  
    translate([half_width+24,half_depth+17,frame_height-120]) rotate([0,0,90]) color([1,0,0]) vslot20x40(stub, vslot_color_black);
  translate([half_width+24,-(half_depth+34),frame_height-120]) rotate([0,0,90]) color([1,0,0]) vslot20x40(stub, vslot_color_black);
  translate([-(half_width+24),half_depth+17,frame_height-120]) rotate([0,0,90]) color([1,0,0]) vslot20x40(stub, vslot_color_black);
  translate([-(half_width+24),-(half_depth+34),frame_height-120]) rotate([0,0,90]) color([1,0,0]) vslot20x40(stub, vslot_color_black);
}

module bushing(id=8, od=10, length=10, sides=30){
  color([.8,.8,.8]) difference(){
    cylinder(d=od, h=length, center=true, $fn=sides);
    translate([0,0,-.1]) cylinder(d=id, h=length+0.3, center=true, $fn=sides);
  }
}

module slider(part=0){
  difference(){
    cube([12,25,12], center=true);
    translate([0,6,0]) rotate([0,90,0]) cylinder(d=9, h=15, center=true, $fn=30);
    translate([0,6,0]) rotate([0,90,0]) cylinder(d=10, h=10.1, center=true, $fn=30);
    translate([0,-10,0]) rotate([90,0,0]) cylinder(d=6.1, h=15, center=true, $fn=30);
  }
//  translate([0,6,0]) rotate([0,90,0]) bushing();
}

module LMK10UU(){
  color([.72,.72,.72])
  difference(){
    union(){
      translate([0,0,17.2]) rotate([0,0,0]) cylinder(d=19, h=23, center=true, $fn=60);
      intersection(){
        translate([0,0,2.85]) cube([30,30,5.7], center=true);
        translate([0,0,2.85]) rotate([0,0,45]) cube([40,40,5.7], center=true);
      }
    }
    translate([0,0,14.5]) cylinder(d=10, h=30, center=true, $fn=30);
    for(X=[-1,1], Y=[-1,1]){
      translate([10*X,10*Y,2.9]) cylinder(d=4.5, h=6, center=true, $fn=30);
    }
  }
}

module ballnut() {
  difference(){
    union(){
      difference(){
        translate([0, 0, 0]) color([0,1,0]) cylinder(r=24, h=11, center=false, $fn=60);
        translate([-40, -25, -2]) color([0,1,1]) cube([20,50,15]);
        translate([20, -25, -2]) color([0,1,1]) cube([20,50,15]);
      //holes
        translate([0, 20, -5]) color([0,0,0]) cylinder(r=2.8, h=43, center=false, $fn=60);
        translate([0, -20, -5]) color([0,0,0]) cylinder(r=2.8, h=43, center=false, $fn=60);
        
        translate([13.5, 13.5, -5]) color([0,0,0]) cylinder(r=2.8, h=43, center=false, $fn=60);
        translate([13.5, -13.5, -5]) color([0,0,0]) cylinder(r=2.8, h=43, center=false, $fn=60);
        translate([-13.5, -13.5, -5]) color([0,0,0]) cylinder(r=2.8, h=43, center=false, $fn=60);
        translate([-13.5, 13.5, -5]) color([0,0,0]) cylinder(r=2.8, h=43, center=false, $fn=60);
      }
      translate([0, 0, 0]) color([0,1,0]) cylinder(r=14, h=43, center=false, $fn=60);
    }
    translate([0, 0, -10]) color([0,0,0]) cylinder(r=7.5, h=60, center=false, $fn=60);
  }
}

module rod_mount(){
  color([.72,.72,.72])
  difference(){
    union(){
      hull(){
        for(X=[-16,16]){
          translate([X,0,5]) cylinder(d=10, h=10, center=true, $fn=30);
        }
        translate([0,0,5]) cube([5,18,10], center=true);
      }
      translate([0,-8,5]) cube([20,14.5,10], center=true);
    }
    translate([0,0,14.5]) cylinder(d=10, h=30, center=true, $fn=30);
    for(X=[-16,16]){
      translate([X,0,4.9]) cylinder(d=5.3, h=11, center=true, $fn=30);
      translate([X,0,7.9]) cylinder(d=7.3, h=4.6, center=true, $fn=30);
    }
    translate([0,-10,5.4]) cube([1.25,15,11], center=true);
    translate([0,-11,5]) rotate([0,90,0]) cylinder(d=3.4, h=30, center=true, $fn=30);
  }
}

module pillow_block(){
  translate([0,0,-14]) union(){
  difference(){
    translate([0,1,14]) rotate([90,0,0]) cylinder(d=12.7, h=11, center=true, $fn=30);
    translate([0,0.91,14]) rotate([90,0,0]) cylinder(d=8, h=11.2, center=true, $fn=30);
  }
  difference(){
    union(){
      hull(){
        translate([0,0,14]) rotate([90,0,0]) cylinder(d=28, h=9.5, center=true, $fn=30);
        for(X=[-1,1]){
          translate([12*X,0,2.45]) cube([2.5,12.8,4.9], center=true);
        }
      }
      translate([0,0,2.45]) cube([55,12.8,4.9], center=true);
    }
    for(X=[-1,1]){
      translate([21.25*X,0,2.45]) cylinder(d=4.5, h=5, center=true, $fn=30);
    }
    for(X=[-1,1], Y=[-1,1]){
      translate([27*X,7*Y,2.45]) rotate([0,0,45*X*Y]) cube([2.5,12.8,5], center=true);
    }
      translate([0,0,14]) rotate([90,0,0]) cylinder(d=8, h=9.7, center=true, $fn=30);
    for(Y=[-1,1]){
      hull(){
        translate([0,7*Y,14]) rotate([90,0,0]) cylinder(d=24, h=5, center=true, $fn=30);
        translate([0,7*Y,0]) cube([24,5,5], center=true);
      }
    }
  }
  }
}
module 16tooth_pully(){
  translate([0,0,8]) 
  difference(){
    difference(){
      cylinder(d=16, h=16, center=true, $fn=30);
      translate([0,0,-0.1]) cylinder(d=8, h=16.3, center=true, $fn=30);
    }
    translate([0,0,3.25]) difference(){
      cylinder(d=18, h=7, center=true, $fn=30);
      translate([0,0,-0.1]) cylinder(d=12.4, h=7.3, center=true, $fn=30);
    }
  }
}

module belt(width=600){
  color([0,0,0])
  difference(){
    hull(){
      translate([-width/2,0,0]) cylinder(d=14.4, h=6, center=true, $fn=30);
      translate([width/2,0,0]) cylinder(d=14.4, h=6, center=true, $fn=30);
    }
    hull(){
      translate([-width/2,0,0]) cylinder(d=12.4, h=6.2, center=true, $fn=30);
      translate([width/2,0,0]) cylinder(d=12.4, h=6.2, center=true, $fn=30);
    }
  }
}

module vertical_mount(){
  color([.72,.72,.72])
  difference(){
    union(){
      translate([0,0,16.5]) cube([18,13,33], center=true);
      translate([0,0,3]) cube([42,13,6], center=true);
    }
    translate([0,0,30]) cube([2,15,15], center=true);
    translate([0,0,20]) rotate([90,0,0]) cylinder(d=10, h=20, center=true, $fn=30);
    translate([0,0,28]) rotate([90,0,90]) cylinder(d=3, h=20, center=true, $fn=30);
    translate([8,0,28]) rotate([90,0,90]) cylinder(d=5, h=5, center=true, $fn=30);
    for(X=[-16,16]){
      translate([X,0,3]) rotate([0,0,0]) cylinder(d=6, h=8, center=true, $fn=30);
    }
  }
}

module vertical_guides(){
  color([.72,.72,.72])
  union(){
    for(X=[-((frame_width/2)-22),((frame_width/2)-22)], Y=[-1,1]){
      // Front Rod
      translate([X,-((frame_depth/2)-65),457.2+62]) cylinder(d=10, h=914.4, center=true, $fn=30);
      translate([X,-((frame_depth/2)-65),bed_level]) LMK10UU();
      // Back Rod
      translate([((frame_width/2)-85),((frame_depth/2)-20),457.2+62]) cylinder(d=10, h=914.4, center=true, $fn=30);
      translate([-((frame_width/2)-85),((frame_depth/2)-20),457.2+62]) cylinder(d=10, h=914.4, center=true, $fn=30);
      translate([((frame_width/2)-85),((frame_depth/2)-20),bed_level]) LMK10UU();
      translate([-((frame_width/2)-85),((frame_depth/2)-20),bed_level]) LMK10UU();
        
        
      // Bottom Mount
      translate([(frame_width/2)*Y,-((frame_depth/2)-65),70]) rotate([-90,0,90*Y]) vertical_mount();
      translate([((frame_width/2)-85),(frame_depth/2),70]) rotate([90,0,0]) vertical_mount();
      translate([-((frame_width/2)-85),(frame_depth/2),70]) rotate([90,0,0]) vertical_mount();
      //Top Mount
      translate([(frame_width/2)*Y,-((frame_depth/2)-65),frame_height-30]) rotate([-90,0,90*Y]) vertical_mount();
      translate([((frame_width/2)-85),(frame_depth/2),frame_height-30]) rotate([90,0,0]) vertical_mount();
      translate([-((frame_width/2)-85),(frame_depth/2),frame_height-30]) rotate([90,0,0]) vertical_mount();
      
    }
  }
  
}

module vertical_guide_mount(){
  translate([-((frame_width/2)-20),-((frame_depth/2)-20),0]) rotate([0,0,135]) rod_mount();
  translate([-((frame_width/2)-20),((frame_depth/2)-20),0]) rotate([0,0,45]) rod_mount();
    
  translate([((frame_width/2)-20),((frame_depth/2)-20),0]) rotate([0,0,-45]) rod_mount();
  translate([((frame_width/2)-20),-((frame_depth/2)-20),0]) rotate([0,0,-135]) rod_mount();
}

module subframe(x_inset=26,y1_inset=70,y2_inset=90){
  for(Y=[-1,1]){
      // Right
    translate([((frame_width/2)-x_inset),(frame_depth/2)-((y2_inset+10)),frame_height-20]) rotate([0,90,0]) vslot20x40(x_inset, vslot_color_black);
    translate([((frame_width/2)-x_inset),-(frame_depth/2)+((y1_inset+10)),frame_height-20]) rotate([0,90,0]) vslot20x40(x_inset, vslot_color_black);
    // Left
    translate([-(frame_width/2),(frame_depth/2)-((y2_inset+10)),frame_height-20]) rotate([0,90,0]) vslot20x40(x_inset, vslot_color_black);
    translate([-(frame_width/2),-(frame_depth/2)+(y1_inset+10),frame_height-20]) rotate([0,90,0]) vslot20x40(x_inset, vslot_color_black);
    //Back
    translate([(frame_width*Y/2)-((x_inset+10)*Y),(frame_depth/2),frame_height-20]) rotate([90,90,0]) vslot20x40(y2_inset, vslot_color_black);
    // Front
    translate([(frame_width*Y/2)-((x_inset+10)*Y),-(frame_depth/2)+y1_inset,frame_height-20]) rotate([90,90,0]) vslot20x40(y1_inset, vslot_color_black);
      
//    translate([(frame_width*Y/2)-((inset+10)*Y),(frame_depth*Y/2)-((inset+10)*Y),frame_height-80]) rotate([0,0,0]) color([1,0,0]) vslot20x20(stub, vslot_color_black);
//
//    translate([-(frame_width*Y/2)+((inset+10)*Y),(frame_depth*Y/2)-((inset+10)*Y),frame_height-80]) rotate([0,0,0]) color([1,0,0]) vslot20x20(stub, vslot_color_black);
  }
}

module subframe2(x_inset=26,y1_inset=0,y2_inset=0){
  for(Y=[-1,1]){
      // Right
    translate([((frame_width/2)-x_inset),(frame_depth/2)-((y2_inset+20)),frame_height-10]) rotate([90,0,90]) vslot20x40(x_inset, vslot_color_black);
    translate([((frame_width/2)-x_inset),-(frame_depth/2)+((y1_inset+20)),frame_height-10]) rotate([90,0,90]) vslot20x40(x_inset, vslot_color_black);
    // Left
    translate([-(frame_width/2),(frame_depth/2)-((y2_inset+20)),frame_height-10]) rotate([90,0,90]) vslot20x40(x_inset, vslot_color_black);
    translate([-(frame_width/2),-(frame_depth/2)+(y1_inset+20),frame_height-10]) rotate([90,0,90]) vslot20x40(x_inset, vslot_color_black);
  }
}

module ballscrew_assembly(){
   translate([0,(frame_depth/2)-25,bed_level]) rotate([0,0,90]) ballnut();
    
}

module bed(){
   translate([0,0,bed_level-3]) cube([640,665,6], center=true);
    
}

frame();
//vertical_guides();
//bed();
//ballscrew_assembly();
//subframe2();
//translate([0, 8, 80]) gantry();
//
//translate([0, 0, frame_height-150]) %cube([508,508,300], center=true);
//translate([0, 0, frame_height]) %cube([500,500,100], center=true);
//translate([0, 0, frame_height]) %cube([gantry_width,gantry_width,100], center=true);
//translate([0, 0, frame_height]) %cube([frame_width,frame_depth,100], center=true);
//
////rod_mount();
//translate([0, 0, 60]) vertical_guides();
//translate([0, 0, 60]) vertical_guide_mount();
//translate([0, 0, 975]) rotate([0,180,0]) vertical_guide_mount();
//bushing();

//translate([0,(frame_depth/2)-30, 50]) rotate([180,0,0]) motor(Nema23, NemaMedium, dualAxis=false);
//slider();
//translate([-275,-275,(914.4/2)+80]) color([0.78,0.78,0.78]) cylinder(d=10, h=914.4, center=true, $fn=30);


translate([-70,-450,0]) linear_extrude(10) text("FRONT", 30);
 
