
module sensor_spacer(){
  difference(){
    translate([0, 0, 0]) color([0,0,0]) cylinder(r1=15, r2=15, h=3, center=false, $fn=100);
    translate([0, 0, -0.5]) cylinder(d=19, h=20, center=false, $fn=60);
    translate([0, 40, -0.1]) cylinder(d=62, h=1.85, center=false, $fn=60);
  }
}

translate([0, 0, 3]) rotate([0,180,0]) sensor_spacer();


