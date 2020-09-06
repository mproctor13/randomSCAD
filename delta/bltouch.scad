
module fhex(wid,height){
  hull(){
    cube([wid/1.7,wid,height],center=true);
    rotate([0,0,120]) cube([wid/1.7,wid,height], center=true);
    rotate([0,0,240]) cube([wid/1.7,wid,height], center=true);
  }
}

//rotate([0,180,0]) bltouch();
// 67 - 36.3 -8 == 22.8

rotate([90,0,0]) dual_delta_bltouch();
module dual_delta_bltouch(){
//    translate([-7, -6, 0]) %cube([14,19,22.7]);
    difference(){
        union(){
            translate([0, 0, 3.9]) hull(){
              translate([-9, 0, 0]) cylinder(r=4, h=2.3, center=true, $fn=60);
              cube([6,11.53,2.3], center=true);
              translate([9, 0, 0]) cylinder(r=4, h=2.3, center=true, $fn=60);
            }
            translate([-9, 0, 2.5]) cylinder(r=4, h=5, center=true, $fn=60);
            translate([9, 0, 2.5]) cylinder(r=4, h=5, center=true, $fn=60);
            translate([0, 0, 13.85]) cylinder(d=11.5, h=17.7, center=true, $fn=6);
            
            hull(){
                translate([0, 13, 32.95]) cylinder(d=11, h=4.5, center=true, $fn=6);
                translate([6, -9, 26.7]) cylinder(d=2, h=9+8, center=true, $fn=60);
                translate([-6, -9, 26.7]) cylinder(d=2, h=9+8, center=true, $fn=60);
            }
            hull(){
                translate([6,-9, 20.45]) cylinder(d=2, h=4.5, center=true, $fn=60);
                translate([-6, -9, 20.45]) cylinder(d=2, h=4.5, center=true, $fn=60);
                translate([6, 6, 20.45]) cylinder(d=2, h=4.5, center=true, $fn=60);
                translate([-6, 6, 20.45]) cylinder(d=2, h=4.5, center=true, $fn=60);
            }
        }
        for(X=[-1,1]){
          translate([9*X, 0, 2.5]) cylinder(d=3.2, h=5.2, center=true, $fn=60);
        }
        translate([0, 13, 32.95]) cylinder(d=3.5, h=5, center=true, $fn=60);
        translate([-10, -6, 22.7]) cube([20,25,8.3]);
    }
    
}

module bltouch(){
  translate([0, 0, 1.15]) 
  difference(){
    hull(){
      translate([-9, 0, 0]) cylinder(r=4, h=2.3, center=true, $fn=60);
      cube([6,11.53,2.3], center=true);
      translate([9, 0, 0]) cylinder(r=4, h=2.3, center=true, $fn=60);
    }
    for(X=[-1,1]){
      translate([9*X, 0, -0.01]) cylinder(d=3.2, h=2.5, center=true, $fn=60);
    }
  }
  translate([0, 0, 3.85+2.3]) cylinder(d=11.5, h=7.7, center=true, $fn=60);
  hull(){
    translate([0, 3.05, 20.65]) cube([13,6.5,21.3], center=true);
    translate([0, 0, 20.65]) cylinder(d=13, h=21.3, center=true, $fn=60);
    translate([0, 0, 35.3]) cylinder(d=6.8, h=2, center=true, $fn=60);
  }
  translate([0, 6, 8]) cube([6.75,1.15,20], center=true); //wires
  translate([0, 0, 34.3]) color([.71,.71,.71]) cylinder(d=1.9, h=20, center=true, $fn=60);
}

module bltouch_hole(extra=0.5){
    translate([0, 3.05, 20.65]) cube([13+extra,6.5+extra,21.3], center=true);
    translate([0, 0, 20.65]) cylinder(d=13+extra, h=21.3, center=true, $fn=60);
}


module bltouch_mount(){
  difference(){
    union(){
      hull(){
        translate([4,-10,5.5]) rotate([90,0,0]) cylinder(d=6, h=2, center=true, $fn=60);
        translate([-4,-10,5.5]) rotate([90,0,0]) cylinder(d=6, h=2, center=true, $fn=60);
        translate([0,-2,5]) rotate([90,0,0]) cylinder(d=6, h=18, center=true, $fn=60);
        cube([6,11.53,1], center=true);
      }
      translate([-5,-11.5,5.5]) rotate([90,0,0]) cylinder(d=2.5, h=2, center=true, $fn=60);
      translate([5,-11.5,5.5]) rotate([90,0,0]) cylinder(d=2.5, h=2, center=true, $fn=60);
    }
    translate([0,-2,5]) rotate([90,0,0]) cylinder(d=3.5, h=20, center=true, $fn=60);
  }
  translate([0, 0, 0.11]) difference(){
    hull(){
      translate([-9, 0, 0]) cylinder(r=4, h=2.3, center=true, $fn=60);
      cube([6,11.53,2.3], center=true);
      translate([9, 0, 0]) cylinder(r=4, h=2.3, center=true, $fn=60);
    }
    for(X=[-1,1]){
      translate([9*X, 0, -0.01]) cylinder(d=3.2, h=2.5, center=true, $fn=60);
    }
  }
}
      
      
