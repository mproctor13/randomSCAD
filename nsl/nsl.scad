
    translate([0,60,0])
    rotate([90,0,0]) import("Pumpkin1.stl");
    logo();
    
module logo(){
R = 65;  // radius
H = 15;   // height
L = 105; // centering offset
step = 5;

$fn=360/step;

difference(){
intersection(){
  for (i=[0:step:360]){
    radian = R*PI/180;
    rotate([0, i, 0])   translate([0,0,R-H/2]) // cylinder stuff
    intersection(){
      translate([L-i*radian, 0, 0])  // shift dxf over the window
      linear_extrude(height = H, center = true, convexity = 4)
      text("[   ]", size=50, font = "Arial:style=Bold");
      cube([radian*step, 120, H+1], center = true);  // window
    }
  }
  translate([0,18,0]) sphere(d=125, $fn=30);
}

  translate([0,18,0]) sphere(d=120, $fn=30);
}
}