
module slot_fill(length = 20) {
  difference() {
    translate([0, 0, 0]) rotate([0, 0, 0]) cylinder(r=4.5, h=length, center=true,  $fn=4);	
    //plane sides
	translate([-3.8, 0, 0]) rotate([0, 0, 0]) cube([4, 20, length*2], center=true);
	translate([3, 0, 0]) rotate([0, 0, 0]) cube([6, 20, length*2], center=true);
  }
}