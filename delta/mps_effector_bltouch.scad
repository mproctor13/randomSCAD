include <groove_mount.scad>;
include <configuration.scad>;

module fhex(wid,height){
  hull(){
    cube([wid/1.7,wid,height],center=true);
    rotate([0,0,120]) cube([wid/1.7,wid,height], center=true);
    rotate([0,0,240]) cube([wid/1.7,wid,height], center=true);
  }
}

module tabs(){
  for(y=[1,-1]){
    translate([17, 11*y, 0]) 
    union(){
      difference(){
        hull(){
          translate([-3, -3, 0]) cube([6,6,10]);
          translate([0, 12*y, 0]) cylinder(r=3, h=10, center=false, $fn=60);
          translate([-12, 12*y, 0]) cylinder(r=3, h=10, center=false, $fn=60);
        }
        translate([-10, 8*y, 5]) color([0,0,0]) rotate([0, 90, 0]) cylinder(r=2.2, h=15, center=false, $fn=60);
      }
      translate([12, 8*y, 5]) sphere(d=10, $fn=60);
      //translate([-8, 8*y, 5]) color([0,0,0]) rotate([0, 90, 0]) cylinder(r=2.2, h=15, center=false, $fn=60);
    }
  }
}

//PolyStroooder Tri Hotend mount hole shape
module mountHole() 
{
    union() 
    {
        hull() 
        {
            for (a = [90:120:360]) 
            {
                rotate([0, 0, a])
                translate([11.5, 0, 0])
                square([1, 5], center=true);
            }
        }
     
        for (a = [10:120:360]) 
        {
            rotate([0, 0, a]) 
            {
                translate([0, 11.7, 0])
                circle(r=1, center=true, $fn=15);
            }
            rotate([0, 0, a-20]) {
                translate([0, 11.7, 0])
                circle(r=1, center=true, $fn=15);
            }
        }
    }
}

module mount_tubes(){
  rotate([0,-90,0])
  union(){
    difference(){
      union(){
          for(y=[1,-1]){
            translate([22, 24*y, 5]) rotate([0, 90, 0]) cylinder(d=8, h=6, center=false, $fn=60);
          }
      }
      for(y=[1,-1]){
        translate([15, 24*y, 5]) rotate([0, 90, 0]) cylinder(r=2.2, h=15, center=false, $fn=60);
      }
    }
  }
}

module mps_effector(){
  for(z=[0,120,240]){
    rotate([0,0,z]){
      translate([30, 0, 0]) rotate([0,50,0]) translate([0, 0, -20]) mount_tubes();
    }
  }
  difference(){
    union(){
      difference(){
        hull(){
          for(z=[0,120,240]){
            rotate([0,0,z]){
              translate([22, -30, 6]) rotate([0, 50, 0]) cube([10,60,5]);
            }
          }
        } 
  
        hull(){
          for(z=[0,120,240]){
            rotate([0,0,z]){
              translate([21, -20, 3]) sphere(d=5, $fn=60);
              translate([21, -20, 25]) cylinder(d=5, h=5, $fn=60);
              translate([21, 20, 3]) sphere(d=5, $fn=60);
              translate([21, 20, 25]) cylinder(d=5, h=5, $fn=60);
            }
          }
        }
      }
    }
    translate([0, 0, -2]) rotate([0, 0, -30]) linear_extrude(h=5) mountHole();
    for(z=[0,120,240]){
      rotate([0,0,z]){
        for(y=[1,-1]){
          translate([14, -8, -5]) cylinder(d=3.3, h=15, $fn=60);
          translate([14, 8, -5]) cylinder(d=3.3, h=15, $fn=60);
          translate([22, 24*y, 0]) rotate([0, 50, 0]) cylinder(r=2.2, h=35, center=false, $fn=60);
          translate([12, 24*y, -8]) rotate([0, 50, 0]) cylinder(r=4, h=20, center=false, $fn=60);
        }
        translate([25, 0, 2]) rotate([0, 50, 0]) cylinder(r=2, h=20, center=false, $fn=60);
        translate([17, 0, 5]) rotate([0, 90, 0]) cylinder(r=2, h=10, center=false, $fn=60);
      }
    }
  }
}

module bltouch(){
  difference(){
    hull(){
      translate([-9, 0, 0]) cylinder(r=4, h=2.3, center=true, $fn=60);
      cube([6,11.53,2.3], center=true);
      translate([9, 0, 0]) cylinder(r=4, h=2.3, center=true, $fn=60);
    }
    for(X=[-1,1]){
      translate([9*X, 0, -0.01]) cylinder(d=3.2, h=2.5, center=true, $fn=60);
    }
  }
}

module offsets(){
    
    
}
//bltouch();
mps_effector();
grooveMount();
