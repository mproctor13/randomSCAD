
include <configuration.scad>;
include <vertex.scad>;

projection()
for (a = [0:120:360]) rotate([0, 0, a]) {
  translate([0, delta_radius+45, 0]) rotate([0, 0, 180]) vertex(1);
  difference(){
    translate([-250.5,-246.5,10]) rotate([0, 90, 0]) color([0,0,0]) cube([20, 250, 505]);
  for(x=[-1,1]){  
    translate([-200*x, -236.5, 20]) rotate([0, 180, 0]) cap_bolt_boolean(m5_bolt_boolean, 40);
    //translate([-175*x, -236.5, 20]) rotate([0, 180, 0]) cap_bolt_boolean(m5_bolt_boolean, 40);
    translate([-100*x, -236.5, 20]) rotate([0, 180, 0]) cap_bolt_boolean(m5_bolt_boolean, 40);
    //translate([-75*x, -236.5, 20]) rotate([0, 180, 0]) cap_bolt_boolean(m5_bolt_boolean, 40);
    translate([0*x, -236.5, 20]) rotate([0, 180, 0]) cap_bolt_boolean(m5_bolt_boolean, 40);
  }
  }
}
