difference(){
  translate([0, 0, 6]) cylinder(d1=12, d2=8, h=12, center=true, $fn=60);
  translate([0, 0, 5.99]) cylinder(d=6, h=12.1, center=true, $fn=60);
}