
include <vertex.scad>;

module middle_vortex(width=1) {
  //beam test
  //color([0, 1, 0]) translate([-97, 40, 5]) rotate([0, 0, 120]) cube([70, 20, 10], center=true);
  difference(){
    translate([0, 0, height/2]) rotate([0, 0, 0]) vertex(width);
    translate([0, 40, 19]) color([0,1,0]) cylinder(r=12, h=5, center=true, $fn=60);
    translate([0, 40, 19]) color([0,1,0]) cylinder(r=6.5, h=40, center=true, $fn=60);
    //bolt hole
    for(a = [-1, 1]){
      translate([23.5*a, 16.5, 19]) color([0,1,0]) cylinder(r=2.5, h=50, center=true, $fn=60);
      translate([23.5*a, 63.5, 19]) color([0,1,0]) cylinder(r=2.5, h=50, center=true, $fn=60);
    }
  }
}