include <configuration.scad>;

module nema23_plate(){
  difference(){
    hull() for(x=[-1,1],y=[-1,1]) translate([23*x, 23*y, 0]) cylinder(r=5, h=5, center=true, $fn=60);
    translate([0, 0, -5]) cylinder(d=38.4,h=10,$fn=90);
    //bolt holes
    for(a = [-1, 1]){
      translate([23.5*a, -23.5, 19]) color([0,1,0]) cylinder(r=2.5, h=50, center=true, $fn=60);
      translate([23.5*a, 23.5, 19]) color([0,1,0]) cylinder(r=2.5, h=50, center=true, $fn=60);
    }
  }
}
//nema23_plate();