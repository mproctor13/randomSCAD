include <vslot.scad>

delta_radiusb=235;
beam_lengthb=500;
beam_heightb=1500;

module belts(){
  color("black") difference(){
    hull(){
      translate([0, delta_radiusb+45, 25]) rotate([90, 0, 0]) cylinder(d=12.5, h=6, $fn=60);
      translate([0, delta_radiusb+45, 1490]) rotate([90, 0, 0]) cylinder(d=12.5, h=6, $fn=60);
    }
    hull(){
      translate([0, delta_radiusb+46, 25]) rotate([90, 0, 0]) cylinder(d=10.5, h=8, $fn=60);
      translate([0, delta_radiusb+46, 1490]) rotate([90, 0, 0]) cylinder(d=10.5, h=8, $fn=60);
    }
  }
}

module corner(){
  difference(){
  translate([0, delta_radiusb+50, -25]) rotate_extrude(angle=360, convxity=15) {
    translate([30,0,0])
    union(){
      translate([-10,0,0]) square([20,20]);
      circle(d=20, $fn=120);
    }
  }
    translate([0,delta_radiusb-62,-35]) rotate([0,0,30]) cube([100,100,40]);
    translate([-85,delta_radiusb-13,-35]) rotate([0,0,-30]) cube([100,100,40]);
  }
}

module curve_beam(){
    translate([-250,-delta_radiusb+62.7,-25]) rotate([90,0,90]) linear_extrude(height=beam_lengthb) union(){
      translate([-10,0,0]) square([20,20]);
      circle(d=20, $fn=120);
    }
}

module 2D_top(){
  projection(cut=true) cylinder(d=533.4, h=5, $fn=90); //20" table top
}

module fhex(wid,height){
  hull(){
    cube([wid/1.7,wid,height],center=true);
    rotate([0,0,120]) cube([wid/1.7,wid,height], center=true);
    rotate([0,0,240]) cube([wid/1.7,wid,height], center=true);
  }
}

module bed_mount(){
  difference(){
    hull(){
      rotate([0,0,120]) hull(){
        translate([-195, -172, 60]) cylinder(d=20, h=15, $fn=30);
        translate([-175, -172, 60]) cylinder(d=20, h=15, $fn=30);
      }
      hull(){
        translate([195, -172, 60]) cylinder(d=20, h=15, $fn=30);
        translate([175, -172, 60]) cylinder(d=20, h=15, $fn=30);
      }
    }
    rotate([0,0,120]) translate([-175, -172, 63]) cylinder(d=12, h=5, $fn=30);
    rotate([0,0,120]) translate([-175, -172, 59]) cylinder(d=5, h=15, $fn=30);
    translate([175, -172, 63]) cylinder(d=12, h=5, $fn=30);
    translate([175, -172, 59]) cylinder(d=5, h=15, $fn=30);
    translate([0, 0, 65.2]) cylinder(d=508, h=10, $fn=360);
  
    translate([225, -130, 65.2]) cylinder(d=3.3, h=10, $fn=30);
    translate([225, -130, 61]) fhex(5.7,5);
  }
}

module pindown(){
  difference(){
    hull(){
      translate([0, 0, 0]) cylinder(d=12, h=4, $fn=60, center=true);
      translate([5, 14, -1]) cylinder(d=12, h=2, $fn=60, center=true);
      translate([-5, 14, -1]) cylinder(d=12, h=2, $fn=60, center=true);
    }
    translate([0, 0, 0]) cylinder(d=3.8, h=4.2, $fn=60, center=true);
  }
}



module printer(){
for (a = [0:120:360]) rotate([0, 0, a]) {
  // bottom frame
  translate([-(beam_lengthb/2),-delta_radiusb+63,10]) rotate([0,90,0]) vslot20x20(beam_lengthb, vslot_color_black);
  translate([-(beam_lengthb/2),-delta_radiusb+63,50]) rotate([0,90,0]) vslot20x20(beam_lengthb, vslot_color_black);
  translate([0, delta_radiusb+50, 0]) rotate([0, 0, 180]) import("griffin/frame_motor_2020sw.STL");
  // uprights
  translate([-(beam_lengthb/2),-delta_radiusb+63,50]) 
    rotate([0,0,30]) translate([-8,24,-50]) vslot20x20(beam_heightb, vslot_color_black);
//  // top frame
//  translate([-(beam_lengthb/2),-delta_radiusb+63,beam_heightb-10]) 
//    rotate([0,90,0]) vslot20x20(beam_lengthb, vslot_color_black);
//  translate([0, delta_radiusb+50, beam_heightb]) rotate([0, 0, 180]) translate([0,3,-20]) import("griffin/frame_top_2020sw.STL");
  
  bed_mount();
  belts();
//    corner();
//    curve_beam();
}
// glass plate
//translate([0, 0, 70]) rotate([0, 0, 0]) %cylinder(d=508, h=5, $fn=90); //20" table top

}

printer();
