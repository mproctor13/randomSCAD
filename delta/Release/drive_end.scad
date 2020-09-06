include <configuration.scad>;

module end_cap1(){ 
  union(){
    difference() {
      hull(){
        translate([0,0,5]) cylinder(r=14, h=10, center=false, $fn=60);
        cylinder(r=11, h=15, center=false, $fn=60);
      }
      translate([0,0,10]) cylinder(r=8.50, h=15, center=true, $fn=60);
      for(x =[-1, 1]) translate([0, 25*x, 8]) rotate([90*x, 0, 0]) cap_bolt_boolean(m5_bolt_boolean, 20);
    }
    difference(){
      union(){
        difference(){
          hull(){
            translate([0,0,-18]) cylinder(r=6.20, h=40, center=true, $fn=60);
            translate([0,0,-21]) cylinder(r=5.20, h=38, center=true, $fn=60);
          }
          translate([0,0,-30]) cylinder(r=3.675, h=22, center=true, $fn=60);
        }
        translate([-3.5,2.88,-37]) cube([7,2,25]);
      }
      for(z =[0, 10]) translate([0, 20, -35+z]) rotate([90, 0, 0]) cap_bolt_boolean(m5_bolt_boolean, 20);
    }
  }
}
end_cap1();
