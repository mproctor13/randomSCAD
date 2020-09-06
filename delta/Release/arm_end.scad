
module arm_end(extra=.2){
  difference(){
    translate([0, 0, 12.5]) cylinder(r=6, h=25, center=true, $fn=90);
    translate([0, 0, 9.9]) cylinder(r=4+0.2+extra, h=20, center=true, $fn=90);
    translate([0, 0, 24.1]) cylinder(r=5+extra, h=2, center=true, $fn=90);
  //  cube([20,20,25]);
  }
}


arm_end();