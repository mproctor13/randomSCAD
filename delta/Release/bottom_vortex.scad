
include <vertex.scad>;

module bottom_vortex(width=1) {
  //beam test
  //color([0, 1, 0]) translate([-97, 40, 5]) rotate([0, 0, 120]) cube([70, 20, 10], center=true);
  translate([0, 0, height/2]) rotate([0, 0, 0]) vertex(width);
}

bottom_vortex();
