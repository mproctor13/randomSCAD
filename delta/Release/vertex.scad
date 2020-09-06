include <configuration.scad>;


module vertex(width=2) {
difference() {
  union() {
    difference() {
	  union() {
// Corner Section
		intersection() {
		  minkowski() {
			translate([0, 40, 0]) rotate([0, 0, 0])
			  cylinder(r=63-thickness, h=height-1, center=true, $fn=6);					
			  cylinder(r=thickness, h=1, center=true, $fn=60);
		  }
		  translate([0, -20, 0]) rotate([0, 0, 30])
		  cylinder(r=50, h=height+1, center=true, $fn=6);
 		}
		translate([-45, 0, 0]) intersection() {
		  minkowski() {
			translate([0, 40, 0]) rotate([0, 0, 0])
			  cylinder(r=63-thickness, h=height-1, center=true, $fn=6);					
			  cylinder(r=thickness, h=1, center=true, $fn=60);
		  }
		  translate([0, -20, 0]) rotate([0, 0, 30])
		  cylinder(r=50, h=height+1, center=true, $fn=6);
 		}
		translate([45, 0, 0]) intersection() {
		  minkowski() {
			translate([0, 40, 0]) rotate([0, 0, 0])
			  cylinder(r=63-thickness, h=height-1, center=true, $fn=6);					
			  cylinder(r=thickness, h=1, center=true, $fn=60);
		  }
		  translate([0, -20, 0]) rotate([0, 0, 30])
		  cylinder(r=50, h=height+1, center=true, $fn=6);
 		}
                
        //union() { 
          translate([-77, 45, 0]) rotate([0, 0, 120]) cube([65, 20, 21], center=true);
          translate([77, 45, 0]) rotate([0, 0, -120]) cube([65, 20, 21], center=true);
          //translate([0, 70, 0]) rotate([0, 0, 0]) cube([200, 10, 21], center=true);
          translate([0, 30, 0]) rotate([0, 0, 0]) cube([140, 70, 21], center=true);
          translate([0, 60, 0]) rotate([0, 0, 0]) cube([170, 36, 21], center=true);
		//}

// Slot Fill
        for (a = [-1, 1]) translate([0, 28, 0]) rotate([0, 0, 30*a]) scale([a, 1, 1]) {
          translate([-68, 53.75, 0]) rotate([90, 0, 0])
		  slot_fill(60);
		}

	}
  for (a = [-1, 1]){
    translate([-55*a, 43, 0]) rotate([0, 90, 30*a])
      hull(){
        translate([10, 0, 0]) cylinder(r=6, h=40, center=true, $fn=60);
        cylinder(r=6, h=40, center=true, $fn=60);
      }
    translate([-75*a, 75, 0]) rotate([0, 90, 30*a])
      //hull(){
        //translate([10, 0, 0]) cylinder(r=6, h=40, center=true, $fn=60);
        cylinder(r=6, h=40, center=true, $fn=60);
      //}
  }

// Side Screw Sockets
			for (a = [-1, 1]) translate([0, 0, 0]) rotate([0, 0, 30*a]) {
				translate([-63.5*a, 111, 0]) rotate([0, 0, 0]) {
					for (y = [-46, -9]) {
						translate([a*7, y, 0]) rotate([0, a*90, 0])
						 cap_bolt_boolean(m5_bolt_boolean, 15);
			         }
				}
			}
// Beam Screw Sockets 
    for (a = [-1, 1]) translate([0, 0, 0]) rotate([180, 0, 30*a]) {
      //for (z = [-10, 10]) translate([-25.1*a, 0.5, z]) rotate([90, 0, 0]) {
      translate([-64.1*a, -25.5, 0]) rotate([90, 0, 0]) {
        cap_bolt_boolean(m5_bolt_boolean, 40);
      }
    }

  // Misumi Beam Boolean 
  difference() {
	translate([0, 0, 330-height+5]) rotate([0, 0, 90])
	cube([20.1+extra_boolean, (width*20.1)+extra_boolean, 660],center=true);
    for(a = [(-10*(width-1)): 20: (10*width)]){
	  translate([1*a, -(20.1+extra_boolean)/2, 0]) rotate([0, 0, -90])
	  slot_fill(height);
    }
  }
  for(a = [(-10*(width-1)): 20: (10*width)])
    translate([1*a, -16, 0]) rotate([90, 0, 180]) {
	  cap_bolt_boolean(m5_bolt_boolean, 10);
	}

// Fix overhang Pads 
	for (m = [1, -1]) translate([0, 0, 0]) scale([1, 1, m]) {
		for (a = [-1, 1]) translate([26*a, 8, height/2-19.25]) rotate([0, 0, 0]) {
			translate([0, 0, 0]) rotate([0, 0, 0])
			 cylinder(r=5, h=0.2, $fn=30);
		}
	}
  }
}
for(x=[-1,1]){
    translate([-30*x, 0, 20]) rotate([0, 180, 0]) cap_bolt_boolean(m5_bolt_boolean, 40);
    translate([-50*x, 0, 20]) rotate([0, 180, 0]) cap_bolt_boolean(m5_bolt_boolean, 40);
}
}
}

vertex(1);
