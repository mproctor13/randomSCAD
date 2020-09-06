


module light_ring(){
  difference(){
    cylinder(d=60, h=1.45, center=true, $fn=60);
    translate([0, 0, -0.5]) cylinder(d=45, h=4, center=true, $fn=60);
  }
}

module ring_stay(){
  difference(){
    union(){
      hull(){
        translate([0, 0, 0]) cylinder(r1=4, r2=3.5, h=2, center=false, $fn=60);
        translate([-16, 0, 0]) cylinder(r1=4, r2=3.5, h=2, center=false, $fn=60);
      }
      translate([0, 0, 0]) cylinder(r1=4, r2=3, h=4, center=false, $fn=60);
      translate([-16, 0, 0]) cylinder(r1=4, r2=3, h=4, center=false, $fn=60);
      hull(){
        translate([-8, 10, 0]) cylinder(r1=2, r2=1.5, h=2, center=false, $fn=60);
        translate([-8, 0, 0]) cylinder(r1=2, r2=1.5, h=2, center=false, $fn=60);
      }
      hull(){
        translate([-8, 7, 2]) cylinder(r1=1.5, r2=1, h=1.5, center=false, $fn=60);
        translate([-8, 0, 2]) cylinder(r1=1.5, r2=1, h=1.5, center=false, $fn=60);
      }
    }
    translate([0, 0, -0.5]) cylinder(r=2, h=6, center=false, $fn=60);
    translate([-16, 0, -0.5]) cylinder(r=2, h=6, center=false, $fn=60);
  }
}
module balls(){
  for(z=[0,120,240]){
    rotate([0,0,z]){
      translate([30, 0, 0]) rotate([0,50,0]) translate([0, 0, -10]) rotate([0,-90,0])
      for(y=[1,-1]){
        translate([22, 24.5*y, 5]) color("silver") sphere(d=10);
      }
    }
  }
}

balls();

include <groove_mount.scad>;
translate([0, 0, 0]) rotate([0, 0, 90]) grooveMount();

include <mps_effector_bltouch.scad>;
mps_effector();
translate([0, 0, -2.5]) color([1,1,1]) light_ring();

include <ring_stay.scad>;
translate([-14, 8, -5.5]) rotate([0,0,90]) color([1,1,0]) ring_stay();
translate([0, -16, -5.5]) rotate([0,0,210]) color([1,1,0]) ring_stay();
translate([14, 8, -5.5]) rotate([0,0,330]) color([1,1,0]) ring_stay();


include <../Release/arm_end.scad>;
for(z=[0,120,240]){
  rotate([0,0,z]){
    translate([24, 0, 15]) rotate([0,125,0]) translate([0, 0, -10]) rotate([0,-90,0])
    for(y=[1,-1]){
      translate([22, 24.5*y, 5]) translate([0,0,27]) rotate([0,180,0]) arm_end();
    }
  }
}



effector_top();

rotate([0,180,-90]) translate([0,-50,-16]) color([1,1,1]) bltouch();
//translate([-32.18,7.35,10]) cylinder(d=3,2, h=20, center=true, $fn=60);
//translate([-21.8,-7.35,10]) cylinder(d=3,2, h=20, center=true, $fn=60);

//rotate([0,180,-90]) translate([0,-27,-16]) rotate([0,0,-35]) color([1,1,1]) bltouch();
//color([0.3,0.3,1]) mps_effector();
////translate([40,-30,0]) rotate([50,0,90]) import("kossel_ball_carriage.stl");
////rotate([0,0,30]) grooveMount();
//translate([0,0,-10.9]) rotate([0,0,-90]) poly_stoooder();
//translate([0,0,-22]) rotate([0,0,-90]) poly_stoooder_heads();
//translate([0,0,-28.65]) cube([50,50,1], center=true);