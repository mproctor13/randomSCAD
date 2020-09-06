

module slot_fill(length = 20) {
	difference() {
		translate([0, 0, 0]) rotate([0, 0, 0])
		 cylinder(r=4.5, h=length, center=true,  $fn=4);	

//plane sides
		translate([-3.8, 0, 0]) rotate([0, 0, 0])
		 cube([4, 20, length*2], center=true);
		translate([3, 0, 0]) rotate([0, 0, 0])
		 cube([6, 20, length*2], center=true);
	}
}

difference(){
  union(){
    cube([90,20,10], center=true);
    translate([0, 0, -5]) rotate([0,-90,90]) slot_fill();
  }
  translate([0,5,0]) cylinder(d=3.6, h=15, center=true, $fn=60);
  translate([0,-5,0]) cylinder(d=3.6, h=15, center=true, $fn=60);
  for(X=[-38,-25,-12, 12, 25, 38]){
    translate([X,-5,5]) rotate([90, 0, 0]) cylinder(d=6.5, h=15, center=true, $fn=120);
  }
  translate([0,0,4]) cube([10,22,6], center=true);
}
