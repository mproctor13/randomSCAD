include <configuration.scad>;

module end_cap1(){
       
  union(){
    translate([0,0,3]){
      difference() {
        cylinder(r=11, h=15, center=true, $fn=60);
        translate([0,0,5]) cylinder(r=8.50, h=15, center=true, $fn=60);
//        color([0,0,1]) union() {
//          translate([15,-5,-5]){
//            rotate([90,0,0])
//            import("../1605.stl");
//          }
//          translate([0,0,35]){
//            cylinder(r=5, h=80, center=true, $fn=60);
//          }
//       }
       for(x =[-1, 1]) translate([0, 25*x, 2]) rotate([90*x, 0, 0]) cap_bolt_boolean(m5_bolt_boolean, 20);
      }
           
    }
    difference(){
      union(){
        difference(){
          translate([0,0,-18]) cylinder(r=6.30, h=30, center=true, $fn=60);
          translate([0,0,-23]) cylinder(r=3.675, h=30, center=true, $fn=60);
        }
        translate([-3.5,2.88,-28]) cube([7,2,25]);
      }
      for(z =[3, 13]) translate([0, 20, -30+z]) rotate([90, 0, 0]) cap_bolt_boolean(m5_bolt_boolean, 20);
    }
  }
}

end_cap1();
