include <vslot.scad>
include <MCAD/stepper.scad>
include <slot_fill.scad>
include <gimbal.scad>


square_diameter=4;
square_height=3;
square_size=(41.5/2)-(square_diameter/2);
nema17_mount=31.04/2;
nema17_ring=22;

geared_mount_height=4;
geared_size=28/2;
hole_fudge=0.3;


module fhex(wid,height){
  hull(){
    cube([wid/1.7,wid,height],center=true);
    rotate([0,0,120]) cube([wid/1.7,wid,height], center=true);
    rotate([0,0,240]) cube([wid/1.7,wid,height], center=true);
  }
}


module nema_mate(){
  difference(){
    union(){
      hull(){
        for(X=[-1,1], Y=[-1,1]){
          translate([square_size*X,square_size*Y,0]) cylinder(d=4, h=square_height, $fn=60, center=true);
        }
      }
      translate([0,0,square_height/2]) cylinder(d=nema17_ring, h=1.9, $fn=60, center=true);
    }
    for(X=[-1,1]){
      translate([geared_size*X,0,0]) cylinder(d=7, h=square_height+0.2, $fn=60, center=true);
      translate([0,geared_size*X,0]) cylinder(d=7, h=square_height+0.2, $fn=60, center=true);
    }
    for(X=[-1,1], Y=[-1,1]){
      translate([nema17_mount*X,nema17_mount*Y,0]) cylinder(d=3.4, h=square_height+0.2, $fn=60, center=true);
    }
    cylinder(d=14.8, h=square_height*2, $fn=60, center=true);
  }
}

module gear_mate(){
  difference(){
    union(){
      hull(){
        for(X=[-1,1], Y=[-1,1]){
          translate([square_size*X,square_size*Y,0]) cylinder(d=4, h=geared_mount_height, $fn=60, center=true);
        }
      }
    }
    gear_mate_remove();
  }
}

module gear_mate_remove(){
    for(X=[-1,1], Y=[-1,1]){
      translate([nema17_mount*X,nema17_mount*Y,0]) cylinder(d=3.4, h=geared_mount_height+hole_fudge, $fn=60, center=true);
      translate([nema17_mount*X,nema17_mount*Y,1.5]) fhex(5.7,3);
      translate([nema17_mount*X,nema17_mount*Y,15.4]) cylinder(d=8, h=25, $fn=60, center=true);
    }
    for(X=[-1,1]){
      translate([geared_size*X,0,0]) cylinder(d=3.4, h=geared_mount_height+hole_fudge, $fn=60, center=true);
      translate([0,geared_size*X,0]) cylinder(d=3.4, h=geared_mount_height+hole_fudge, $fn=60, center=true);
    }
    translate([0,0,geared_mount_height/2]) cylinder(d=nema17_ring+hole_fudge, h=1.9+hole_fudge, $fn=60, center=true);
    cylinder(d=14.8, h=square_height*2.1, $fn=60, center=true);
    translate([0,0,14.5]) cylinder(d=36+hole_fudge, h=25, $fn=60, center=true);
}

module geared_mount(){
  difference(){
    union(){
      translate([-10,35,42.5])
      hull(){
        for(Y=[-1,1], Z=[-1,1]){
          translate([10,18*Y,16*Z]) rotate([0,90,0]) cylinder(d=10, h=20, center=true, $fn=30);
          translate([10,18*Y,16*Z]) rotate([0,90,0]) cylinder(d=10, h=20, center=true, $fn=30);
        }
      }
      translate([0,14,42])
      hull(){
        for(Z=[-1,1]){
          translate([0,0,40*Z]) rotate([0,90,0]) cylinder(d=5, h=20, center=true, $fn=30);
        }
      }
      translate([0,11.5,42]) rotate([0,0,90]) slot_fill(length=78);
    }

    translate([-8,37,42]) rotate([0,90,0]) gear_mate_remove();
    translate([0,12,75]) rotate([90,0,0]) cylinder(d=6, h=10, center=true, $fn=30);
    translate([0,12,10]) rotate([90,0,0]) cylinder(d=6, h=10, center=true, $fn=30);
  }
}

//geared_mount();
nema_mate();
