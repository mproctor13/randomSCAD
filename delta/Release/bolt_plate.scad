


difference(){
  union(){
    translate([-20, -24, 0]) rotate([0, 270, 0]) 
    hull(){
      translate([6, 6, 0]) cylinder(r=6, h=7, center=false, $fn=60);
      translate([42, 6, 0]) cylinder(r=6, h=7, center=false, $fn=60);

      translate([6, 42, 0]) cylinder(r=6, h=7, center=false, $fn=60);
      translate([42, 42, 0]) cylinder(r=6, h=7, center=false, $fn=60);
    }
  }
  for(y=[1,-1]){
    translate([-30, 16*y, 40]) color([0,0,0]) rotate([0, 90, 0]) cylinder(r=2.2, h=15, center=false, $fn=60);
    translate([-30, 16*y, 8]) color([0,0,0]) rotate([0, 90, 0]) cylinder(r=2.2, h=15, center=false, $fn=60);
  }
}