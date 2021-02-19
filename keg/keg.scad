//%projection(cut=true) 
//rotate([30,0,0]) 
//rotate([0,90,0]) translate([-100,-100,0]) import("keg.stl");
//difference(){
//  %rotate([0,0,90])
//  scale([4,4,4])
//  import("Keg1a.stl");
//  
//}
//$fn=360;

//difference(){
////intersection(){
//    model();
//    cylinder(d=80,h=57);
//}

//cube([30, 43.2, 1], center=true);
screen_mount();
module screen_mount(){
  difference(){
    translate([0,0,2.5]) cube([35,45,5], center=true);
    translate([0,0,3.5]) cube([25,50,5], center=true);
      
    translate([0,0,0.8+1]) cube([36,43.25,1.6], center=true);
      
    translate([0,43.2/2-0.55-1.5,0]) cube([28.5,3,5], center=true);
    cube([22,25,5], center=true);
    hull() for(Y=[-1,1])
      translate([0,Y*20,6]) rotate([55*Y,0,0]) cube([36,5,5], center=true);
  }
  
}

module model(){
difference(){
  body();
  translate([0,0,85]) cube([30,30,15], center=true);
  translate([0,0,10]) cylinder(d=60,h=68);
  translate([0,0,2]) cylinder(d1=38,d2=60,h=10);
  difference(){
    hull() for(Y=[-1,1])
      translate([0,5*Y,85]) rotate([0,90,0]) 
        cylinder(d=8, h=100, center=true);
    cylinder(d=60, h=100);
  }
  translate([0,-25,40]) cube([20,30,55], center=true);
//  cube(100);
}
}
module body(){
  rotate_extrude(angle=360) 
  difference(){
    rotate([0,0,90]) import("keg.dxf");
    square(100);
  }
}
module outline(){
projection(cut=true) rotate([90,0,0])
rotate([0,90,0])
  scale([4,4,4])
  import("Keg1a.stl");
}

//use <../PiZero.scad>
//translate([-10,-10,40]) rotate([0,90,0]){
//  PiZeroBody();
//  PiGPIO(1);
//}