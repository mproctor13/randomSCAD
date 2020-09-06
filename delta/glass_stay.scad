include <slot_fill.scad>
include <threads.scad>
//import("griffin/Griffin_glass_mount_knob.stl");

//import("griffin/Griffin_glass_mount_stud.stl");

GLASS_STAY_DIA=20;
GLASS_STAY_PITCH=5;


module glass_stay(){
  difference(){
    union(){
  metric_thread(diameter=GLASS_STAY_DIA, pitch=GLASS_STAY_PITCH, length=25, square=true, n_starts=4);
  translate([0,0,23]) cylinder(d=20, h=2, $fn=30);
  translate([0,0,18]) cylinder(d1=12, d2=20, h=5, $fn=30);
  intersection(){
    translate([0,0,25]) rotate([0,90,0]) slot_fill(length=20);
    translate([0,0,25]) cylinder(d=20, h=5, $fn=30);
  }
    }
    translate([0,0,-0.001]) cylinder(d=10, h=24, $fn=30);
    translate([0,0,24.31]) cylinder(d=5, h=2.5, $fn=30);
//    cube([20,20,30]);
  }
}

module glass_knob(){
  difference(){
    union(){
      for(R=[0:20:360]){
        rotate([0,0,R]) translate([12,0,0]) cylinder(d=5, h=9.99, $fn=30);
      }
      cylinder(d=25, h=9.99, $fn=30);
    }
    translate([0,0,-0.001]) metric_thread (diameter=GLASS_STAY_DIA+0.5, pitch=GLASS_STAY_PITCH, length=10, internal=true, n_starts=4);
  }
}

glass_knob();


//translate([30,0,0]) glass_stay();






