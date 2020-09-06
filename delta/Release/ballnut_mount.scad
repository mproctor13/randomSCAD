//
include <ISOThreadUM2.scad>;



module fhex(wid,height){
  hull(){
    cube([wid/1.7,wid,height],center=true);
    rotate([0,0,120]) cube([wid/1.7,wid,height], center=true);
    rotate([0,0,240]) cube([wid/1.7,wid,height], center=true);
  }
}

module ballnut() {
  difference(){
    union(){
      difference(){
        translate([0, 0, 0]) color([0,1,0]) cylinder(r=24, h=11, center=false, $fn=60);
        translate([-40, -25, -2]) color([0,1,1]) cube([20,50,15]);
        translate([20, -25, -2]) color([0,1,1]) cube([20,50,15]);
      //holes
        translate([0, 20, -5]) color([0,0,0]) cylinder(r=2.8, h=43, center=false, $fn=60);
        translate([0, -20, -5]) color([0,0,0]) cylinder(r=2.8, h=43, center=false, $fn=60);
        
        translate([13.5, 13.5, -5]) color([0,0,0]) cylinder(r=2.8, h=43, center=false, $fn=60);
        translate([13.5, -13.5, -5]) color([0,0,0]) cylinder(r=2.8, h=43, center=false, $fn=60);
        translate([-13.5, -13.5, -5]) color([0,0,0]) cylinder(r=2.8, h=43, center=false, $fn=60);
        translate([-13.5, 13.5, -5]) color([0,0,0]) cylinder(r=2.8, h=43, center=false, $fn=60);
      }
      translate([0, 0, 0]) color([0,1,0]) cylinder(r=14, h=43, center=false, $fn=60);
    }
    translate([0, 0, -10]) color([0,0,0]) cylinder(r=7.5, h=60, center=false, $fn=60);
  }
}


//translate([0, 0, 43]) rotate([0, 180, 0]) #ballnut();

module ballnut_mount(height=20, peg=0){
  if(peg > 0){
    translate([13.5, 13.5, height]) color([0,0,0]) cylinder(r=2.6, h=peg, center=false, $fn=60);
    translate([13.5, -13.5, height]) color([0,0,0]) cylinder(r=2.6, h=peg, center=false, $fn=60);
    translate([-13.5, -13.5, height]) color([0,0,0]) cylinder(r=2.6, h=peg, center=false, $fn=60);
    translate([-13.5, 13.5, height]) color([0,0,0]) cylinder(r=2.6, h=peg, center=false, $fn=60);
  }
  difference(){
    translate([0, 0, 0]) color([1,0,0]) cylinder(r=24, h=height, center=false, $fn=120);
    translate([-40, -25, -4]) color([1,0,0]) cube([20,50,height+5]);
    translate([20, -25, -4]) color([1,0,0]) cube([20,50,height+5]);
    translate([0, 0, -4]) color([0,1,0]) cylinder(r=14.75, h=height+5, center=false, $fn=120);
    //center hole
    translate([0, 19.5, -4]) color([0,0,0]) cylinder(r=2.8, h=height+5, center=false, $fn=60);
    translate([0, -19.5, -4]) color([0,0,0]) cylinder(r=2.8, h=height+5, center=false, $fn=60);
    if(peg == 0){
      translate([13.5, 13.5, -4]) color([0,0,0]) cylinder(r=2.8, h=height+5, center=false, $fn=60);
      translate([13.5, -13.5, -4]) color([0,0,0]) cylinder(r=2.8, h=height+5, center=false, $fn=60);
      translate([-13.5, -13.5, -4]) color([0,0,0]) cylinder(r=2.8, h=height+5, center=false, $fn=60);
      translate([-13.5, 13.5, -4]) color([0,0,0]) cylinder(r=2.8, h=height+5, center=false, $fn=60);
    }
    translate([2, -8, -4]) color([1,0,0]) cube([20,16,height+5]);
  }
}

module tabs(){
  for(y=[1,-1]){
    translate([17, 11*y, 0]) 
    union(){
      difference(){
        hull(){
          translate([-3, -3, 0]) cube([6,6,8]);
          translate([0, 10*y, 0]) cylinder(r=3, h=8, center=false, $fn=60);
          translate([-10, 10*y, 0]) cylinder(r=3, h=8, center=false, $fn=60);
        }
      }
      //translate([-2, 8*y, -9]) sphere(d=10, $fn=60);
    }
  }
}

module full_mount(){
difference(){
  union(){
    ballnut_mount(32, 5);
    tabs();
    translate([-20, -24, 0]) rotate([0, 270, 0]) 
    hull(){
      translate([6, 6, 0]) cylinder(r=6, h=7, center=false, $fn=60);
      translate([42, 6, 0]) cylinder(r=6, h=7, center=false, $fn=60);

      translate([6, 42, 0]) cylinder(r=6, h=7, center=false, $fn=60);
      translate([42, 42, 0]) cylinder(r=6, h=7, center=false, $fn=60);
    }
  }
  translate([-4, -25, 15]) cube([8.2,50,8]);

   // translate([-25, 15, 40]) color([1,0,0]) cube([15,15,15]);
  for(y=[1,-1]){
    translate([15, 19*y, 8]) cylinder(r=5, h=15, center=false, $fn=60);
    translate([15, 19*y, -5]) cylinder(r=2.4, h=15, center=false, $fn=60);
    translate([-22, 16*y, 40]) rotate([0, 90, 0]) fhex(8.2,5.5);
    translate([-22, 16*y, 8]) rotate([0, 90, 0]) fhex(8.2,5.5);
    translate([-35, 16*y, 40]) color([0,0,0]) rotate([0, 90, 0]) cylinder(r=2.2, h=15, center=false, $fn=60);
    translate([-35, 16*y, 8]) color([0,0,0]) rotate([0, 90, 0]) cylinder(r=2.2, h=15, center=false, $fn=60);
    hull(){
      translate([-20, 16*y, 8]) color([0,0,0]) rotate([0, 90, 0]) cylinder(r=5.5, h=8, center=false, $fn=60);
      translate([-20, 26*y, 8]) color([0,0,0]) rotate([0, 90, 0]) cylinder(r=5.5, h=8, center=false, $fn=60);
    }
 //   hull(){
 //     translate([3, 19*y, 5]) rotate([0, 90, 0]) cylinder(d=8, h=15, center=false, $fn=60);
 //     translate([3, 19*y, -5]) rotate([0, 90, 0]) cylinder(d=8, h=15, center=false, $fn=60);
 //   }
  }
}
}

module front_cover(){
  union(){
    difference(){
      union(){
        translate([20, -20, 5]) rotate([0, 90, 0]) 
        hull(){
          for(y=[1,-1]){
            translate([3.5*y, -3, 0]) cylinder(d=3, h=3, center=false, $fn=60);
            translate([3.5*y, 43, 0]) cylinder(d=3, h=3, center=false, $fn=60);
          }
        }
        hull(){
          for(y=[1,-1]){
            translate([22, 19*y, 5]) rotate([0, 90, 0]) cylinder(d=8, h=3, center=false, $fn=60);
          }
        }
      }
      for(y=[1,-1]){
        translate([15, 19*y, 5]) rotate([0, 90, 0]) cylinder(r=2.2, h=15, center=false, $fn=60);
      }
    }
    intersection(){
      difference(){
        translate([25, 10, 5]) rotate([90, 0, 0]) cylinder(d=10, h=20, center=false, $fn=3);
        hull(){
          translate([24, -5, 2]) cylinder(d=6, h=6, center=false, $fn=60);
          translate([24, 5, 2]) cylinder(d=6, h=6, center=false, $fn=60);
        }
      }
      hull(){
        translate([25, -6, 2]) cylinder(d=6, h=6, center=false, $fn=60);
        translate([25, 6, 2]) cylinder(d=6, h=6, center=false, $fn=60);
      }
  
    }
  }
}

full_mount();
//translate([10, 0, 20]) rotate([0, 90, 0]) front_cover();

//translate([0, 0, -20]) rotate([0, -90, 0]) front_cover();



