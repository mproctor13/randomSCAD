use <raspberrypi.scad>
include <fhex.scad>
pi_offset=26;
pipe_offset=22.5;
pipe_dia=35;
//translate([-70+pi_offset,-5,25]) rotate([180,0,-90]) pi3();
//translate([-92.3+pi_offset,-20,20]) rotate([0,0,90]) hub75_patch();
//lid();
//translate([0,54,9]) rotate([0,0,-90]) picam_board();
//panel();
intersection(){
//  case();
//  translate([-60,-45,15]) cube([90,25,30], center=true); // pi hole test
//  translate([90,42,4.9]) cube([25,25,10], center=true); // screen mount test
//  translate([0,60,0]) cube([30,25,25], center=true); // camera mount test
//  translate([45,-55,17]) cube([30,25,18], center=true); // plug mount test
}
//case();
//translate([0,7.5,30]) mount2();
translate([0,7.5,30]) mount2(type="top");
//translate([0,7.5,30]) mount2(type="bottom");
//mount1();
//translate([0,51,14]) rotate([90,-90,0]) picam_board();

//%cube([205,115,30], center=true);

//translate([0,0,55]) rotate([90,0,0]) cylinder(d=36,h=200, $fn=60, center=true);
//translate([30,0,15]) thumb_screw_long();

module thumb_screw(length=30){
  difference(){
    union(){
      cylinder(d=18,h=length+10,$fn=60);
      translate([0,0,length-10]) 
        cylinder(d1=20,d2=25,h=20,$fn=6);  
    }
    cylinder(d=8,h=length+12,$fn=60);
    translate([0,0,length+6.1]) fhex(11,8);
  }
}

module thumb_screw_long(length=30){
  difference(){
    union(){
      cylinder(d=18,h=length+10,$fn=60);
      hull() for(X=[-1,1]) translate([15*X,0,length]) cylinder(d=18,h=10,$fn=60);  
    }
    cylinder(d=8,h=length+12,$fn=60);
    translate([0,0,length+6.1]) fhex(11,8);
  }
}

module hub75_patch(x_offset=4*2.44+0.5, y_offset=5, hole=1.0){
  color("purple") 
    difference(){
      hull(){
        cube([2.54*20,2.54*2,1.27]);
        translate([x_offset,y_offset,0]) cube([2.54*8,2.54*2,1.27]);
      }
    for(x=[0:20-1],y=[0:2-1])
      translate([x*2.54+(1.27+.6)/2,y*2.54+(1.27+.6)/2,-3.5])
        cylinder(d=hole, h=10, $fn=30);
    translate([x_offset,y_offset,0])
    for(x=[0:8-1],y=[0:2-1])
      translate([x*2.54+(1.27+.6)/2,y*2.54+(1.27+.6)/2,-3.5])
        cylinder(d=hole, h=10, $fn=30);
  }
}

module mount1(type="both"){
  mount(type) mount_base();
}

module mount2(type="both",mount_offset=2){
  if(type=="top"){
    difference(){
      mount_base2(mount_offset);
//      %translate([0,0,mount_offset/2]) mount_cutline2();
      translate([0,0,-mount_offset/2]) mount_cutline2();
    }
  }
  else if(type=="bottom"){
    intersection(){
      mount_base2(mount_offset);
      translate([0,0,-mount_offset/2]) mount_cutline2();
    }
  }
  else{
    difference(){
      mount_base2(mount_offset);
      translate([0,0,mount_offset/2]) mount_cutline2();
    }
    intersection(){
      mount_base2(mount_offset);
      translate([0,0,-mount_offset/2]) mount_cutline2();
    }
  }
}

module mount(type="both"){
  if(type=="top"){
    difference(){
      children();
      translate([0,0,1]) mount_cutline();
    }
  }
  else if(type=="bottom"){
    intersection(){
      children();
      mount_cutline();
    }
  }
  else{
    difference(){
      children();
      translate([0,0,1]) mount_cutline();
    }
    intersection(){
      children();
      translate([0,0,-1]) mount_cutline();
    }
  }
}

module mount_cutline2(){
  translate([0,0,(pipe_dia+10)/4]) 
    cube([100,100,(pipe_dia+10)/2], center=true);
}

module mount_cutline(){
  hull(){
    translate([0,0,(pipe_dia+10)/2]) difference(){
      rotate([90,0,0]) 
        cylinder(d=pipe_dia,h=55,$fn=60, center=true);
      translate([0,0,pipe_dia/2]) cube([pipe_dia+1,56,pipe_dia], center=true);
    }
    translate([0,0,5]) cube([40,100,10], center=true);
  }
  translate([0,0,0]) cube([100,100,20], center=true);
}

module mount_base(pipe_dia=36){
//  for(X=[-1,1]) translate([30*X,0,0]) cylinder(d=6.35,h=100,$fn=60);
  difference(){
    union(){
      hull(){
        for(X=[-1,1], Y=[-1,1]) translate([30*X,10*Y,0])
          cylinder(d=25,h=15,$fn=60);
        translate([0,0,pipe_offset]) rotate([90,0,0]) 
          cylinder(d=pipe_dia+10,h=50,$fn=60, center=true);
      }
      hull() for(X=[-1,1], Y=[-1,1])
        translate([37.5*X,37.5*Y,0]) cylinder(d=10,h=4,$fn=60);
    }
    for(X=[-1,1]) translate([30*X,0,0]){
      translate([0,0,-20]) cylinder(d=7,h=100,$fn=60);
      translate([0,0,15]) cylinder(d=20,h=100,$fn=60);
      translate([0,0,2]) fhex(11,6);
    }
    translate([0,0,(pipe_dia+10)/2]) rotate([90,0,0]) 
      cylinder(d=pipe_dia+0.5,h=55,$fn=60, center=true);
    for(X=[-1,1], Y=[-1,1])
      translate([37.5*X,37.5*Y,-1]) cylinder(d=4.3,h=10,$fn=60);
  }
}

module mount_base2(type="small",vertial_offset=12, split_offset=2){
  bolt_offset=24;
  shoulder_height=40;
  difference(){
    union(){
      translate([0,0,(pipe_dia+10)/2]) rotate([90,0,0]) 
        cylinder(d=pipe_dia+10,h=35,$fn=60, center=true);
      hull(){
        for(X=[-1,1], Y=[-1,1]) translate([30*X,15*Y,0])
          cylinder(d=5,h=shoulder_height,$fn=60);
      }
      if(type=="large") hull() for(X=[-1,1], Y=[-1,1]){
        translate([37.5*X,17.5*Y,0]) cylinder(d=10,h=4,$fn=60);
      }
    }
    for(X=[-1,1]) translate([bolt_offset*X,0,0]){
      translate([0,0,11.5+vertial_offset/2]) cylinder(d=7,h=100,$fn=60);
//      %translate([0,0,45]) cylinder(d=40,h=10,$fn=60);
      translate([0,0,2+vertial_offset/2]) fhex(11,6+vertial_offset);
//      translate([0,0,2]) fhex(11,6);
    }
    translate([0,0,pipe_offset]) rotate([90,0,0]) 
      cylinder(d=pipe_dia+0.5,h=55,$fn=60, center=true);
    
    mount_offset=-3.5;
    for(X=[-1,1], Y=[-1,1]){
      translate([25*X,10*Y,mount_offset]){ // 50 x 20
        cylinder(d=4.4,h=24, $fn=60);
        translate([0,0,-mount_offset+4-split_offset/2])
          cylinder(d=8,h=(pipe_dia+10)/2-4,$fn=60);
      }
      translate([37.5*X,17.5*Y,mount_offset]){ // 75 x 35
        cylinder(d=4.4,h=120,$fn=60);
      }
    }
  }
}

module mount_base3(pipe_dia=36){
  difference(){
    union(){
      hull(){
        for(X=[-1,1], Y=[-1,1]) translate([40*X,15*Y,0])
          cylinder(d=5,h=15,$fn=60);
        translate([0,0,pipe_offset]) rotate([90,0,0]) 
          cylinder(d=pipe_dia+10,h=30,$fn=60, center=true);
      }
      hull() for(X=[-1,1], Y=[-1,1]){
        translate([17.5*X,37.5*Y,0]) cylinder(d=10,h=4,$fn=60);
        translate([40*X,15*Y,0]) cylinder(d=5,h=4,$fn=60);
//        translate([37.5*X,12.5*Y,0]) cylinder(d=10,h=4,$fn=60);
      }
    }
    for(X=[-1,1]) translate([30*X,0,0]){
      translate([0,0,5.3]) cylinder(d=7,h=100,$fn=60);
      translate([0,0,15]) cylinder(d=20,h=100,$fn=60);
      translate([0,0,2]) fhex(11,6);
    }
    translate([0,0,pipe_offset]) rotate([90,0,0]) 
      cylinder(d=pipe_dia+0.5,h=55,$fn=60, center=true);
    
    mount_offset=-3.5;
    for(X=[-1,1], Y=[-1,1]){
//        translate([50*X,50*Y,mount_offset]){ // VESA 100
//          cylinder(d=10,h=5,$fn=60);
//        }
//        translate([37.5*X,37.5*Y,mount_offset]){  // VESA 75
//          cylinder(d=10,h=5,$fn=60);
//        }
      translate([10*X,25*Y,mount_offset]){ // 50 x 20
        cylinder(d=4.4,h=20,$fn=60);
        translate([0,0,5]) cylinder(d=10,h=10,$fn=60);
      }
      translate([17.5*X,37.5*Y,mount_offset]){ // 75 x 35
        cylinder(d=4.4,h=20,$fn=60);
      }
    }
  }
}

module panel(){
  translate([0,0,3.75]) cube([195, 99, 7.5], center=true);
  translate([8.9/2-97.5+18,0,7+.5+4.75]) cube([8.9,28,9.5], center=true);
}

module case(pi_offset=pi_offset){
  difference(){
    union(){
      translate([0,7.5,15]) hull() for(X=[-1,1], Y=[-1,1], Z=[-1,1]) 
        translate([100*X,60*Y,12.5*Z]) sphere(d=5,$fn=60);
      
    }
    translate([0,0,3.75]) cube([195.5, 99.5, 8.5], center=true);
    
    // Power plug hole
    translate([45,0,15]){
      translate([0,-50,0]) rotate([90,0,0]) 
        cylinder(d=11.5, h=25, center=true,$fn=60);
    }
      
    translate([0,0,7]) difference(){
      hull() for(X=[-1,1], Y=[-1,1]) translate([85*X,45*Y,0]) 
        cylinder(d=5,h=10,center=true,$fn=60);
        difference(){
          union(){
            translate([pi_offset-40.5,0,0]) cube([5, 96, 12], center=true);
            translate([-20,5,0]) cube([10, 60, 12], center=true);
            for(Y=[34,-24]) translate([pi_offset-40.5-(pi_offset+55)/2,Y,0]) 
              cube([pi_offset+55, 5.6, 12], center=true);
            for(Y=[37,-27]) translate([pi_offset-44,Y,0]) 
              cylinder(d=10,h=12,center=true,$fn=60);
          }
          hull() for(Y=[30,-20]) translate([pi_offset-38.5,Y,0]) 
            cylinder(d=10,h=12,center=true,$fn=60);
        }
    }
    for(X=[-1,1], Y=[-1,1]) translate([90.2*X,36.5*Y,5]) 
      cylinder(d=2,h=20,$fn=60,center=true);
    difference(){
      translate([0,7.5,25]) difference(){
        cube([197.5,117.5,30], center=true);
        difference(){
          for(X=[-1,1], Y=[-1,1]) translate([97.5*X,57.5*Y,0]) 
            cylinder(d=15,h=30,center=true,$fn=60);
          for(X=[-1,1], Y=[-1,1]) translate([95*X,55*Y,0]) 
            cylinder(d=3,h=10,center=true,$fn=60);
        }
        translate([0,57.5,-12.5]) 
          middle_screw_mount(height=20);
        translate([0,-57.5,-12.5]) 
          rotate([0,0,180]) middle_screw_mount(height=20);
      }
      translate([pi_offset-70,15,4.5]) for(X=[-1,1]){
        translate([24.5*X,-39,-1]) difference(){
          cylinder(d=5.6, h=20,$fn=60);
          cylinder(d=2.3, h=22,$fn=60);
        }
        translate([24.5*X,19,-1]) difference(){
          cylinder(d=5.6, h=20,$fn=60);
          cylinder(d=2.3, h=22,$fn=60);
        }
      }
      translate([45,-52.5,15]) rotate([90,0,0]) // plug houseing 
        cylinder(d=20, h=10, center=true,$fn=60);
    }
    translate([0,7.5,29]) hull() for(X=[-1,1], Y=[-1,1]) 
      translate([97.5*X, 57.5*Y, 0])
        cylinder(d=5, h=3, center=true, $fn=60);
    translate([0,58.8,9.5]) cube([26,18.5,3], center=true);
    translate([0,49,9.5]) cube([26,18.5,3], center=true);
//    %translate([0,51.1,7.8]) rotate([90,-90,0]) cube([10,10,3.5], center=true);
    
    translate([0,53,6]) for(X=[-1,1]) 
      translate([10.35*X,0,0]) cylinder(d=2, h=10, center=true, $fn=60);
    translate([0,57,6.5]) cube([10,20,3.4], center=true);
    translate([0,54,-12]) cylinder(d=7.2,h=20,$fn=60);
    
    translate([45,-56,15]) rotate([90,0,0]) // plug hole
      cylinder(d=16, h=10, center=true, $fn=60);
//    hull() for(X=[-1,1]) translate([45+10*X,-58,15])
//      rotate([90,0,0]) cylinder(d=8, h=10, center=true, $fn=60);
    
    // PI holes
    translate([pi_offset,0,-2]){
      // Ethernet
      translate([-60,-55,12]) cube([16,10,14]);
      // USB
      translate([-78,-55,9]) cube([17,10,17]);
      translate([-96.5,-55,9]) cube([17,10,17]);
//      %translate([-95,-55,9]) cube([15,10,17]);
      
      translate([-98,-51,5]) cube([55,5,10]);
    }
  }
}

module middle_screw_mount(height=20){
  translate([0,0,height/2]) difference(){
    cylinder(d=15,h=height,center=true,$fn=60);
    cylinder(d=3,h=height+1,center=true,$fn=60);
    translate([0,0,-height/2-5]) rotate([-45,0,0]) cube([20,40,10],center=true);
  }
    
}

module lid(type="horizontal"){
  translate([0,7.5,29]) 
  difference(){
    union(){
      hull() for(X=[-1,1], Y=[-1,1]) 
        translate([97.45*X, 57.45*Y, 0])
          cylinder(d=5, h=3, center=true, $fn=60);
      mount_offset=-3.5;
      for(X=[-1,1], Y=[-1,1]){
        if(type=="vertical"){
          translate([10*X,25*Y,mount_offset]) // 50 x 20
            cylinder(d=10,h=5,$fn=60);
          translate([17.5*X,37.5*Y,mount_offset]) // 75 x 35
            cylinder(d=10,h=5,$fn=60);
        }
        else{
          translate([25*X,10*Y,mount_offset]) // 50 x 20
            cylinder(d=10,h=5,$fn=60);
          translate([37.5*X,17.5*Y,mount_offset]) // 75 x 35
            cylinder(d=10,h=5,$fn=60);
        }
      }
    }
    for(X=[-1,0,1], Y=[-1,1]) translate([95*X,55*Y,0]) 
          cylinder(d=3.3,h=10,center=true,$fn=60);
    for(X=[-1,1], Y=[-1,1]){
        if(type=="vertical"){
          translate([10*X,25*Y,0]){ // 50 x 20
            cylinder(d=4.3,h=20,$fn=60,center=true);
            translate([0,0,-2]) fhex(m4_hex_nut,4);
          }
          translate([17.5*X,37.5*Y,0]){ // 75 x 35
            cylinder(d=4.3,h=20,$fn=60,center=true);
            translate([0,0,-2]) fhex(m4_hex_nut,4);
          }
        }
        else{
          translate([25*X,10*Y,0]){ // 50 x 20
            cylinder(d=4.3,h=20,$fn=60,center=true);
            translate([0,0,-2]) fhex(m4_hex_nut,4);
          }
          translate([37.5*X,17.5*Y,0]){ // 75 x 35
            cylinder(d=4.3,h=20,$fn=60,center=true);
            translate([0,0,-2]) fhex(m4_hex_nut,4);
          }
        }
    }
    for(X=[-85,-65,65,85], Y=[0:12.5:105]) translate([X,-50+Y,0]) fhex(10,10);
    for(X=[-75,-55,55,75], Y=[0:12.5:95]) translate([X,-44+Y,0]) fhex(10,10);
        
    for(X=[-45,-25,25,45], Y=[0,12.5,87.5,100]) translate([X,-50+Y,0]) fhex(10,10);
    for(X=[-35,-15,15,35], Y=[0,12.5,75,87.5]) translate([X,-44+Y,0]) fhex(10,10);
  }
}

module case10(){
  difference(){
    union(){
      translate([0,5,15]) hull() for(X=[-1,1], Y=[-1,1], Z=[-1,1]) 
        translate([100*X,55*Y,12.5*Z]) sphere(d=5,$fn=60);
      
    }
    translate([0,0,3.75]) cube([195, 99, 8.5], center=true);
      
    translate([0,0,7]) cube([191, 95, 10], center=true);
    difference(){
      translate([0,5,25]) cube([200,110,30], center=true);
      translate([0,58,7]) cube([20,10,10], center=true);
    }
    translate([0,50.6,14]) rotate([90,-90,0]) cube([25,25,2], center=true);
    %translate([0,51.1,7.8]) rotate([90,-90,0]) cube([10,10,3.5], center=true);
    translate([0,58,-1.5]) cylinder(d1=14, d2=7.2,h=12,$fn=60); // old 18
    translate([0,57.5,19.5]) cube([9,9,15], center=true);
    
    // Ethernet
    translate([-61,-55,9]) cube([16,10,14]);
    
    // USB
    translate([-78,-55,6]) cube([15,10,17]);
    translate([-96.5,-55,6]) cube([15,10,17]);
    
  }
}

module picam_board(){
//  %for(Y=[-1,1]) translate([0,12*Y,0]) cube([10,1,10], center=true);
//  %translate([-12,0,0]) cube([1,25,10], center=true);
//  %translate([-5.3,0,0]) cube([14.4,25,10], center=true);
  difference(){
    color("green") cube([25,25,1.15], center=true);
    for(X=[3.05,-10.35], Y=[-1,1]) translate([X,10.35*Y,0]) cylinder(d=2.3, h=4, center=true, $fn=60);
  }
  translate([9.5,0,2]) cube([5.5,20.4,3], center=true);
  translate([0,0,-2]) camera();
//  translate([0,0,-4.5-2]) rotate([0,90,0]) camera();
}

module camera(){
  cube([8.5,8.5,3.4], center=true);
  translate([0,0,-4]) cylinder(d=6.9,h=2.5,$fn=60);
}