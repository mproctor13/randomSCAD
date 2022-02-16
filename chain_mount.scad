

//%translate([-4,2,0])
//import("../printer/Hot_end_chain_bracket.stl");

mount_dia=14;
moutside=14;
mhole=4.95;
m_offset=[0,10];
$fn=60;

difference(){
  translate([m_offset[0],m_offset[1]+2,13])
    union(){
      hull(){
        rotate([90,0,0]) cylinder(d=mount_dia,h=moutside+4,center=true);
        translate([0,0,-12.5]) 
          cube([mount_dia,moutside+4,0.1],center=true);
        translate([0,0,-12.5]) 
          cube([mount_dia-6,moutside+8.5,0.01],center=true);
        translate([0,0,-12.95]) 
          cube([mount_dia-6,moutside+6.5,0.1],center=true);
        translate([0,0,-12.95]) 
          cube([mount_dia-1,moutside+4,0.1],center=true);
      }
      translate([3,0,-13]) cylinder(d=17,h=7);
    }
  translate([m_offset[0]+12,m_offset[1]+2,0])
    rotate([0,-45,0]) cube([10,moutside+4,5],center=true);
  translate([m_offset[0],m_offset[1]+2,13])
    rotate([90,0,0]) cylinder(d=mhole,h=moutside+6,center=true,$fn=60);
  translate([m_offset[0],m_offset[1]+2,-2])
    hull(){
      cylinder(d=10,h=20);
      translate([-10,0,0]) cylinder(d=10,h=20);
    }
  translate([m_offset[0],m_offset[1]+2,12])
    rotate([90,0,0]) cylinder(d=18,h=moutside,center=true);
}
//  %hull(){
//    translate([m_offset[0],m_offset[1]-moutside/2,3.5]) 
//      cube([mount_dia,1,7],center=true);
//    translate([0,-20,3.5]) 
//      cube([mount_dia,1,7],center=true);
//  }
  hull(){
    // top
    translate([m_offset[0],m_offset[1]-moutside/2,7]) 
      cube([mount_dia,1,0.01],center=true);
    translate([0,-20,7]) 
      cube([mount_dia,1,0.01],center=true);
    // middle
    translate([m_offset[0],m_offset[1]-moutside/2,0.5]) 
      cube([mount_dia,1,0.01],center=true);
    translate([0,-20,0.5]) 
      cube([mount_dia,1,0.01],center=true);
    // bottom
    translate([m_offset[0],m_offset[1]-moutside/2,0]) 
      cube([mount_dia-1,1,0.01],center=true);
    translate([0,-20,0]) 
      cube([mount_dia-1,1,0.01],center=true);
  }

difference(){
  hull() for(X=[-1,1]) translate([20*X,-25,0])
    cylinder(d=15,h=7);
  for(X=[-1,1]) translate([20*X,-25,-1])
    cylinder(d=8,h=10);
  translate([0,-20-24.5,-1])
    cylinder(d=45,h=10);
  translate([-15,-32,4]) rotate([0,0,60])
  cube([10,19,10], center=true);
  translate([15,-32,4]) rotate([0,0,-60])
  cube([10,15,10], center=true);
}