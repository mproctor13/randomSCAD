include <vslot.scad>
include <MCAD/shapes.scad>

module slot_fill(length = 20){
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

module power_connector(){
  difference(){
    union(){
      hull(){
        translate([0, -16, 8.225]) cube([27,1,16.45], center=true);
        translate([11.5, 21.5, 8.225]) cylinder(d=4, h=16.45, center=true, $fn=30);
        translate([-11.5, 21.5, 8.225]) cylinder(d=4, h=16.45, center=true, $fn=30);
        translate([0,-21.5, 8.225]) cube([18,5,16.45], center=true);
      }
      translate([0,-16, 16.45+5.5]) cube([5.7,0.75,11], center=true);
      translate([8,2, 16.45+5.5]) cube([5.7,0.75,11], center=true);
      translate([8,-8, 16.45+5.5]) cube([5.7,0.75,11], center=true);
    //  translate([0,-29.5,-5]) color("black") cube(7.3);
      difference(){
        hull(){
          translate([11.5, 27.5, -1.11]) cylinder(d=4, h=2.22, center=true, $fn=60);
          translate([-11.5, 27.6, -1.11]) cylinder(d=4, h=2.22, center=true, $fn=60);
          
          translate([22, 0, -1.11]) cylinder(d=4, h=2.22, center=true, $fn=60);
          translate([-22, 0, -1.11]) cylinder(d=4, h=2.22, center=true, $fn=60);
          
          translate([11.5, -27.5, -1.11]) cylinder(d=4, h=2.22, center=true, $fn=60);
          translate([-11.5, -27.5, -1.11]) cylinder(d=4, h=2.22, center=true, $fn=60);
        }
        translate([20, 0, -1.12]) cylinder(d=4, h=2.3, center=true, $fn=60);
        translate([-20, 0, -1.12]) cylinder(d=4, h=2.3, center=true, $fn=60);
      }
      hull(){
        translate([12.75, 24.5, -2.11]) cylinder(d=4, h=2.22, center=true, $fn=60);
        translate([-12.75, 24.5, -2.11]) cylinder(d=4, h=2.22, center=true, $fn=60);
        translate([12.75, -24.5, -2.11]) cylinder(d=4, h=2.22, center=true, $fn=60);
        translate([-12.75, -24.5, -2.11]) cylinder(d=4, h=2.22, center=true, $fn=60);
      }
    }
    translate([0,-11,0]) hull(){
      cube([24,12,10], center=true);
      translate([0,-5,0]) cube([17.6,12,10], center=true);
    }
  }
}


module power_connector_mount(){
  difference(){
    union(){
      translate([12,0,31]) rotate([0,90,0]) roundedBox(56, 70, 4, 4);
      //slot fills
      translate([10,0,10]) rotate([90,0,0]) slot_fill(length=65);
      translate([10,0,50]) rotate([90,0,0]) slot_fill(length=65);
    hull(){
      for(Y=[-1,1], Z=[10,50]){
        translate([14.6,25*Y,Z]) rotate([0,90,0]) cylinder(d=10, h=2, center=true, $fn=30);
      }
      translate([30,0,30]) rotate([0,90,0]) cylinder(d=1, h=40, center=true, $fn=3);
    }
       translate([30,0,30]) rotate([90,90,-90]) hull(){
          translate([13.5, 29.5, -1.11]) cylinder(d=4, h=35, center=true, $fn=60);
          translate([-13.5, 29.6, -1.11]) cylinder(d=4, h=35, center=true, $fn=60);
          
          translate([24, 0, -1.11]) cylinder(d=4, h=35, center=true, $fn=60);
          translate([-24, 0, -1.11]) cylinder(d=4, h=35, center=true, $fn=60);
          
          translate([13.5, -29.5, -1.11]) cylinder(d=4, h=35, center=true, $fn=60);
          translate([-13.5, -29.5, -1.11]) cylinder(d=4, h=35, center=true, $fn=60);
        }
    }
    translate([32,0,30]) rotate([0,90,0]) roundedBox(30, 50, 50, 4);
    for(Y=[-1,1], Z=[10,50]){
      translate([12,25*Y,Z]) rotate([0,90,0]) cylinder(d=5, h=10, center=true, $fn=30);
      translate([20.6,25*Y,Z]) rotate([0,90,0]) cylinder(d=10, h=10, center=true, $fn=120);
    }
    translate([45,0,10]) rotate([0,90,0]) cylinder(d=4.5, h=10, center=true, $fn=30);
    translate([45,0,50]) rotate([0,90,0]) cylinder(d=4.5, h=10, center=true, $fn=30);
    
    translate([25,0,10]) rotate([0,90,0]) cylinder(d=10, h=40, center=true, $fn=30);
    translate([25,0,50]) rotate([0,90,0]) cylinder(d=10, h=40, center=true, $fn=30);
  }
}

module power_connector_mount_parts(part=0){
  if( part == 1){
    difference(){
      power_connector_mount();
      translate([64,0,30]) cube([100,100,100], center=true);
    }
  }
  else if( part == 2){
    intersection(){
      power_connector_mount();
      translate([64.01,0,30]) cube([100,100,100], center=true);
    }
  }
  else{
    power_connector_mount();
  }
}

//translate([0,100,10]) rotate([90,0,0]) vslot20x20(200, vslot_color_black);
//translate([0,100,50]) rotate([90,0,0]) vslot20x20(200, vslot_color_black);

//translate([50,0,30]) rotate([90,90,-90]) power_connector();
power_connector_mount_parts();
//rotate([0,-90,0])power_connector_mount_parts(part=2);
//rotate([0,90,0])power_connector_mount_parts(part=1);