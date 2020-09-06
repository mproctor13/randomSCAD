include <configuration.scad>;
include <nema23_plate.scad>;

module nema23_spacer(height=30){
  translate([0, 0, 2.5]) nema23_plate();
  for(a = [-1, 1]){
    linear_extrude(height) {
      polygon([[28*a,8],[28*a,13],[13*a,28],[8*a,28]], paths=[[0,1,2,3]], h=10);
    }
  }
  translate([-28, -17, 0]) cube([5,30,height]);
  translate([23, -17, 0]) cube([5,30,height]);
  translate([0, 0, height-2.5]) nema23_plate();
}

nema23_spacer(25);