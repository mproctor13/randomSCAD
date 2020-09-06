
module slot_fill(length = 20) {
  difference() {
    translate([0, 0, 0]) rotate([0, 0, 0]) cylinder(r=4.5, h=length, center=true,  $fn=4);	
    //plane sides
	translate([-3.8, 0, 0]) rotate([0, 0, 0]) cube([4, 20, length*2], center=true);
	translate([3, 0, 0]) rotate([0, 0, 0]) cube([6, 20, length*2], center=true);
  }
}

//camera_mount();

//translate([162.3,-87,0])  import("/home/mproctor/Downloads/vslot_cam/Mounting_system_for_Raspberry_Pi_cameraFront.stl");
ring_mount();
//translate([0,-5,0])  import("/home/mproctor/Downloads/vslot_cam/Mid-Hinge.STL");
//difference(){
//    translate([0,0,5])  rotate([0,90,0]) cylinder(d=10, h=5, center=true, $fn=60);
//    translate([0,0,5])  rotate([0,90,0]) cylinder(d=3, h=7, center=true, $fn=60);
//    translate([-4,0,5])  rotate([0,90,0]) cylinder(d=6, h=7, center=true, $fn=60);
//}
// rbowdin_mount();
//layout();

module ring_mount(){
//     translate([0,0,2]) %difference(){
//       cylinder(d=60, h=1, center=true, $fn=120);
//       cylinder(d=52, h=2, center=true, $fn=120);
//    }
    difference(){
        translate([0,0,1]) cylinder(d=65, h=4, center=true, $fn=120);
        translate([0,0,3]) cylinder(d=60.2, h=9, center=true, $fn=120);
    }
    difference(){
        union(){
            for(X=[-1,1], Y=[-1,1]) translate([15*X, 15*Y,0]) cylinder(d=5.5, h=2, center=true, $fn=60);
            translate([19,-19,0]) rotate([0,0,45]) cube([5.5,10,2], center=true);
            translate([-19,19,0]) rotate([0,0,45]) cube([5.5,10,2], center=true);
            
            translate([-19,-19,0]) rotate([0,0,-45]) cube([5.5,10,2], center=true);
            translate([19,19,0]) rotate([0,0,-45]) cube([5.5,10,2], center=true);
        }
//        translate([0,0,2]) cube([28, 28, 5], center=true);
        for(X=[-1,1], Y=[-1,1]) translate([15*X, 15*Y,0]) cylinder(d=3, h=5, center=true, $fn=60);
    }
}

module camera_mount(){
//    %cube([40,20,20], center=true);
    
    difference(){
        union(){
            translate([0,0,2.5]) rotate([0,90,0]) slot_fill(length=40);
            hull(){
                for(X=[-1,1], Y=[-1,1]) translate([16*X, 6*Y,0]) cylinder(d=8, h=5, center=true, $fn=60);
                translate([0,15,0])  rotate([0,0,0]) cylinder(d=10, h=5, center=true, $fn=60);
            }
        }
        for(X=[-1,1]) translate([10*X, 0,0]) cylinder(d=5, h=15, center=true, $fn=60);
        translate([0,15,4]) cylinder(d=6, h=7, center=true, $fn=60);
        translate([0,15,0]) cylinder(d=3, h=7, center=true, $fn=60);
    }
}


module layout(){
    translate([0,0,135]) %difference(){
        rotate([0,90,0]) cylinder(r=115, h=100, center=true, $fn=60);
        rotate([0,90,0]) cylinder(d=8, h=105, center=true, $fn=60);
    }
    rbowdin_mount();
    translate([100,0,0]) mirror() 10lbmount();
    translate([-100,0,0])  10lbmount();
}

module rbowdin_mount(){
    difference(){
      translate([0,10.5,0]) rotate([90,0,90]) slot_fill(length=40);
      translate([-10,15,0]) rotate([90,0,0]) cylinder(d=5, h=15, center=true, $fn=60);
      translate([10,15,0]) rotate([90,0,0]) cylinder(d=5, h=15, center=true, $fn=60);
    }
    difference(){
      union(){
        hull(){
          for(Z=[-1,1], Y=[-1,1]) {
            translate([0,16*Y,10]) rotate([0,90,0]) cylinder(d=8, h=40, center=true, $fn=60);
            translate([0,16*Y,-6]) rotate([0,90,0]) cylinder(d=8, h=40, center=true, $fn=60);
          }
        }
        difference(){
            union(){
                hull(){
                    translate([0,100,27]) cylinder(d=20, h=10, center=true, $fn=60);
                    translate([0,105,30]) rotate([0,90,0]) cylinder(d=10, h=40, center=true, $fn=60);
                    translate([0,15,9]) rotate([0,90,0]) cylinder(d=10, h=40, center=true, $fn=60);
                }
            }
            translate([0,100,35]) cylinder(d1=9, d2=20, h=10, center=true, $fn=60);
            translate([0,100,25]) cylinder(d=9, h=20, center=true, $fn=60);
            translate([0,100,17]) cylinder(d=20, h=10, center=true, $fn=60);
        }
      }
      cube([45,20.2,20.2],center=true);
      translate([0,-8,0]) rotate([0,90,0]) cylinder(d=8, h=45, center=true, $fn=60);
      for(Y=[-1,1]){
        translate([10*Y,15,0]) rotate([90,0,0]) cylinder(d=5, h=15, center=true, $fn=60);
        translate([10*Y,20,0]) rotate([90,0,0]) cylinder(d=12, h=5, center=true, $fn=60);
      }
    }
}

module 10lbmount(){
difference(){
  translate([0,10.5,0]) rotate([90,0,90]) slot_fill();
  translate([0,15,0]) rotate([90,0,0]) cylinder(d=5, h=15, center=true, $fn=60);
}
difference(){
  union(){
    hull(){
      for(Y=[-1,1]) translate([5,10*Y,0])
      rotate([0,90,0]) cylinder(d=20, h=10, center=true, $fn=60);
      translate([5,0,135]) rotate([0,90,0]) cylinder(d=40, h=10, center=true, $fn=60);
    }
    hull(){
      for(Z=[-1,1], Y=[-1,1]) {
        translate([0,16*Y,10]) rotate([0,90,0]) cylinder(d=8, h=20, center=true, $fn=60);
        translate([0,16*Y,-6]) rotate([0,90,0]) cylinder(d=8, h=20, center=true, $fn=60);
      }
    }
  }
  cube([40,20.2,20.2],center=true);
  
  hull() for(Z=[135,155]){
    translate([0,0,Z]) rotate([0,90,0]) cylinder(d=12.5, h=25, center=true, $fn=60);
  }
  translate([0,-8,0]) rotate([0,90,0]) cylinder(d=8, h=25, center=true, $fn=60);
  translate([0,15,0]) rotate([90,0,0]) cylinder(d=5, h=15, center=true, $fn=60);
  translate([0,20,0]) rotate([90,0,0]) cylinder(d=12, h=5, center=true, $fn=60);
}

}


