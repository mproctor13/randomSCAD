include <vslot.scad>
include <MCAD/shapes.scad>
include <slot_fill.scad>
include <gimbal.scad>


delta_radiusb=135;
beam_lengthb=240;
beam_heightb=635;

module fhex(wid,height){
  hull(){
    cube([wid/1.7,wid,height],center=true);
    rotate([0,0,120]) cube([wid/1.7,wid,height], center=true);
    rotate([0,0,240]) cube([wid/1.7,wid,height], center=true);
  }
}

module belts(){
  color("black") difference(){
    hull(){
      translate([0, delta_radiusb+45, 25]) rotate([90, 0, 0]) cylinder(d=12.5, h=6, $fn=60);
      translate([0, delta_radiusb+45, beam_heightb]) rotate([90, 0, 0]) cylinder(d=12.5, h=6, $fn=60);
    }
    hull(){
      translate([0, delta_radiusb+46, 25]) rotate([90, 0, 0]) cylinder(d=10.5, h=8, $fn=60);
      translate([0, delta_radiusb+46, beam_heightb]) rotate([90, 0, 0]) cylinder(d=10.5, h=8, $fn=60);
    }
  }
}

module handle(){
  translate([23,-40,16.5]) linear_extrude(5) rotate([0,0,90]) text("MPS", 28);
  difference(){
    union(){
      hull(){
        translate([0, 60, 10]) rotate([90, 0, 0]) cylinder(d=20, h=120, $fn=120);
        translate([20, 60, 10]) rotate([90, 0, 0]) cylinder(d=20, h=120, $fn=120);
      }
      hull(){
        hull(){
          translate([0, 60, 10]) rotate([90, 0, 0]) cylinder(d=20, h=2, $fn=120);
          translate([20, 60, 10]) rotate([90, 0, 0]) cylinder(d=20, h=2, $fn=120);
        }
        hull(){
          translate([10, 70, 10]) rotate([90, 0, 90]) cylinder(d=20, h=60, $fn=120);
          translate([10, 90, 10]) rotate([90, 0, 90]) cylinder(d=20, h=60, $fn=120);
        }
      }
      hull(){
        hull(){
          translate([0, -60, 10]) rotate([90, 0, 0]) cylinder(d=20, h=2, $fn=120);
          translate([20, -60, 10]) rotate([90, 0, 0]) cylinder(d=20, h=2, $fn=120);
        }
        hull(){
          translate([10, -70, 10]) rotate([90, 0, 90]) cylinder(d=20, h=60, $fn=120);
          translate([10, -90, 10]) rotate([90, 0, 90]) cylinder(d=20, h=60, $fn=120);
        }
      }
    }
    for(Y=[-1,1]){
      translate([-20, 70*Y, 10]) rotate([90, 0, 90]) cylinder(d=5, h=100, $fn=60);
      translate([-20, 90*Y, 10]) rotate([90, 0, 90]) cylinder(d=5, h=100, $fn=60);
      
      translate([-35, 70*Y, 10]) rotate([90, 0, 90]) cylinder(d=12, h=100, $fn=60);
      translate([-35, 90*Y, 10]) rotate([90, 0, 90]) cylinder(d=12, h=100, $fn=60);
    }
  }
}

module fleks3d_ring(){
  difference(){
    cylinder(d=200, h=2.71, $fn=90);
    translate([0, 0, -0.1])  cylinder(d=184, h=3, $fn=90);
  }
}

module kossel_mini(){
  for (a = [0:120:360]) rotate([0, 0, a]){
    // Bottom Frame
    translate([-(beam_lengthb/2),-delta_radiusb+38,10]) rotate([0,90,0]) vslot20x20(beam_lengthb, vslot_color_black);
    translate([-(beam_lengthb/2),-delta_radiusb+38,50]) rotate([0,90,0]) vslot20x20(beam_lengthb, vslot_color_black);
    translate([0, delta_radiusb, 0]) rotate([0, 0, 180]) import("griffin/frame_motor_2020sw.STL");
    // uprights
//  rotate([0,0,30]) translate([-(beam_lengthb/2)-40,0,0]) vslot20x20(beam_heightb, vslot_color_black);
//  // Top Frame
//  translate([-(beam_lengthb/2),-delta_radiusb+38,beam_heightb-10]) rotate([0,90,0]) vslot20x20(beam_lengthb, vslot_color_black);
//  translate([0, delta_radiusb-4, beam_heightb]) rotate([0, 180, 180]) import("griffin/frame_top_2020sw.STL");
    
  // Stand
  rotate([0,0,-60]) translate([0,-160,2]) import("griffin/MiniKossel_2020_stand.stl");
//  belts();
      translate([0,-63,60]) kossel_bed_holder();
      translate([0,-104,74]) kossel_pindown();
  }
// glass plate
  translate([0, 0, 65])  %cylinder(d=200, h=2, $fn=90);
//  translate([0, 0, 67])  fleks3d_ring();
  
  // PI Mount
  rotate([0, 0, -120]){
    translate([-20,-125,25]) rotate([0,0,-90]) pi_strap();
    translate([20,-125,25]) rotate([0,0,-90]) pi_strap();
  }
  // Power Supply Mount
  rotate([0,0,120]){
    translate([95,-132,17]) rotate([0,90,90]) atx_mount_back();
    translate([35,-132,17]) rotate([0,90,90]) 1u_atx();
    translate([-53,-132,17]) rotate([0,90,90]) atx_mount_front();
  }
  // Filament & Camera Mount
  rotate([0,0,120]){
    translate([170,100,110]) rotate([0,90,30]) filament_spool();
    translate([170,100,350]) rotate([0,90,30]) filament_spool();
    translate([170,100,590]) rotate([0,90,30]) filament_spool();

    for(Z=[110,590]){
      translate([0,175,Z]) side_support();
      translate([0,175,Z]) support_arm();
      rotate([0,0,-120]) translate([0,175,Z]) rotate([180,0,180]) side_support();
      rotate([0,0,-120]) translate([0,175,Z]) rotate([180,0,180]) support_arm();
    }

    translate([133.5,77,150]) rotate([0,0,30]) end_spine();
    translate([133.5,77,250]) rotate([0,0,30]) cam_spine();
    translate([133.5,77,350]) rotate([0,0,30]) middle_spine();
    translate([133.5,77,450]) rotate([0,0,30]) support_spine();
    translate([133.5,77,550]) rotate([180,0,30]) end_spine();
  }
  
}

module kossel_bed_holder(){
  difference(){
    union(){
      translate([0, -41.5, 4]) cylinder(d=12, h=8, $fn=60, center=true);
      hull(){
        hull(){
          translate([-55, -39, 4]) cylinder(d=10, h=8, $fn=60, center=true);
          translate([55, -39, 4]) cylinder(d=10, h=8, $fn=60, center=true);
        }
        hull(){
          translate([40, -19, 4]) cylinder(d=4, h=8, $fn=60, center=true);
          translate([-40, -19, 4]) cylinder(d=4, h=8, $fn=60, center=true);
        }
      }
      hull(){
        hull(){
          translate([-58, -9, 4]) cylinder(d=4, h=8, $fn=60, center=true);
          translate([-40, -19, 4]) cylinder(d=4, h=8, $fn=60, center=true);
        }
        translate([-55, -39, 4]) cylinder(d=10, h=8, $fn=60, center=true);
      }

hull(){
hull(){
  translate([58, -9, 4]) cylinder(d=4, h=8, $fn=60, center=true);
  translate([40, -19, 4]) cylinder(d=4, h=8, $fn=60, center=true);
}
  translate([55, -39, 4]) cylinder(d=10, h=8, $fn=60, center=true);
}
  }
  translate([0, 63.5, 6]) cylinder(d=203, h=4.5, $fn=360, center=true);
  translate([0, 63, 2]) cylinder(d=180, h=5, $fn=360, center=true);
  translate([0, -41.5, 8]) cylinder(d=4, h=10, $fn=60, center=true);
  translate([0, -41.5, 1.3]) fhex(5.7,3);
  for(X=[-1,1]){
    hull(){
      translate([53*X, -30, 3]) cylinder(d=5.5, h=8, $fn=60, center=true);
      translate([53*X, -37, 3]) cylinder(d=5.5, h=8, $fn=60, center=true);
    }
  }
  for(X=[-1,1]){
    hull(){
      translate([53*X, -30, 8]) cylinder(d=10, h=4, $fn=60, center=true);
      translate([53*X, -37, 8]) cylinder(d=10, h=4, $fn=60, center=true);
    }
  }
}
}

module kossel_pi_base(){
  difference(){
    union(){
      hull(){
        translate([-50, -109.25, 10]) rotate([90,0,0]) cylinder(d=8, h=3, $fn=60, center=true);
        translate([-43.5, -109.25, 10]) cube([1,3,8], center=true);
      }
      hull(){
        translate([50, -109.25, 10]) rotate([90,0,0]) cylinder(d=8, h=3, $fn=60, center=true);
        translate([44.5, -109.25, 10]) cube([1,3,8], center=true);
      }
      hull(){
        translate([-50, -109.25, 50]) rotate([90,0,0]) cylinder(d=8, h=3, $fn=60, center=true);
        translate([-43.5, -109.25, 50]) cube([1,3,8], center=true);
      }
      hull(){
        translate([50, -109.25, 50]) rotate([90,0,0]) cylinder(d=8, h=3, $fn=60, center=true);
        translate([44.5, -109.25, 50]) cube([1,3,8], center=true);
      }
      translate([-42.5,-64,58]) rotate([90,0,0]) import("griffin/raspberry_case_bot.stl");
      translate([37.5, -110.8, 45.5]) rotate([90,30,0]) cylinder(d=6, h=0.5, $fn=60, center=true);
      translate([-17.5, -110.8, 20]) rotate([90,30,0]) cylinder(d=6, h=0.5, $fn=60, center=true);
    }
    for(X=[-50,50], Z=[10,50]){
      translate([X, -109.25, Z]) rotate([90,0,0]) cylinder(d=5, h=4, $fn=60, center=true);
    }
  }
}

module pi_strap(){
   
  translate([15.9, 0, -25]) rotate([90,0,0]) cylinder(d=4.3, h=15, $fn=60, center=true);
  translate([15.8, 0, 29]) rotate([90,0,0]) cylinder(d=4.3, h=15, $fn=60, center=true);
  difference(){
    union(){
      hull(){
        for(X=[-14,14], Z=[-32,32]){
          translate([X, 0, Z]) rotate([90,0,0])  cylinder(d=8, h=15, $fn=60, center=true);
        }
      }
      translate([-18, 0, -15.4]) rotate([90,0,0]) slot_fill(length=15);
      translate([-18, 0, 25.4]) rotate([90,0,0]) slot_fill(length=15);
    }
    hull(){
      for(X=[-1,1], Z=[-1,1]){
        translate([9.75*X, 0, 28*Z]) rotate([90,0,0])  cylinder(d=8, h=57, $fn=60, center=true);
      }
    }
    translate([15,-0.1,2]) cube([10,16,55],center=true);
    translate([-18, 0, -15]) rotate([0,90,0]) cylinder(d=5, h=10, $fn=60, center=true);
    translate([-18, 0, 25]) rotate([0,90,0]) cylinder(d=5, h=10, $fn=60, center=true);
  }
}

module side_support(){
  difference(){
    union(){
      translate([30, 0, 0])
      hull(){
        translate([-37.5, 0, 7.5]) rotate([90,0,0]) cylinder(d=5, h=10, $fn=60, center=true);
        translate([37.5, 0, 7.5]) rotate([90,0,0]) cylinder(d=5, h=10, $fn=60, center=true);
        translate([-37.5, 0, -7.5]) rotate([90,0,0]) cylinder(d=5, h=10, $fn=60, center=true);
        translate([37.5, 0, -7.5]) rotate([90,0,0]) cylinder(d=5, h=10, $fn=60, center=true);
      }
      translate([0, -5, 0]) rotate([0,0,90]) slot_fill(length=20);
    }
    translate([0, 1, 0]) rotate([90,0,0]) cylinder(d=5, h=30, $fn=60, center=true);
    translate([55, 5, 0]) rotate([90,0,0]) fhex(5.7,5);
    translate([55, 5, 0]) rotate([90,0,0]) cylinder(d=3.2, h=30, $fn=60, center=true);
    translate([65, 5, 0]) rotate([90,0,0]) fhex(5.7,5);
    translate([65, 5, 0]) rotate([90,0,0]) cylinder(d=3.2, h=30, $fn=60, center=true);
    
    translate([60, -2.51, 0]) cube([21,5,21],center=true);
  }
}

module support_arm(){
  difference(){
    union(){
      translate([60, -2.51, 0]) cube([22,5,20],center=true);
      translate([72.55, 0, 0]) cube([5,10,20],center=true);
      translate([116.5, -86.51, -10]) rotate([0,0,30]) cube([10,100,20]);
      translate([110, -79.4, 0]) rotate([0,0,30]) cube([18,5,20],center=true);
    }
    translate([55, 5, 0]) rotate([90,0,0]) cylinder(d=3.2, h=30, $fn=60, center=true);
    translate([65, 5, 0]) rotate([90,0,0]) cylinder(d=3.2, h=30, $fn=60, center=true);
    translate([59.55, 2.5, 0]) cube([21,5,21],center=true);
    translate([122, -87.5, 0]) rotate([0,0,30]) cube([21,21,21],center=true);
    
    
    translate([112, -90, -5]) rotate([90,0,30]) cylinder(d=3.2, h=30, $fn=60, center=true);
    translate([112, -90, 5]) rotate([90,0,30]) cylinder(d=3.2, h=30, $fn=60, center=true);
  }
}


module support_spine(){
  difference(){
    union(){
      cube([2,50,100],center=true);
      translate([-10, -22.5, 0]) cube([20,5,100],center=true);
      translate([-10, 22.5, 0]) cube([20,5,100],center=true);
    }
    for(Y=[20,-20], Z=[-45,-35, 35, 45]){
      translate([-14.6,Y,Z]) rotate([90,0,0]) cylinder(d=3.2, h=15, $fn=60, center=true);
      translate([-14.6,Y,Z]) rotate([90,0,0]) fhex(5.7,5);
    }
  }
}


module end_spine(){
  difference(){
    union(){
      support_spine();
      for(Y=[-1,1]){
        hull(){
          translate([5,0,-40]) cube([10,10,20],center=true);
          translate([0.5,20*Y,-40]) cube([1,10,20],center=true);
        }
      }
      hull(){
        translate([5,0,-40]) cube([10,10,20],center=true);
        translate([0.5,0,-15]) cube([1,10,10],center=true);
      }
    }
    translate([0,0,-40]) rotate([0,90,0]) cylinder(d=8, h=25, $fn=60, center=true);
  }
}


module middle_spine(){
  difference(){
    union(){
      support_spine();
      for(Y=[-1,1]){
        hull(){
          translate([5,0,0]) cube([10,10,20],center=true);
          translate([0.5,20*Y,0]) cube([1,10,20],center=true);
        }
      }
      for(Z=[-1,1]){
        hull(){
          translate([5,0,0]) cube([10,10,20],center=true);
          translate([0.5,0,25*Z]) cube([1,10,10],center=true);
        }
      }
    }
    translate([0,0,0]) rotate([0,90,0]) cylinder(d=8, h=25, $fn=60, center=true);
  }
}

module filament_spool(){
  color("black")
  difference(){
    union(){
      translate([0,0,-30]) cylinder(d=205, h=3.85, $fn=360, center=true);
      translate([0,0,0]) cylinder(d=90, h=64, $fn=360, center=true);
      translate([0,0,30]) cylinder(d=205, h=3.85, $fn=360, center=true);
    }
    translate([0,0,0]) cylinder(d=54, h=64.2, $fn=360, center=true);
  }
}

module link(){
  difference(){
    hull(){
      for(X=[-1,1]){
        translate([15*X,4.5,0]) cylinder(d=10, h=3, $fn=60, center=true);
      }
    }
    for(X=[-15,-5, 5, 15]){
      translate([X,4.5,0]) cylinder(d=3.2, h=15, $fn=60, center=true);
    }
  }
}

module tilt_wall(){
  difference(){
    hull(){
      for(X=[-1,1]){
        translate([15*X,4.5,0]) cylinder(d=10, h=4, $fn=60, center=true);
        translate([10*X,20,0]) cylinder(d=10, h=4, $fn=60, center=true);
      }
    }
    for(X=[-15,-5, 5, 15]){
      translate([X,4.5,0]) cylinder(d=3.2, h=15, $fn=60, center=true);
      translate([X,4.5,-2.5]) fhex(5.7,5);
    }
  }
}

module tilt_hole(){
  difference(){
    tilt_wall();
    translate([-6.2,18,-5]) cylinder(d=5, h=20);
  }
}

module tilt_servo(){
  difference(){
    tilt_wall();
    translate([0,17.8,6]) cube([23.6,11.6,20],center=true);
    translate([-13.9,17.8,-5]) cylinder(d=2, h=20);
    translate([14.3,17.8,-5]) cylinder(d=2, h=20);
  }
}

module cam_spine(){
  support_spine();
  translate([-12,-22,0]) rotate([0,90,90]) tilt_hole();
  translate([-12,22,0]) rotate([0,90,90]) tilt_servo();
}

module power_supply(){
  difference(){
    union(){
      translate([0,0,11.25]) cube([27,38,22.5], center=true);
      hull(){
        translate([0,24,0]) cylinder(d=8.5, h=2);
        translate([0,-24,0]) cylinder(d=8.5, h=2);
      }
    }
    for(Y=[-1,1]){
      hull(){
        translate([0,23.15*Y,-0.1]) cylinder(d=3.5, h=2.2);
        translate([0,30*Y,-0.1]) cylinder(d=3.5, h=2.2);
      }
    }
  }
}

module power_supply_mount(){
  difference(){
    union(){
      translate([10,-10,4]) rotate([0,90,0]) slot_fill(length=15);
      hull(){
        translate([7.5,-12,2]) cylinder(d=15, h=4, $fn=60, center=true);
        translate([12.5,-12,2]) cylinder(d=15, h=4, $fn=60, center=true);
        cube([20,120,4]);
      }
      translate([65,100,4]) rotate([0,90,-60]) slot_fill(length=40);
      hull(){
        translate([20,80,0]) cube([30,40,4]);
        translate([57,113,2]) cylinder(d=15, h=4, $fn=60, center=true);
        translate([72,87,2]) cylinder(d=15, h=4, $fn=60, center=true);
      }
    }
    translate([72,87,2]) cylinder(d=5, h=8, $fn=60, center=true);
    translate([57,113,2]) cylinder(d=5, h=8, $fn=60, center=true);
    translate([10,-10,2]) cylinder(d=5, h=8, $fn=60, center=true);
    
    translate([14,33,2]) cylinder(d=3.4, h=8, $fn=60, center=true);
    translate([14,33,-1]) fhex(5.7,5);
    translate([14,81,2]) cylinder(d=3.4, h=8, $fn=60, center=true);
    translate([14,81,-1]) fhex(5.7,5);
  }
}

module 1u_atx(){
  //color("black")
  difference(){
    union(){
      color("white") cube([82,150,40], center=true);
      translate([26,-76,2.5]) cube([23.6,3.1,30.6], center=true);
    }
    // Fan hole
    translate([-20,-75,0]) rotate([90,0,0]) cylinder(d=39, h=2, $fn=60, center=true);
    
    // top bolt holes
    translate([-39.7+4.1,-75,-18.7+2.38]) rotate([90,0,0]) cylinder(d=2.5, h=8, $fn=60, center=true);
    translate([-39.7+4.1,-75,18.7-2.38]) rotate([90,0,0]) cylinder(d=2.5, h=8, $fn=60, center=true);
    
    // bottom bolt holes
    translate([39.7-14,-75,-18.7+2.06]) rotate([90,0,0]) cylinder(d=2.5, h=8, $fn=60, center=true);
    translate([39.7-3.38,-75,-18.7+2.38]) rotate([90,0,0]) cylinder(d=2.5, h=8, $fn=60, center=true);
  }
}

module atx_mount_back(){
  difference(){
    union(){
      cube([85,40,50], center=true);
      for(X=[-33, 7]){
        translate([X, 0, 24.95]) rotate([90,90,0]) slot_fill(length=40);
      }
    }
    translate([0,2.5+4,0]) cube([83,45,41], center=true);
    translate([26,-18,2.5]) cube([24.5,10,31.6], center=true);
    hull(){
      translate([3,-18,2.5]) cube([24.5,10,31.6], center=true);
      translate([-20,-18,0]) rotate([90,0,0]) cylinder(d=39, h=6, $fn=60, center=true);
    }
    // top bolt holes
    translate([-39.7+4.1,-18,-18.7+2.38]) rotate([90,0,0]) cylinder(d=4, h=8, $fn=60, center=true);
    translate([-39.7+4.1,-18,18.7-2.38]) rotate([90,0,0]) cylinder(d=4, h=8, $fn=60, center=true);
    
    // bottom bolt holes
    translate([39.7-14,-18,-18.7+2.06]) rotate([90,0,0]) cylinder(d=4, h=8, $fn=60, center=true);
    translate([39.7-3.38,-18,-18.7+2.38]) rotate([90,0,0]) cylinder(d=4, h=8, $fn=60, center=true);
    
    translate([16.2,-25,22]) cube([5,50,3.5]);
    for(X=[-33, 7], Y=[-10,15]){
      translate([X, Y, 25]) rotate([0,0,90]) cylinder(d=5, h=10, $fn=60, center=true);
      translate([X, Y, 21]) rotate([0,0,90]) cylinder(d=12, h=2, $fn=60, center=true);
        
      translate([X, Y, -21]) rotate([0,0,90]) cylinder(d=8, h=10, $fn=60, center=true);
    }
  }
}

module atx_mount_front(){
//  translate([-30,-8.4,15]) cube([21,3,11], center=true);
//  translate([30,-8.4,15]) cube([21,3,11], center=true);
  difference(){
    union(){
      translate([-12,8.4,-1.5]) rotate([48,0,0]) cube([26,61.5,3], center=true);
      translate([-26,10.05,0]) cube([2,40,50], center=true);
      translate([0,10.05,0]) cube([2,40,50], center=true);
  difference(){
    union(){
      cube([85,60,50], center=true);
      for(X=[-33, 7]){
        translate([X, 0, 24.95]) rotate([90,90,0]) slot_fill(length=60);
      }
    }
    translate([-13,2,20]) cube([24,50,20], center=true);
    translate([0,-20,0]) cube([83,20.2,41], center=true);
    
    translate([0,15,-4.5]) cube([79,50,50], center=true);
//    translate([0,10,-10]) cube([90,45,45], center=true);
    
    
    translate([16.2,-31,22]) cube([5,75,3.5]);
    for(X=[-33, 7], Y=[0,20]){
      translate([X, Y, 25]) rotate([0,0,90]) cylinder(d=5, h=10, $fn=60, center=true);
      translate([X, Y, 21]) rotate([0,0,90]) cylinder(d=12, h=2, $fn=60, center=true);
    }
  }
  }
    translate([0,27,-20]) rotate([48,0,0]) cube([100,80,50], center=true);
  }
}

kossel_mini();
//1u_atx();
//translate([0,90,0]) atx_mount_front();
//translate([0,0,40]) rotate([0,0,0]) filament_spool();
//translate([-40,0,-10]) rotate([0,-90,0]) end_spine();
//rotate([90,0,0]) atx_mount_front();
//translate([0,60,0]) atx_mount_front();
//atx_mount_back();

module spool_arm(){
difference(){
  union(){
    translate([0,0,6]) cylinder(d=20, h=8, $fn=60, center=true);
    hull(){
    //translate([0,0,8]) sphere(d=16,center=true);
  for(X=[-10,10], Y=[-10,10], Z=[2]){
    translate([X,Y,Z]) sphere(d=4,center=true);
  }
  for(X=[5,-5], Y=[120]){
    translate([X,Y,2]) sphere(d=4,center=true);
  }
  }
  hull(){
    translate([0,115,50]) sphere(d=12,center=true);
    translate([0,115,4]) cylinder(d=12, h=1, $fn=60, center=true);
  }
}
  translate([-40,0,-10]) rotate([0,-90,0]) end_spine();
  translate([0,0,1.5]) cylinder(d=8.01, h=4.2, $fn=60, center=true);
  translate([0,123,45]) rotate([90,0,0]) cylinder(d1=20, d2=13, h=10, $fn=60, center=true);
  translate([0,115,45]) rotate([90,0,0]) cylinder(d=5.5, h=20, $fn=60, center=true);
  translate([0,0,8.0]) fhex(13.2,8);
}
}
