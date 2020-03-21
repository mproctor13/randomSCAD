include <MCAD/shapes.scad>


m3_hex_nut=5.6;
m3_nut_height=2.25;
m4_hex_nut=7.2;
m4_nut_height=2.9;
m5_hex_nut=7.8;
m5_nut_height=3.9;

module fhex(wid,height){
  hull(){
    cube([wid/1.7,wid,height],center=true);
    rotate([0,0,120]) cube([wid/1.7,wid,height], center=true);
    rotate([0,0,240]) cube([wid/1.7,wid,height], center=true);
  }
}

module bolt_slot(nut_size=3, nut_length=5, hole_size=3.3, slot_size=7, slot_length=20, depth=10){
  translate([10,0,0]) rotate([0,90,0]) 
    cylinder(d=hole_size, h=slot_length+nut_length+15, $fn=30, center=true);
  hull(){
    translate([slot_length,0,0]) rotate([0,90,0]) cylinder(d=slot_size, h=slot_length, $fn=30, center=true);
    translate([slot_length,depth,0]) rotate([0,90,0]) cylinder(d=slot_size, h=slot_length, $fn=30, center=true);
  }
  hull(){
    translate([-(nut_length/2),0,0]) rotate([90,0,90]) fhex(nut_size,nut_length);
    translate([-(nut_length/2),depth,0]) rotate([90,0,90]) fhex(nut_size,nut_length);
  }
}

module center_slot(){
  rotate([270,0,0]) bolt_slot(nut_size=m3_hex_nut, nut_length=5, hole_size=3.3, slot_size=7, slot_length=20, depth=10);
}

module rpi(){
  difference(){
    color([0,.6,0]) roundedBox(85, 56, 2, 3);
    for(x=[0,58], y=[0,49]){
      translate([(-85/2)+3.5+x,-(56/2)+3.5+y,0]) cylinder(d=2.75, h=5, center=true, $fn=20);
    }
  }
  translate([-36,21,2]) cube([52,6,6]);
}

module corner_pipe(){
  intersection(){
    rotate_extrude(convexity=10) translate([13,0,0]) circle(d=5, $fn=100);
    translate([0,0,-20]) cube([40,40,40]);
  }
}

module main_plate(){
  difference(){
  union(){
    difference(){
      translate([0,0,20]) roundedBox(200, 280, 40, 15);
    translate([0,0,27]) roundedBox(190, 270, 35, 10);
    translate([0,-40,9]) color([.2,.2,.2]) cube([170, 170, 4], center=true);
      
    translate([80,58,7])
    for(y=[0,45]){
      translate([0,y,0]) cylinder(d=3.4, h=15, center=true, $fn=20);
      translate([0,y,-5]) cylinder(d=7, h=5, center=true, $fn=20);
    }
//  cube([300, 80, 100], center=true);
    }
    translate([84.5,124.5,40]) corner_pipe();
    translate([-84.5,124.5,40]) rotate([0,0,90]) corner_pipe();
    
    translate([-84.5,-124.5,40]) rotate([0,0,180]) corner_pipe();
    translate([84.5,-124.5,40]) rotate([0,0,270]) corner_pipe();
    
    
      translate([40,90,7])
      for(x=[0,58], y=[0,49]){
        translate([(-85/2)+3.5+x,-(56/2)+3.5+y,4]) cylinder(d=7, h=5, center=true, $fn=20);
      }
      translate([97.5,0,40]) rotate([0,90,90]) cylinder(d=5, h=250, center=true, $fn=20);
      translate([-97.5,0,40]) rotate([0,90,90]) cylinder(d=5, h=250, center=true, $fn=20);
      
      translate([0,137.5,40]) rotate([0,90,0]) cylinder(d=5, h=170, center=true, $fn=20);
      translate([0,-137.5,40]) rotate([0,90,0]) cylinder(d=5, h=170, center=true, $fn=20);
    }
    translate([40,90,7])
    for(x=[0,58], y=[0,49]){
      translate([(-85/2)+3.5+x,-(56/2)+3.5+y,0]) cylinder(d=2.75, h=15, center=true, $fn=20);
      translate([(-85/2)+3.5+x,-(56/2)+3.5+y,-5]) cylinder(d=6.5, h=5, center=true, $fn=20);
    }
    for(Y=[130,100,70]){
      translate([-15,Y, 4.5]) center_slot();
    }
    for(Y=[40,10,-10,-40]){
      translate([15,Y, 3.5]) rotate([0,0,180]) center_slot();
    }
    for(Y=[-70,-100,-130]){
      translate([-15,Y, 3.5]) center_slot();
    }
    for(X=[30, 60, 90, -30, -60, -90]){
      translate([X,-57.5,3.5]) rotate([0,0,90]) center_slot();
      translate([X,57.5,3.5]) rotate([0,0,270]) center_slot();
    }
//   translate([-15,100,4.5]) center_slot();
  }
}

module parts(part=0){
      
//    translate([(125/2)-10,0,(125/2)-1]) cube([125, 105, 125], center=true);
  if(part==1){
    intersection(){
      translate([-(125/2)-10,-115,(125/2)-1]) cube([125, 125, 125], center=true);
      main_plate();
    }
  }
  else if(part==2){
    intersection(){
      translate([-(125/2)+10,0,(125/2)-1]) cube([125, 105, 125], center=true);
      main_plate();
    }
  }
  else if(part==3){
    intersection(){
      translate([-(125/2)-10,115,(125/2)-1]) cube([125, 125, 125], center=true);
      main_plate();
    }
  }
  else if(part==4){
    intersection(){
      translate([(125/2)-10,-115,(125/2)-1]) cube([125, 125, 125], center=true);
      main_plate();
    }
  }
  else if(part==5){
    intersection(){
      translate([(125/2)+10,0,(125/2)-1]) cube([125, 105, 125], center=true);
      main_plate();
    }
  }
  else if(part==6){
    intersection(){
      translate([(125/2)-10,115,(125/2)-1]) cube([125, 125, 125], center=true);
      main_plate();
    }
  }
  else{
    main_plate();
  }
}

//translate([0,52,10]) %cube([170, 15, 4], center=true);
//
//translate([20,90,10]) rotate([0,0,180]) rpi();
//
//translate([78,80,12+10]) color([1,1,1]) cube([27, 38, 23], center=true);
parts(part=0);
//parts(part=2);
////parts(part=3);
//parts(part=4);
//parts(part=5);
//parts(part=6);
//    difference(){
//hull(){
//for(x=[-1,1], y=[-1,1]){
//  translate([90*x,130*y,10]) sphere(r=15);
//  translate([90*x,130*y,35]) sphere(r=15);
//}
//}
//    translate([0,0,33]) roundedBox(190, 270, 35, 15);
//  cube([300, 80, 100], center=true);
//}

