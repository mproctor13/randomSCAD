
include <MCAD/stepper.scad>

include <vslot.scad>


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


module 2020_nema17(){
  difference(){
    union(){
      translate([-10,36,42.5])
      hull(){
        for(Y=[-1,1], Z=[-1,1]){
          translate([10,21*Y,20*Z]) rotate([0,90,0]) cylinder(d=10, h=20, center=true, $fn=30);
          translate([10,21*Y,20*Z]) rotate([0,90,0]) cylinder(d=10, h=20, center=true, $fn=30);
        }
      }
      translate([0,12,42])
      hull(){
        for(Z=[-1,1]){
          translate([0,0,40*Z]) rotate([0,90,0]) cylinder(d=5, h=20, center=true, $fn=30);
        }
      }
      translate([0,9.5,42]) rotate([0,0,90]) slot_fill(length=78);
    }

    translate([-10,37,42]) 
    union(){
      hull(){
        for(Y=[-1,1], Z=[-1,1]){
          translate([26,17.6*Y,17.6*Z]) rotate([-45*Y*Z,0,0]) cube([50,7,5], center=true);
        }
      }
      for(Y=[-1,1], Z=[-1,1]){
        translate([5,15.5*Y,15.5*Z]) rotate([0,90,0]) cylinder(d=3.8, h=15, center=true, $fn=60);
      }
      rotate([0,90,0]) cylinder(d=22.5, h=5, center=true, $fn=60);
    }
    translate([0,10,75]) rotate([90,0,0]) cylinder(d=6, h=10, center=true, $fn=30);
    translate([0,10,10]) rotate([90,0,0]) cylinder(d=6, h=10, center=true, $fn=30);
  }
}

module pb_extruder(){
//   %cube([22,42,12.7], center=true);
  difference(){
  color("silver")
  hull(){
    for(Y=[-21+2,21-2], Z=[-6.35+2,6.35-2]){
      translate([0,Y,Z]) rotate([0,90,0]) cylinder(d=4, h=22, center=true, $fn=60);
    }
  }
    translate([8.1,15.5,1.9]) rotate([0,90,0]) cylinder(d=6.45, h=6, center=true, $fn=60);
    translate([8.1,-15.5,1.9]) rotate([0,90,0]) cylinder(d=6.45, h=6, center=true, $fn=60);
    translate([0,15.5,1.9]) rotate([0,90,0]) cylinder(d=3.3, h=23, center=true, $fn=60);
    translate([0,-15.5,1.9]) rotate([0,90,0]) cylinder(d=3.3, h=23, center=true, $fn=60);
  
    translate([0,5,0]) cylinder(d=16, h=13, center=true, $fn=60);
    translate([0,17,0]) cube([3,10,13], center=true);
  
    translate([8,-17,-5]) cylinder(d=3, h=10, center=true, $fn=60);
    translate([-8,-17,-5]) cylinder(d=3, h=10, center=true, $fn=60);
  
    translate([0,-15.5,0]) cylinder(d=4, h=13, center=true, $fn=60);
    
    translate([-8,14,-5]) cylinder(d=3, h=10, center=true, $fn=60);
  }
}

module reverse_bowden_old(){
  difference(){
    union(){
      hull(){
        cylinder(d=22, h=5, center=true, $fn=60);
        translate([0,43,0]) cylinder(d=22, h=5, center=true, $fn=60);
      }
      translate([0,43,35]) cylinder(d=22, h=70, center=true, $fn=60);
      hull(){
        translate([0,28,65]) cylinder(d=22, h=10, center=true, $fn=60);
        translate([0,43,65]) cylinder(d=22, h=10, center=true, $fn=60);
      }
    }
    translate([-1.7,26.5,0]) cylinder(d=16.5, h=13, center=true, $fn=60);
    
    translate([6.5,4.5,0]) cylinder(d=3.4, h=10, center=true, $fn=60);
    translate([-9.5,4.5,0]) cylinder(d=3.4, h=10, center=true, $fn=60);
    
    translate([-9.5,35.5,0]) cylinder(d=3.4, h=10, center=true, $fn=60);

    translate([0,33,31.3]) cube([25,20,57.5], center=true);
    translate([0,28,65]) cylinder(d=5.7, h=11, center=true, $fn=60);
  }
}

module reverse_bowden(){
//  translate([0,43,0]) cube([10,10,15]);
//  translate([-5,46,0]) cube([5,10,15]);
  difference(){
    union(){
      hull(){
        translate([0,0,2.5]) cylinder(d=22, h=5, center=true, $fn=60);
        translate([9,44,2.5]) cylinder(d=4, h=5, center=true, $fn=60);
        translate([-9,44,2.5]) cylinder(d=4, h=5, center=true, $fn=60);
      }
      
      hull(){
        translate([9.5,44.5,2.5]) cylinder(d=3, h=5, center=true, $fn=60);
        translate([-9.5,44.5,2.5]) cylinder(d=3, h=5, center=true, $fn=60);
        for(X=[-9,9], Y=[45,48]){
          translate([X,Y,15]) cylinder(d=4, h=1, center=true, $fn=60);
        }
      }
//      hull(){
//        for(X=[-9,9], Y=[45,52]){
//          translate([X,Y,15]) cylinder(d=4, h=1, center=true, $fn=60);
//        }
//      }
      hull(){
        for(X=[-9,9], Y=[45,48]){
          translate([X,Y,40]) cylinder(d=4, h=50, center=true, $fn=60);
        }
      }
      hull(){
        translate([-9,48,65]) cylinder(d=4, h=5, center=true, $fn=60);
        translate([9,48,65]) cylinder(d=4, h=5, center=true, $fn=60);
        translate([0,28,65]) cylinder(d=22, h=5, center=true, $fn=60);
      }
    }
    translate([-1.7,26.5,0]) cylinder(d=16.5, h=13, center=true, $fn=60);
    
    translate([6.5,4.5,2.5]) cylinder(d=3.4, h=10, center=true, $fn=60);
    translate([-9.5,4.5,2.5]) cylinder(d=3.4, h=10, center=true, $fn=60);
    translate([-9.5,34.5,2.5]) cylinder(d=3.4, h=10, center=true, $fn=60);

    translate([-1.7,26.5,65]) cylinder(d=5.7, h=11, center=true, $fn=60);
  }
}

module extruder_assembly(){
    translate([10,0,0]) pb_extruder();
    translate([-10,37,-25]) rotate([0,0,180]) 2020_nema17();
    translate([11.5,-21.5,-9]) reverse_bowden();
}

//extruder_assembly();
//translate([30,0,2.5]) reverse_bowden_old();
//reverse_bowden();
