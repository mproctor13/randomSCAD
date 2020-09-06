
include <vertex_n.scad>;

module bottom_vortex_n(width=1) {
  difference(){
    translate([0, 0, height/2]) rotate([0, 0, 180]) vertex_n(width);
  }
}

bottom_vortex_n();
