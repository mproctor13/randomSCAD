$fn=60;
include <fhex.scad>

//cr10_mount();
translate([-17,0,-5]) rotate([0,0,90]) cable_mount();
////nema_cable_mount();

module cr10_mount(thickness=5){
//  %translate([-22.65,0,-2.5]) cube([4,20,5]);
  %translate([0,0,22+2.5]) cube([44,44,44], center=true);

  difference(){
    union(){
      for(X=[-1,1], Y=[-1,1]) translate([17*X,17*Y,0])
        cylinder(d=8, h=thickness, center=true);
      hull()
        for(X=[-1,1], Y=[-1,1]) translate([17*X,17*Y,-1])
          cylinder(d=8, h=3, center=true);
//      translate([-25.5,-9.5-6.5,-2.5]) cube([3,25,50]);
//      translate([-25.5,-9.5-6.5,-2.5]) cube([10,25,3]);
//      translate([-22.5,-6.5,-2.5]) hull(){
//        cube([5,15,3]);
//        translate([-3,0,6]) cube([3,15,3]);
//      }
    }
    for(X=[-1,1], Y=[-1,1])
      translate([17*X, 17*Y, 0])
        cylinder(d=3.3, h=thickness+2, center=true);
    
    hull(){
      cylinder(d=20,h=thickness+2,center=true);
      translate([0,35,0])
        cube([20,1,thickness+2], center=true);
    }
    %for(X=[-1,1], Y=[-1,1])
      translate([17*X, 17*Y, 20])
        cylinder(d=3.3, h=75, center=true);
  }
}

module cable_mount(thickness=17, width=12, offset=5){
  backing_thickness=2;
  hole_thickness=3;
  translate([offset,0,0]) difference(){
    union(){
      for(X=[-1,1]) hull(){
        translate([width*X,5,-1]) cylinder(d=2,h=2);
        translate([width*X,11,-thickness]) 
          cylinder(d=2,h=thickness);
      }
      translate([0,11,-thickness/2]) 
        cube([width*2,2,thickness], center=true);
    }
    translate([5,11,-thickness/2])
      rotate([90,0,0]) cylinder(d=3.3,h=5,center=true);
    for(Z=[-1,1]) translate([5-7.5,11,-thickness/2+3.25*Z])
      rotate([90,0,0]) cylinder(d=3.3,h=5,center=true);
  }
  difference(){
    union(){
      hull() for(X=[-1,1]){
      translate([17*X, 0, 0])
        cylinder(d=8, h=backing_thickness, center=true);
      translate([17*X, 8, 0])
        cylinder(d=8, h=backing_thickness, center=true);
      }
      for(X=[-1,1]) translate([17*X, 0, backing_thickness/2-hole_thickness/2])
        cylinder(d=8, h=hole_thickness, center=true);
      hull() for(X=[-1,1])
        translate([-17+4*X, 8, 0])
          cylinder(d=8, h=backing_thickness, center=true);
    }
    for(X=[-1,1])
      translate([17*X, 0, 0])
        cylinder(d=3.3, h=5, center=true);
    for(X=[-1,1])
      translate([-17+4*X, 8.5, 0])
        cylinder(d=3.3, h=5, center=true);
  }
}

module nema_cable_mount(base_width=27){
mount_dia=14;
moutside=14;
mhole=4.95;
$fn=60;

  difference(){
    union(){
      translate([0,25,10]) hull(){
        rotate([0,90,0]) cylinder(d=mount_dia,h=moutside+4,center=true);
        translate([0,-12.5,0]) 
          cube([moutside+4,0.1,mount_dia],center=true);
        translate([0,-12.5,0]) 
          cube([moutside+8.5,0.01,mount_dia-6],center=true);
        translate([0,-25,-2.5]) cube([moutside,1,5],center=true);
      }
      for(Y=[-1,1]) 
        hull() for(Z=[-1,1]) translate([0,15.5*Y,5*Z])
          rotate([0,90,0]) 
            cylinder(d=10,h=base_width,center=true);
      translate([0,0,5]) 
        cube([base_width,31,10],center=true);
    }
    translate([0,25,10]) rotate([0,90,0]) {
      cylinder(d=mhole,h=moutside+12,center=true,$fn=60);
      cylinder(d=18,h=moutside,center=true);
    }
    hull() translate([0,0,8]) rotate([0,90,90]){
      cylinder(d=10,h=60,center=true);
      translate([-10,0,0]) cylinder(d=14,h=60,center=true);
    }
    for(Y=[-1,1]) translate([0,15.5*Y,-5])
      rotate([0,90,0]) 
        cylinder(d=6,h=base_width+2,center=true);
  }
}

