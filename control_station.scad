

include <fhex.scad>
use <shoe_tree.scad>
use <RPi4board-modded.scad>
//$fn=60;
//$fn=360;
$fn = $preview ? 60 : 360;
pi_holes=[29,24.5];
pipe_dia=49; // 1.5" abs
pipe_width=225;

//model();
handle();
//open_end();
//io_end();
//end_cap();
//handle();
//monitor_mount();
//ups_tie();
//switch_mount(type=2);

//translate([0,0,50]) monitor_mount();
//pi_mount();
//open_end();
//cased_pi4();

module model(){
  %pipes(height=750);
  translate([0,0,6]) ups();
  
  translate([-pipe_width/2,0,718]) rotate([0,0,180]){
    antenna_mount();
    antenna_mount_lid();
    %translate([50,0,0]) cylinder(d=4,h=360);
  }
  for(Z=[45,195]) translate([0,0,Z]) ups_tie();
//  %translate([0,0,5]) cube([100,100,40]);
//  %translate([0,0,5]) cube([100,100,190]);
  translate([0,0,325]){
    translate([0,-35,100]) monitor();
    translate([0,0,44]) monitor_mount();
    translate([0,0,44+110]) rotate([180,0,180]) monitor_mount();
    
    translate([0,0,230]){
      translate([0,-35,100]) monitor();
      translate([0,0,44]) monitor_mount();
      translate([0,0,44+110]) rotate([180,0,180]) monitor_mount();
    }
  }
  translate([0,0,554]) pi_mount();
  translate([pipe_width/2,0,250]) switch_mount();
  
  for(X=[-1,1]) 
    translate([pipe_width/2*X, 0, 732]) rotate([0,0,90*X]) end_cap();
  translate([0, 0, 752]) rotate([0,90,0]) rotate([0,0,90]) 
    rotate([0,0,90]) handle();

  control_base();
}

module pi_mount(height=75){
  
  for(Z=[-1,1]) translate([0,0,(height/2+2.5)*Z]) 
    pi_arm(type=Z);
  for(X=[-1,1]) translate([pipe_width/2*X, 0, 0]) 
    rotate([0,0,90]) rotate([0,0,90*X]) 
      pi_seperator(height=height);
  translate([60,0,0]){
    translate([6,-14.5,28]) rotate([-90,90,0]) cased_pi4();
    translate([5,0,0]) open_end(height=height+4);
    translate([-pi_holes[0]*2,0,0])
      io_end(height=height+4);
  }
}

module cased_pi4(){
  board_raspberrypi_4_model_b();
  %translate([-3,0,-7]) cube([63,85,16.3]);
    
//  translate([28,32.5,10]) 
//    for(X=[-1,1], Y=[-1,1]) 
//      translate([pi_holes[1]*Y,pi_holes[0]*X,0])
//        cylinder(d=3.3, h=40, center=true);
    
}

module pi_arm(type=-1){
  if(type == -1){
    difference(){
      rotate([0,180,0]) pi_arm_internal();
      translate([35,-10,0]) hull() for(X=[-1,1], Y=[-1,1])
        translate([25*X, 2.5*Y, 0]) 
          cylinder(d=5,h=10,center=true);
      for(X=[2,65]) translate([X,0,0]){
        translate([0,0,3]) 
          cube([10.2,10.2,4],center=true);
        cylinder(d=3.3,h=15,center=true);
      }
    }
  }
  else if(type == 1){
    difference(){
      pi_arm_internal();
      for(X=[2,65]) translate([X,0,0]){
        translate([0,0,-3]) 
          cube([10.2,10.2,4],center=true);
        cylinder(d=3.3,h=15,center=true);
      }
      hull() translate([0,-pipe_dia/2+5.9-1-5,0]) 
        for(X=[-1,1], Y=[-1,1])
          translate([(173-2-15)/2*X,(24-2)/2*Y,0]) 
            cylinder(d=2,h=6, center=true);
    }
  }

}

module pi_arm_internal(thickness=5){
  difference(){
      hull() for(X=[-1,1]) 
        translate([pipe_width/2*X, 0, 0]) 
          cylinder(d=pipe_dia+10, h=thickness, center=true);
    for(X=[-1,1])
      translate([pipe_width/2*X, 0, 0]) 
        cylinder(d=pipe_dia, h=thickness+1, center=true);
    for(X=[-1,1], Y=[-1,1])
      translate([(pipe_width-pipe_dia)/2*X, (pipe_dia/2)*Y, 0]){
        cylinder(d=3.3, h=thickness+1, center=true);
//        translate([0,0,1.5]) 
//          cylinder(d=8, h=thickness-3, center=true);
      }
      translate([0,16,0]) hull() for(X=[-1,1], Y=[-1,1])
        translate([25*X, 5*Y, 0]) 
          cylinder(d=10,h=thickness+1,center=true);
  }
}

module pi_seperator(height=75){
  difference(){
    hull(){
      cylinder(d=pipe_dia+10, h=height, center=true);
      for(Y=[-1,1]) translate([pipe_dia/2+5,((pipe_dia+10)-3)/2*Y,0])
        cylinder(d=3, h=height, center=true);
    }
    cylinder(d=pipe_dia, h=height+1, center=true);
    for(Z=[-1,1], Y=[-1,1])
      translate([pipe_dia/2, (pipe_dia/2)*Y, (height/2-4.2)*Z]){
        cylinder(d=3.3, h=32, center=true);
        hull() for(X=[7,-1]) {
          translate([X,0,0])
            fhex(wid=m3_hex_nut+0.2,height=m3_nut_height+0.2);
          translate([0,0,0]) cylinder(d=5,h=0.3,center=true);
        }
      }
    hull() for(Z=[-1,1], Y=[-1,1])
      translate([0,10*Y,15*Z]) rotate([0,90,0]) 
        cylinder(d=25, h=pipe_dia);
    rotate([90,0,0]) cylinder(d=5, h=pipe_dia+12, center=true);
    rotate([0,-90,0]) cylinder(d=5, h=pipe_dia);
  }
  for(Z=[-1,1], Y=[-1,1])
      translate([pipe_dia/2, (pipe_dia/2)*Y, (height/2-4.2)*Z+(m3_nut_height+0.2)/2+0.15]) cylinder(d=5,h=0.3,center=true);
}

module io_end(height=79){ // 63x20x5
  difference(){
    union(){
      cube([10,10,height], center=true);
      for(Z=[-1,1]) 
        translate([2.5,-5,pi_holes[1]*Z]) rotate([90,0,0])
          cylinder(d=5,h=3,center=true);
    }
    translate([-2.5,-2.5,0])
      cube([5.1,7.1,height-20], center=true);
    for(Z=[-1,1]){
      translate([2.5,0,pi_holes[1]*Z]) rotate([90,0,0])
        cylinder(d=3,h=100,center=true);
      translate([0,7,12*Z]) 
        rotate([0,90,0]) 
          ziptie_channel(width=2,depth=0,radius=5);
      translate([0,0,33*Z])
        cube([m3_hex_nut,15,m3_nut_height],center=true);
      translate([0,0,35*Z])
        cylinder(d=3.3,h=10,center=true);
    }
  }
}
module open_end(height=79){ // 63x24x8
  difference(){
    union(){
      cube([10,10,height], center=true);
      for(Z=[-1,1]) 
        translate([-2.5,-5,pi_holes[1]*Z]) rotate([90,0,0])
          cylinder(d=5,h=3,center=true);
    }
    for(Z=[-1,1]){
      translate([-2.5,0,pi_holes[1]*Z]) rotate([90,0,0])
        cylinder(d=3,h=100,center=true);
      translate([0,7,12*Z]) 
        rotate([0,90,0]) 
          ziptie_channel(width=2,depth=0,radius=5);
      translate([0,0,33*Z])
        cube([m3_hex_nut,15,m3_nut_height],center=true);
      translate([0,0,35*Z])
        cylinder(d=3.3,h=10,center=true);
    }
  }
}

module antenna_mount_lid(){
  difference(){
    for(Y=[-1,1])
    hull(){
      translate([30,15*Y,11]) cylinder(d=10,h=2,center=true);
      translate([50,0,11]) cylinder(d=35,h=2,center=true);
    }
    translate([50,0,11]) cylinder(d=28,h=5,center=true);
    for(Y=[-1,1]) translate([30,15*Y,10.1]) cylinder(d=3.5,h=8,center=true);
//    rotate([90,0,0]) cylinder(d=5,h=pipe_dia+10,center=true);
//    rotate([0,-90,0]) cylinder(d=5,h=pipe_dia);
  }
}

module antenna_mount(height=15){
  difference(){
    hull(){
      cylinder(d=pipe_dia+3,h=height,center=true);
      translate([50,0,(height-8)/2]) cylinder(d=35,h=8,center=true);
    }
    cylinder(d=pipe_dia,h=height+1,center=true);
    translate([50,0,(height-1.5)/2+0.1]) cylinder(d=30,h=1.5,center=true);
    for(Y=[-1,1]) translate([30,15*Y,(height-8)/2+0.1])
      cylinder(d=3,h=8,center=true);
    rotate([90,0,0]) cylinder(d=5,h=pipe_dia+10,center=true);
    rotate([0,-90,0]) cylinder(d=5,h=pipe_dia);
  }
}

module handle(width=pipe_width-pipe_dia-20){
  translate([0,0,-width/2]) handle_end();
  cylinder(d=20, h=width, center=true);
  translate([0,0,width/2]) rotate([0,180,0]) handle_end();
}

module handle_end(){
  difference(){
    hull(){
      for(X=[-1,1]) translate([10*X,0,0]) cylinder(d=20, h=5);
      translate([0,0,10]) cylinder(d=20, h=5);
    }
    for(X=[-1,1]) translate([15*X,0,0]){
        cylinder(d=3.3, h=30, center=true);
        translate([0,0,5]) cylinder(d=10, h=10);
    }
  }
}

module switch_mount(type=0){
  if(type == 0){
    switch_mount_internal();
  }
  else if(type == 1){
    difference(){
      switch_mount_internal();
      translate([44,25,0]) hull() for(X=[-1,1], Z=[-1,1]) 
        translate([22.5*X,0,32.5*Z]) rotate([90,0,0]) 
          cylinder(d=5,h=50,center=true);
    }
  }
  else if(type == 2){
    intersection(){
      switch_mount_internal();
      translate([44,25,0]) hull() for(X=[-1,1], Z=[-1,1]) 
        translate([22.5*X,0,32.5*Z]) rotate([90,0,0]) 
          cylinder(d=5,h=50,center=true);
    }
    translate([45,2,30]) rotate([90,0,0]) cylinder(d=10,h=0.3,center=true);
    translate([45,2,0]) rotate([90,0,0]) cylinder(d=10,h=0.3,center=true);
  }
}

module switch_mount_old(type=0){
  if(type == 0){
    switch_mount_internal();
  }
  else if(type == 1){
    difference(){
      switch_mount_internal();
      translate([-50,0,-50]) cube([200,100,100]);
    }
  }
  else if(type == 2){
    intersection(){
      switch_mount_internal();
      translate([-50,0,-50]) cube([200,100,100]);
    }
  }
}

module switch_mount_internal(){ //switch 17x50x50
  %for(X=[60,32]) translate([X,0,12]) cube([17,50,50], center=true);
  difference(){
    hull(){
      cylinder(d=pipe_dia+10, h=75, center=true);
      for(Y=[-1,1]) translate([70,((pipe_dia+10)/2-5)*Y,0]) 
        cylinder(d=10, h=75, center=true);
    }
    difference(){
      hull(){
        for(Y=[-1,1]) translate([68,((pipe_dia+2)/2-5)*Y,0]) 
          cylinder(d=10, h=71, center=true);
        for(Y=[-1,1]) translate([20,((pipe_dia+2)/2-5)*Y,0]) 
          cylinder(d=10, h=71, center=true);
      }
        translate([45,0,0]) filler(type=0);
        translate([45,0,30]) filler();
    }
    for(Z=[0,30]) translate([45,pipe_dia/2,Z]) rotate([90,0,0]) 
      cylinder(d=8, h=10, center=true);
    cylinder(d=pipe_dia, h=76, center=true);
    for(Z=[-1,1]) translate([0,0,15*Z]){
      rotate([90,0,0]) cylinder(d=5, h=pipe_dia+12, center=true);
//      for(R=[-1,1]) rotate([0,-90,35*R]) cylinder(d=5, h=pipe_dia);
    }
    translate([45,-pipe_dia/2-2,-25]) rotate([90,0,0])
      cylinder(d=10.7,h=10,center=true);
    translate([75,0,-25]) rotate([0,90,0])
      cylinder(d=10.7,h=10,center=true);
    
    for(X=[60,32]) translate([X,-pipe_dia/2,75/2-22]) switch_hole();
  }
}

module filler(type=1,length=pipe_dia+6){
  difference(){
    rotate([90,0,0]) hull(){
      cylinder(d=10, h=length, center=true);
      if( type != 0){
        translate([0,5*type,0]) cube([10,1,length],center=true);
      }
    }
    rotate([90,0,0]) cylinder(d=3, h=20, center=true);
    translate([0,16,0]) rotate([90,0,0]) 
      cylinder(d=8, h=(length+1)/2, center=true);
  }
}

module switch_hole(length=20){
  difference(){
    rotate([90,0,0]) cylinder(d=12,h=length,center=true);
    translate([0,0,-6]) cube([1.95,length+1,2.5],center=true);
  }
}

module end_cap(){
  difference(){
    union(){
      translate([0,0,47]) cylinder(d1=pipe_dia+9, d2=63, h=10);
      hull(){
        cylinder(d=pipe_dia+10, h=57);
      
        for(Z=[10,30]) translate([0,pipe_dia/2,Z]) 
          rotate([0,90,90]) cylinder(d=20, h=10);
      }
    }
    translate([0,pipe_dia/2+4,53.1]) cylinder(d=4.5,h=4);
    for(Z=[-1,1]) translate([0,pipe_dia/2-5,20+(15*Z)]) 
      rotate([0,90,90]) {
        cylinder(d=3.5, h=20);
        translate([0,0,5]) fhex(wid=m3_hex_nut,height=10);
      }
    
    translate([0,0,10]) rotate([0,90,0]) cylinder(d=5, h=100, center=true);
    translate([0,0,10]) rotate([90,0,0]) cylinder(d=5, h=60);
      
    translate([0,0,45]) cylinder(d=57, h=50);
    translate([0,0,-1]) cylinder(d=25, h=100);
    translate([0,0,0]) cylinder(d=45, h=40);
    translate([0,0,-1]) cylinder(d=pipe_dia, h=21);
  }
}

module monitor_mount(thickness=20,top=false){
  offset=5;
  difference(){
    union(){
      hull() for(X=[-1,1]) 
          translate([pipe_width/2*X, 0, thickness/2]) 
            cylinder(d=pipe_dia+10, h=thickness, center=true);
      
      for(X=[-1,1]) translate([75/2*X, -7.6, 12.5+offset]){
          rotate([-90,0,0]) cylinder(d=11,h=7.6);
      }
    }
    if( !top ){
      translate([0,11,1]) hull() for(X=[-1,1], Y=[-1,1])
        translate([25*X, 10*Y, 9]) cylinder(d=10,h=thickness+1,center=true);
      translate([0,23.5,thickness/2]) ziptie_channel();
      translate([0,-2,thickness/2]) ziptie_channel();
    }
//    %translate([0,-pipe_dia/2+5.9,10]) cube([173, 22, 25], center=true);
    hull() translate([0,-pipe_dia/2+5.9-1,thickness/2+offset]) 
      for(X=[-1,1], Y=[-1,1])
        translate([(173-2)/2*X,(24-2)/2*Y,0])
          cylinder(d=2,h=thickness, center=true);
    hull() translate([0,-pipe_dia/2+5.9-1-5,thickness/2]) 
      for(X=[-1,1], Y=[-1,1])
        translate([(173-2-15)/2*X,(24-2)/2*Y,-1]) 
          cylinder(d=2,h=thickness, center=true);
        
    for(X=[-1,1], R=[0,90]) 
      translate([pipe_width/2*X, 0, thickness/2])
        rotate([-90,0,-R*X]) cylinder(d=5,h=pipe_dia);
    for(X=[-1,1]) translate([75/2*X, 0, 12.5+offset]){
      rotate([90,0,0]) cylinder(d=3.3,h=pipe_dia+thickness,center=true);
      hull(){
        rotate([-90,0,0]) cylinder(d=10,h=pipe_dia);
        translate([-5,0,thickness/2]) cube([10,pipe_dia,1]);
      }
    }
    for(X=[-1,1]) 
      translate([pipe_width/2*X, 0, thickness/2]) 
        cylinder(d=pipe_dia, h=thickness+5, center=true);
  }
    
}

module ziptie_channel(width=2,depth=0,radius=5){
  difference(){
    hull()
      for(X=[-1,1], Y=[-1,1]){ 
      translate([(width)*X,depth*Y,0]) cylinder(r=radius,h=5, center=true);
    }
    hull() 
    for(X=[-1,1], Y=[-1,1]){ 
      translate([(width)*X,depth*Y,0]) cylinder(r=radius-2,h=5+1, center=true);
    }
  }
}

module monitor_mount_old(){
  difference(){
    hull() for(X=[-1,1]) 
          translate([pipe_width/2*X, 0, 10]) 
            cylinder(d=pipe_dia+10, h=20, center=true);
//    %translate([0,-pipe_dia/2+5.9,10]) cube([173, 22, 25], center=true);
    hull() translate([0,-pipe_dia/2+5.9-1,10]) 
      for(X=[-1,1], Y=[-1,1])
        translate([(173-2)/2*X,(24-2)/2*Y,0]) cylinder(d=2,h=25, center=true);
        
    for(X=[-1,1], R=[0,90]) 
      translate([pipe_width/2*X, 0, 10])
        rotate([-90,0,-R*X]) cylinder(d=5,h=pipe_dia);
    for(X=[-1,1]) translate([75/2*X, 0, 10]){
      rotate([90,0,0]) cylinder(d=3.3,h=pipe_dia+20,center=true);
      rotate([-90,0,0]) cylinder(d=10,h=pipe_dia);
    }
    for(X=[-1,1]) 
      translate([pipe_width/2*X, 0, 10]) 
        cylinder(d=pipe_dia, h=25, center=true);
  }
    
}

module control_base(part=0){
  if( part == 0 ){
    control_base_internal();
  }
  else if( part == 1){
    difference(){
       control_base_internal();
       translate([0,-200,-20]) cube([200,300,100]);
    }
  }
  else if( part == 2){
    intersection(){
       control_base_internal();
       translate([0,-200,-20]) cube([200,300,100]);
    }
  }
}

module control_base_internal(mount_hole=5){
  angle=180;
  length=65;
  for(R=[-1,1]) translate([pipe_width/2*R, 0, -5]) 
    support();
    
  difference(){
    union(){
      translate([0,(pipe_dia+9-7.5)/2,5])
        cube([pipe_width,7.5,20], center=true);
      hull() for(X=[-1,1], Y=[-1,0]){
          translate([pipe_width/2*X, 35*Y, -1.5])
            cylinder(d=pipe_dia+10, h=8, center=true);
          translate([pipe_width/3*X, -80, -1.5]) 
            cylinder(d=30, h=8, center=true);
      }
    }      
    for(X=[-1,1]) 
      translate([pipe_width/2*X, 0, 10]) 
        cylinder(d=pipe_dia, h=30, center=true);
     for(Y=[20,-15,-50,-85], X=[-1,1]) 
        translate([0,Y,-1.5]) rotate([0,90,0]) {
          cylinder(d=3.5, h=40, center=true);
          translate([0,0,15*X]) hull(){
            cylinder(d=7, h=20, center=true);
            translate([10,0,0]) cube([1, 8, 20], center=true);
          }
          translate([0,0,4]) fhex(wid=m3_hex_nut,height=m3_nut_height);
        }
  }
}

//module filler(width=100){
//  translate([width,0,0]) union(){
//    circle(d=15);
//    translate([-width/2,0,0]) square([width,15], center=true);
//  }
//}

module monitor(){
  cube([375, 8.5, 225], center=true);
  difference(){
    translate([0,15,0]) cube([172, 22, 100], center=true);
    for(X=[-1,1], Z=[-1,1]) translate([75/2*X,5,75/2*Z])
      rotate([-90,0,0]) cylinder(d=5,h=25);
  }
}

module ups_tie(height=15){
  difference(){
    union(){
      translate([0,(pipe_dia+9-7.5)/2,0])
        cube([pipe_width,7.5,height], center=true);
      for(X=[-1,1]) hull(){
        translate([pipe_width/2*X, 0,0]) 
          cylinder(d=pipe_dia+9, h=height, center=true);
        translate([150/2*X, pipe_dia/2,0]) cube([1,1,height], center=true);
      }
      
    }
    for(X=[-1,1]) translate([pipe_width/2*X, 0,0]){ 
        cylinder(d=pipe_dia, h=height+1, center=true);
        rotate([0,90*X,0]) cylinder(d=5, h=pipe_dia);
        rotate([0,90*X,90*X]) cylinder(d=5, h=pipe_dia);
    }
    translate([32.5,pipe_dia,0]){
      rotate([90,0,0]) cylinder(d=3.5, h=pipe_dia);
      translate([0,-7.5/2-pipe_dia/2+m3_nut_height-0.4,0]) rotate([90,30,0]) 
        fhex(wid=m3_hex_nut,height=m3_nut_height);
    }
  }
}

module ups(){
  %translate([0,-30,150]) cube([145,100,300], center=true);
}

module pipes(height=500){
  for(X=[-1,1]) translate([pipe_width/2*X, 0,height/2]) 
    cylinder(d=pipe_dia, h=height, center=true);
}