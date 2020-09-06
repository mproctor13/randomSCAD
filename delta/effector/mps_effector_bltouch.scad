include <groove_mount.scad>;
include <configuration.scad>;

module fhex(wid,height){
  hull(){
    cube([wid/1.7,wid,height],center=true);
    rotate([0,0,120]) cube([wid/1.7,wid,height], center=true);
    rotate([0,0,240]) cube([wid/1.7,wid,height], center=true);
  }
}

module tabs(){
  for(y=[1,-1]){
    translate([17, 11*y, 0]) 
    union(){
      difference(){
        hull(){
          translate([-3, -3, 0]) cube([6,6,10]);
          translate([0, 12*y, 0]) cylinder(r=3, h=10, center=false, $fn=60);
          translate([-12, 12*y, 0]) cylinder(r=3, h=10, center=false, $fn=60);
        }
        translate([-10, 8*y, 5]) color([0,0,0]) rotate([0, 90, 0]) cylinder(r=2.2, h=15, center=false, $fn=60);
      }
      translate([12, 8*y, 5]) sphere(d=10, $fn=60);
      //translate([-8, 8*y, 5]) color([0,0,0]) rotate([0, 90, 0]) cylinder(r=2.2, h=15, center=false, $fn=60);
    }
  }
}

//PolyStroooder Tri Hotend mount hole shape
module mountHole() 
{
    union() 
    {
        hull() 
        {
            for (a = [90:120:360]) 
            {
                rotate([0, 0, a])
                translate([11.5, 0, 0])
                square([1, 5], center=true);
            }
        }
     
        for (a = [10:120:360]) 
        {
            rotate([0, 0, a]) 
            {
                translate([0, 11.7, 0])
                circle(r=1, center=true, $fn=15);
            }
            rotate([0, 0, a-20]) {
                translate([0, 11.7, 0])
                circle(r=1, center=true, $fn=15);
            }
        }
    }
}

module mount_tubes(){
  rotate([0,-90,0])
  union(){
    difference(){
      union(){
          for(y=[1,-1]){
            translate([22, 24.5*y, 5]) rotate([0, 90, 0]) cylinder(d=8, h=6, center=false, $fn=60);
          }
      }
      for(y=[1,-1]){
        translate([15, 24.5*y, 5]) rotate([0, 90, 0]) cylinder(r=2.5, h=15, center=false, $fn=60);
      }
    }
  }
}

module mps_effector(){
  for(z=[0,120,240]){
    rotate([0,0,z]){
      translate([30, 0, 0]) rotate([0,50,0]) translate([0, 0, -20]) mount_tubes();
    }
  }
  difference(){
    union(){
      difference(){
        hull(){
          for(z=[0,120,240]){
            rotate([0,0,z]){
              translate([22, -30, 6]) rotate([0, 50, 0]) cube([10,60,5]);
            }
          }
        } 
  
        hull(){
          for(z=[0,120,240]){
            rotate([0,0,z]){
              translate([21, -15, 3]) sphere(d=5, $fn=60);
              translate([21, -15, 25]) cylinder(d=5, h=5, $fn=60);
              translate([21, 15, 3]) sphere(d=5, $fn=60);
              translate([21, 15, 25]) cylinder(d=5, h=5, $fn=60);
            }
          }
        }
      }
    }
    translate([0, 0, -2]) rotate([0, 0, 30]) linear_extrude(h=5) mountHole();
    for(z=[0,120,240]){
      rotate([0,0,z]){
        for(y=[1,-1]){
          translate([14, -8, -5]) cylinder(d=3.3, h=15, $fn=60);
          translate([14, 8, -5]) cylinder(d=3.3, h=15, $fn=60);
          translate([22, 24.5*y, 0]) rotate([0, 50, 0]) cylinder(r=2.5, h=35, center=false, $fn=60);
          translate([12, 24.5*y, -8]) rotate([0, 50, 0]) cylinder(r=4.65, h=20, center=false, $fn=60);
            translate([25, 3*y, 2]) rotate([0, 50, 0]) cylinder(r=2, h=20, center=false, $fn=60);
            translate([17, 3*y, 5]) rotate([0, 90, 0]) cylinder(r=2, h=10, center=false, $fn=60);
        }
      }
    }
    translate([0, 0, -0.25]) cylinder(d=28, h=1.6, center=true, $fn=180);
    for(a = [0:120:360]){
      rotate([0,0,a]) translate([-35,0,0]) cylinder(d=3.2, h=20, center=true, $fn=60);
    }
    
    for(a = [0:120:360]){
      rotate([0,0,a]) translate([-30,3,11.4]) cylinder(d=3,2, h=10, center=true, $fn=60);
      rotate([0,0,a]) translate([-30,-3,11.4]) cylinder(d=3,2, h=10, center=true, $fn=60);
        
      rotate([0,0,a]) translate([-30,3,1]) fhex(5.7,10);
      rotate([0,0,a]) translate([-30,-3,1]) fhex(5.7,10);
    }
//    translate([-45,0,0]) cube([30,50,30], center=true);
  }
}

module mps_effector2(){
  difference(){
    union(){
      hull(){
        translate([25, 4.4, 27]) rotate([0,90,0]) cylinder(d=5, h=5, $fn=60);
        translate([25, -4.4, 27]) rotate([0,90,0]) cylinder(d=5, h=5, $fn=60);
        translate([27, -10, 22]) cube([5,5,1]);
        translate([27, 5, 22]) cube([5,5,1]);
      }
    }
    translate([23, 4.4, 27]) rotate([0,90,0]) cylinder(d=2.25, h=10, $fn=60);
    translate([23, -4.4, 27]) rotate([0,90,0]) cylinder(d=2.25, h=10, $fn=60);
  }
    
  difference(){
    union(){
      difference(){
        hull(){
          for(z=[0,120,240]){
            rotate([0,0,z]){
              translate([22, -30, 6]) rotate([0, 50, 0]) cube([10,60,5]);
            }
          }
        } 
  
        hull(){
          for(z=[0,120,240]){
            rotate([0,0,z]){
              translate([21, -20, -3]) cylinder(d=5, h=15, $fn=60);
              translate([21, 20, -3]) cylinder(d=5, h=15, $fn=60);
            }
          }
        }
      }
      translate([27, 5, 2]) cube([5,5,20]);
      translate([27, -10, 2]) cube([5,5,20]);
      translate([27, -10, 2]) cube([2,20,20]);
    }
//    translate([0, 0, -2]) rotate([0, 0, 30]) linear_extrude(h=5) mountHole();
    for(z=[0,120,240]){
      rotate([0,0,z]){
        for(y=[1,-1]){
          translate([22, 24.5*y, 0]) rotate([0, 50, 0]) translate([0,0,-10]) cylinder(r=2.5, h=35, center=false, $fn=60);
//          translate([12, 24.5*y, -8]) rotate([0, 50, 0]) %cylinder(r=4.65, h=20, center=false, $fn=60);
          translate([12, 24.5*y, -8]) rotate([0, 50, 0]) translate([0,0,-6]) cylinder(r=4.65, h=20, center=false, $fn=60);
          translate([25, 3*y, 2]) rotate([0, 50, 0]) cylinder(r=2, h=20, center=false, $fn=60);
          translate([17, 3*y, 5]) rotate([0, 90, 0]) cylinder(r=2, h=10, center=false, $fn=60);
        }
      }
    }
    translate([0, 0, -0.25]) cylinder(d=28, h=1.6, center=true, $fn=180);
    for(a = [0:120:360]){
      rotate([0,0,a]) translate([-35,0,0]) cylinder(d=3.2, h=20, center=true, $fn=60);
      hull(){
      rotate([0,0,a]) translate([-35,0,0]) cylinder(d=8, h=10, center=true, $fn=60);
      rotate([0,0,a]) translate([-25,0,0]) cube([10,10,10], center=true);
      }
    }
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

module poly_stoooder(){
  difference(){
    union(){
      translate([0, 0, 25]) cylinder(d=25, h=30, center=true, $fn=180);
      hull(){
        for(a = [90:120:360]){
          rotate([0, 0, a]) translate([11.5, 0, 5]) cube([1, 5, 10], center=true);
        }
      }
    }
    for(a = [90:120:360]){
      rotate([0, 90, a]) translate([-5, 0, 10]) cylinder(d=3.5, h=10, center=true, $fn=60);
      rotate([0, 0, a-60]) translate([-6, 0, 5]) cylinder(d=6.2, h=11, center=true, $fn=60);
      rotate([0, 0, a-60]) translate([-6, 0, 20]) cylinder(d=4.1, h=41, center=true, $fn=60);
    }
    difference(){
      translate([0, 0, 11.6+1.4]) cylinder(d=26, h=2.8, center=true, $fn=30);
      translate([0, 0, 11.6+1.41]) cylinder(d=16.5, h=2.82, center=true, $fn=60);
    }
    for(Z=[0,2.3,4.6,6.9,9.2,11.5,13.8,16.1,18.4,20.7]){
      translate([0,0,36-Z])
      difference(){
        translate([0,0,0.65]) cylinder(d=26, h=1.3, center=true, $fn=30);
        translate([0,0,0.65]) cylinder(d=10, h=1.32, center=true, $fn=60);
      }
    }
  }
}

module poly_stoooder_heads(){
    for(a = [90:120:360]){
      rotate([0, 0, a-60]) translate([-6, 0, 0]) fhex(7.9,2.25);
      rotate([0, 0, a-60]) translate([-6, 0, -3.6]) cylinder(d2=8, d1=0.2, h=5, center=true, $fn=60);
      rotate([0, 0, a-60]) translate([-11.2, 0, 5]) cylinder(d=19, h=8.85, center=true, $fn=60);
    }
}

module offsets(){
import("kossel_ball_carriage.stl");
translate([5.5,15,25]) cylinder(d=3, h=15, center=true, $fn=60);
translate([54.5,15,25]) cylinder(d=3, h=15, center=true, $fn=60);
    
    
}

module efferctor_top_internal(){
  difference(){
    union(){
      hull(){
        for(a = [0:120:360]){
          rotate([0,0,a-60]) translate([38,0,10.3]) cube([1,14,2], center=true);
        }
      }
      hull(){
        for(a = [0:120:360]){
          rotate([0,-25,a]) translate([28,0,14]) cube([1,30,30], center=true);
        }
        translate([0, 0, 22]) cylinder(d=28, h=35, center=true, $fn=180);
      }
      difference(){
        union(){
          translate([-30,6.5,18]) cube([17,1,15], center=true);
          translate([-30,-6.5,18]) cube([17,1,15], center=true);
          difference(){
            translate([-36,0,18]) cube([5,14,15], center=true);
            translate([-36,0,12]) rotate([0,90,0]) cylinder(d=13, h=8, center=true, $fn=60);
            translate([-38,10,23]) rotate([0,90,0]) cylinder(d=3, h=4, center=true, $fn=60);
            translate([-38,-10,23]) rotate([0,90,0]) cylinder(d=3, h=4, center=true, $fn=60);
          }
        }
        translate([-36,0,22]) rotate([90,0,90]) cylinder(d=3.5, h=10, center=true, $fn=60);
        
        translate([-37.1,-5,22.5]) rotate([90,0,90]) cylinder(d=2.8, h=3, center=true, $fn=60);
        translate([-37.1, 5,22.5]) rotate([90,0,90]) cylinder(d=2.8, h=3, center=true, $fn=60);
      }
      for(a = [0:120:360]){
        rotate([0,0,a]) translate([-31.5,0,12]) cube([14,14,4], center=true);
      }
    }
    translate([0, 0, 15.99]) cylinder(d=25.5, h=27, center=true, $fn=180);
    for(a = [0:120:360]){
      hull(){
        rotate([0,-25,a]) translate([28,0,12]) rotate([0,90,0]) cylinder(d=26, h=3, center=true, $fn=60);
        rotate([0,0,a]) translate([7,0,17]) cube([6,20,24], center=true);
      }
    }
    for(a = [0:120:360]){
      rotate([0,-25,a]) translate([30.6,0,14]) cube([5,35,35], center=true);
    }
    for(a = [90:120:360]){
      rotate([0, 0, a-30]) translate([-6, 0, 40]) cylinder(d=4.1, h=41, center=true, $fn=60);
    }
    for(a = [0:120:360]){
      rotate([0,0,a]) translate([-35,0,5]) cylinder(d=3,2, h=20, center=true, $fn=60);
      rotate([0,0,a]) translate([-35,0,13.5]) fhex(5.5,2.5);
      
      rotate([0,0,a]) translate([-30,3,5]) cylinder(d=3,2, h=20, center=true, $fn=60);
      rotate([0,0,a]) translate([-30,-3,5]) cylinder(d=3,2, h=20, center=true, $fn=60);
    }
  }
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

module effector_top(part=0){
  if(part==1){
    intersection(){
      efferctor_top_internal();
      translate([0,0,35]) cube([100,100,50],center=true);
    }
  }
  else if(part==2){
    difference(){
      efferctor_top_internal();
      translate([0,0,35]) cube([100,100,50],center=true);
    }
  }
  else{
    efferctor_top_internal();
    color([0,0,1])
    for(a = [90:120:360]){
      rotate([0, 0, a-30]) translate([-6, 0, 40]) cylinder(d=4.1, h=41, center=true, $fn=60);
    }
  }
}

module efferctor_top3(){
  difference(){
    union(){
      difference(){
        union(){
          translate([-30,6.5,18]) cube([11,1,15], center=true);
          translate([-30,-6.5,18]) cube([11,1,15], center=true);
          difference(){
            translate([-36,0,18]) cube([5,14,15], center=true);
            translate([-36,0,12]) rotate([0,90,0]) cylinder(d=13, h=8, center=true, $fn=60);
            translate([-38,10,23]) rotate([0,90,0]) cylinder(d=3, h=4, center=true, $fn=60);
            translate([-38,-10,23]) rotate([0,90,0]) cylinder(d=3, h=4, center=true, $fn=60);
          }
        }
        translate([-36,0,22]) rotate([90,0,90]) cylinder(d=3.5, h=10, center=true, $fn=60);
        
        translate([-37.1,-5,22.5]) rotate([90,0,90]) cylinder(d=2.8, h=3, center=true, $fn=60);
        translate([-37.1, 5,22.5]) rotate([90,0,90]) cylinder(d=2.8, h=3, center=true, $fn=60);
      }
      rotate([0,0,0]) translate([-31.5,0,11.5]) cube([14,14,4], center=true);
    }
    rotate([0,0,0]) translate([-35,0,5]) cylinder(d=3,2, h=20, center=true, $fn=60);
    rotate([0,0,0]) translate([-35,0,13.5]) fhex(5.7,2.5);
      
    rotate([0,0,0]) translate([-30,3,5]) cylinder(d=3,2, h=20, center=true, $fn=60);
    rotate([0,0,0]) translate([-30,-3,5]) cylinder(d=3,2, h=20, center=true, $fn=60);
    translate([-25.8,0,21]) rotate([0,65,0]) cube([29,19,10], center=true);
  }
}

module fan_50x20_mount(){
  rotate([0,0,60]){
  difference(){
    union(){
      translate([0,0,15.7]) cylinder(d=30, h=26, center=true, $fn=60);
      hull(){
        translate([12,0,16.2]) cube([1,20,25], center=true);
        translate([25,0,24.2]) cube([1,20,25], center=true);
      }
      translate([27,0,24.2]) cube([4,20,25], center=true);
      hull(){
        translate([25.2,0,35]) cube([7.5,15,1], center=true);
        translate([25.2, 7.5, 40]) rotate([90,0,0]) cylinder(d=7.5, h=15, $fn=60);
      }
      hull(){
        translate([-9,0,25]) cube([1,25,7.5], center=true);
        translate([-26.5, 12.5, 25]) rotate([90,0,0]) cylinder(d=7.5, h=25, $fn=60);
      }
    }
    translate([0,0,15.6])  cylinder(d=25.2, h=28, center=true, $fn=60);
    hull(){
      translate([12,0,16.2]) cube([1,15.5,21], center=true);
      translate([25,0,24.2]) cube([1,15.5,21], center=true);
    }
    translate([27.5,0,24.2]) cube([5,15.5,21], center=true);
    translate([10,0,16.2]) cube([5,15.5,21], center=true);
    translate([-20,0,16.2]) cube([35,15.5,28], center=true);
    translate([25.2, 9.5, 40]) rotate([90,0,0]) cylinder(d=3.6, h=18, $fn=60);
    translate([-26.5, 13.5, 25]) rotate([90,0,0]) cylinder(d=3.6, h=27, $fn=60);
    
    translate([-26.5, 14.5, 25]) rotate([90,0,0]) cylinder(d=6, h=5, $fn=60);
    translate([-26.5, -12.5, 25]) rotate([90,0,0]) fhex(5.7,5);
//    translate([-26.5, 10, 25]) rotate([90,0,0]) %cylinder(d=3.2, h=22, $fn=60);
    
    for(z=[0,120,240]){
      rotate([0,0,z]){
        for(y=[1,-1]){
          translate([14, -8, 2]) cylinder(d=6, h=4, $fn=60);
          translate([14, 8, 2]) cylinder(d=6, h=4, $fn=60);
        }
      }
    }
  }
  } 
}

module fan_50x20_stay(length=23.5){
  difference(){
    hull(){
      translate([0,0,1]) cylinder(d=7, h=2.5, center=true, $fn=60);
      translate([length,0,1]) cylinder(d=7, h=2.5, center=true, $fn=60);
    }
    translate([0,0,0.9]) cylinder(d=3.6, h=3, center=true, $fn=60);
    translate([length,0,0.9]) cylinder(d=3.6, h=3, center=true, $fn=60);
  }
}

module stoooder_stack(){
  rotate([0,0,30]) grooveMount();
  translate([0,0,-10.9]) rotate([0,0,-30]) color("silver") poly_stoooder();
  translate([0,0,-22]) rotate([0,0,-30]) color("silver") poly_stoooder_heads();
}


module spring_top(){
  
  difference(){
    union(){
      for(z=[0,120,240]){
        rotate([0,0,z]){
          hull(){
            translate([-20,0,11.75]) rotate([0,0,30]) cylinder(d=10, h=5, center=true, $fn=6);
            translate([-36.5,0,11.75]) cube([5,8,5], center=true);
          }
        }
      }
      translate([0,0,10.75]) difference(){
        cylinder(d=40, h=3, center=true, $fn=60);
        translate([0,0,-0.1]) cylinder(d=26, h=5.3, center=true, $fn=60);
      }
      translate([20,0,10.5]) cube([10,15,2.5], center=true);
      hull(){
        translate([25.06,0,14]) cube([1,10,5], center=true);
        translate([20,0,14]) cylinder(d=5, h=5, center=true, $fn=60);
      }
      difference(){
        hull(){
          for(z=[0,120,240]){
            rotate([0,0,z]){
              translate([-36.5,0,10.5]) cube([5,14,2.5], center=true);
            }
          }
        } 
  
        hull(){
          for(z=[0,120,240]){
            rotate([0,0,z]){
              translate([21, -20, -3]) cylinder(d=5, h=15, $fn=60);
              translate([21, 20, -3]) cylinder(d=5, h=15, $fn=60);
            }
          }
        }
      }
    }
    translate([22,0,10.75]) cylinder(d=3.2, h=13, center=true, $fn=60);
    translate([22,0,10]) rotate([0,0,30]) fhex(5.7,3);
    translate([22,0,15.5]) rotate([0,0,30]) fhex(5.7,3);
    
    for(z=[0,120,240]){
      rotate([0,0,z]){
        translate([-14,8,10.75]) cylinder(d=3.2, h=13, center=true, $fn=60);
        translate([-14,-8,10.75]) cylinder(d=3.2, h=13, center=true, $fn=60);
        translate([-35,0,10]) cylinder(d=3.2, h=20, center=true, $fn=60);
      }
    }
  }
  translate([22,0,11.65]) cylinder(d=4, h=0.3, center=true, $fn=60);
}

module micro_switch(){
  difference(){
    union(){
      translate([-8.1,0,11]) color("silver") cube([0.45,3,4], center=true);
      translate([0,0,11]) color("silver") cube([0.45,3,4], center=true);
      translate([6.88,0,11]) color("silver") cube([0.45,3,4], center=true);
      translate([0,0,4.635]) color("black") cube([20,6.3,9.35], center=true);
    }
    translate([4.4,0,7]) rotate([90,0,0]) cylinder(d=2.25, h=10, center=true, $fn=60);
    translate([-4.4,0,7]) rotate([90,0,0]) cylinder(d=2.25, h=10, center=true, $fn=60);
  }
}

//fan_50x20_stay();
//rotate([0,0,-60]) fan_50x20_mount();
//rotate([0,180,-90]) translate([0,-50,-16]) color([1,1,1]) bltouch();
//
//effector_top(part=0);
//efferctor_top3();
//color([0.3,0.3,1]) 
//mps_effector2();
//      
//      
//translate([-50,0,17]) rotate([0,0,90]) bltouch_mount();
//  

//
////translate([-32.18,7.35,10]) cylinder(d=3,2, h=20, center=true, $fn=60);
////translate([-21.8,-7.35,10]) cylinder(d=3,2, h=20, center=true, $fn=60);
////
////rotate([0,180,-90]) translate([0,-27,-16]) rotate([0,0,-35]) color([1,1,1]) bltouch();
////translate([40,-30,0]) rotate([50,0,90]) import("kossel_ball_carriage.stl");

//translate([22,0,20]) rotate([0,0,90]) micro_switch();
//translate([0,0,12.5]) stoooder_stack();
spring_top();
mps_effector2();
      
      
