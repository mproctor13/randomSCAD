ppx=250;
ppy=250;
ppz=0;
split=25;


for(X=[-1,1], Z=[-1,1]){
  translate([310*X,0,split*Z]) rod();
  translate([0,ppy-280,split*Z]) rotate([0,0,90]) rod();
  translate([310*X,295*Z,10]) %cube([15,10,100], center=true);
  translate([310*X,215*Z,-500]) cylinder(d=10, h=914.4, $fn=30, center=true);
}
rod_interface();
bed();
frame();
bed_frame();
carrage();


translate([300,55+560-280,10]) rotate([90,180,0]) import("hotend-v2-single.stl");
translate([200,55+560-280,10]) rotate([90,180,0]) import("hotend-v2-single.stl");
translate([100,55+560-280,10]) rotate([90,180,0]) import("hotend-v2-single.stl");

module carrage(){
  translate([ppx-255,ppy-280,0]){
    color("red") cube([50,20,70], center=true);
    translate([-110,10,10]) rotate([90,180,180]) import("carriage-v2.stl");
    translate([55,55,10]) rotate([90,180,0]) import("hotend-v2-single.stl");
    translate([0,30,-20]) cylinder(d=6, h=100, $fn=30, center=true);
    translate([0,45+20,0]) %cube([59,79,70], center=true);
    translate([0,40,-50]) %cylinder(d=6, h=32.5, $fn=30, center=true);
  }
}

module rod_interface(){
  for(X=[-1,1]) translate([302*X,ppy-280,0]) 
    cube([30,18,70], center=true);
}


module bed_frame(){
  for(X=[-1,1], Y=[-1,1]){
    translate([260*X,0,-100-ppz]) rotate([0,90,90]) beam(length=500);
    translate([0,260*Y,-100-ppz]) rotate([0,90,0]) beam(length=500);
  }
}

module frame(){
  for(X=[-1,1], Y=[-1,1]){
    translate([335*X,375*Y,-400]) beam(length=1000);
    translate([0,375*Y,80]) rotate([0,90,0]) beam(length=650, height=40);
    translate([335*X,0,80]) rotate([0,90,90]) beam(length=730, height=40);
      
    translate([0,375*Y,-940]) rotate([0,90,0]) beam(length=650, height=80);
    translate([335*X,0,-940]) rotate([0,90,90]) beam(length=750, height=80);
  }
}

module beam(length=100, height=20){
  color("black") cube([height,20,length], center=true);
}

module bed(){
  translate([0,0,-73-ppz]) color("white") cube([508,508,2], center=true);
  translate([0,0,-75-ppz]) color("lightgrey") cube([523.24,523.24,2], center=true);
}

module rod(){
  rotate([90,0,0]) color("silver") cylinder(d=8, h=600, $fn=30, center=true);
}