

module fhex(wid,height){
  hull(){
    cube([wid/1.7,wid,height],center=true);
    rotate([0,0,120]) cube([wid/1.7,wid,height], center=true);
    rotate([0,0,240]) cube([wid/1.7,wid,height], center=true);
  }
}

module mps_carriage(){
  difference(){
    union(){
      hull(){
        cylinder(d=50, h=10, $fn=60);
        translate([-25,50,0]) cube([50,1,10]);
      }
      // middle cone
      translate([-15,20,-12]) cylinder(d1=8, d2=14, h=12, $fn=60);
      // bottom cone
      translate([16,-5,-12]) cylinder(d1=8, d2=14, h=12, $fn=60);
      // top cone
      translate([16,43,-12]) cylinder(d1=8, d2=14, h=12, $fn=60);
    }
    hull(){
      translate([0,-6,-0.5]) cylinder(d=16, h=11, $fn=60);
      translate([0,3,-0.5]) cylinder(d=16, h=11, $fn=60);
    }
    translate([-8,0,-0.5]) cube([14,30,11]);
    
    translate([-15,20,-15.5]) cylinder(d=6, h=20, $fn=60);
    translate([-15,20,5]) cylinder(d=11, h=11, $fn=60);
    
    translate([16,-5,-15.5]) cylinder(d=6, h=20, $fn=60);
    translate([16,-5,5]) cylinder(d=11, h=11, $fn=60);
    
    translate([16,43,-15.5]) cylinder(d=6, h=20, $fn=60);
    translate([16,43,5]) cylinder(d=11, h=11, $fn=60);
    
    // Cutout
//    translate([-36,38,-0.5]) cube([20,2,11]);
    translate([-18,29,-0.5]) cube([4,25,11]);
    translate([-18,28,-0.5]) cube([20,2,11]);
    
    // Tensioner
    translate([-26,45,5]) rotate([0,90,0]) cylinder(d=3.2, h=20, $fn=60);
//    translate([-12,42,1]) %cube([3,5.7,11]);
    translate([-12,41.8,1]) cube([3,6.1,11]);
    
    // mount holes
    translate([-10,35,2]) cylinder(d=3.2, h=10, $fn=60);
    translate([-10,35,1]) rotate([0,0,30]) fhex(5.7,5);
    
    translate([10,35,2]) cylinder(d=3.2, h=10, $fn=60);
    translate([10,35,1]) rotate([0,0,30]) fhex(5.7,5);
    
    translate([10,15,2]) cylinder(d=3.2, h=10, $fn=60);
    translate([10,15,1]) rotate([0,0,30]) fhex(5.7,5);
    
    // end stop screw
    translate([0,52,5]) rotate([90,0,0]) cylinder(d=3.1, h=15, $fn=8);
    
//    translate([15,10,-1]) cube([100,100,20]);
  }
  
}

module gt2_belt(length=12.9, width=8){
  translate([0.2,0,0]) cube([1,length,width]);
  for(X = [1:2:length]){
    translate([-1,X,0]) cube([1.3,1.3,width]);
  }
}

module mps_ballmount(){
  difference(){
    union(){
      translate([0,-22.5,0]) 
      hull(){
        for(X=[-1,1], Y=[-1,1]){
          translate([11*X,20*Y,0]) cylinder(d=5, h=14.9, $fn=60);
        }
      }
      hull(){
        translate([0,-15,12]) rotate([60,0,0]) 
        difference(){
          hull(){
            translate([-24.5,0,0]) cylinder(d=10, h=5, $fn=60);
            translate([24.5,0,0]) cylinder(d=10, h=5, $fn=60);
          }
          translate([-24.5,0,-1]) cylinder(d=4.6, h=8, $fn=60);
          translate([24.5,0,-1]) cylinder(d=4.6, h=8, $fn=60);
        }
    
        hull(){
          translate([-8,-15,0]) cylinder(d=10, h=5, $fn=60);
          translate([8,-15,0]) cylinder(d=10, h=5, $fn=60);
        }
      }
    }
    translate([6,1.5,15.1]) rotate([180,0,0]) gt2_belt(length=12.9,width=10);
    translate([0,-15,12]) rotate([60,0,0]) {
      translate([-24.5,0,-5]) cylinder(d=4.6, h=20, $fn=60);
      translate([24.5,0,-5]) cylinder(d=4.6, h=20, $fn=60);
      
      translate([-24.5,0,-10]) cylinder(d=11, h=10, $fn=60);
      translate([24.5,0,-10]) cylinder(d=11, h=10, $fn=60);
    }
    translate([-5,-21,10]) cube([4,50,10],center=true);
  
    translate([4,-40,10]) cube([12.5,40,10],center=true);
  
  
    // mount holes
    translate([-10,-8,-2]) cylinder(d=3.2, h=20, $fn=60);
    translate([-10,-8,8]) cylinder(d=6, h=15, $fn=60);
    
    translate([10,-8,-2]) cylinder(d=3.2, h=20, $fn=60);
    translate([10,-8,8]) cylinder(d=6, h=15, $fn=60);
    
    translate([10,-28,-2]) cylinder(d=3.2, h=20, $fn=60);
    translate([10,-28,1]) cylinder(d=6, h=15, $fn=60);
    
    translate([-10,-28,-2]) cylinder(d=3.2, h=20, $fn=60);
    translate([-10,-28,1]) cylinder(d=6, h=15, $fn=60);
  
     // Tensioner screw
    translate([1,1,12.75]) rotate([90,0,0]) cylinder(d=3.8, h=45, $fn=60);
    translate([1,1,12.75]) rotate([90,0,0]) cylinder(d=6, h=15, $fn=60);
    
    // end stop screw
    translate([0,1,5]) rotate([90,0,0]) cylinder(d=3.1, h=15, $fn=8);
  }
}



module mps_ballmount2(){
  difference(){
    union(){
      translate([0,-22.5,0]) 
      hull(){
        for(X=[-1,1], Y=[-1,1]){
          translate([14*X,20*Y,0]) cylinder(d=5, h=14.9, $fn=60);
        }
      }
      hull(){
        translate([0,-15,12]) rotate([60,0,0]) 
        difference(){
          hull(){
            translate([-24.5,0,0]) cylinder(d=10, h=5, $fn=60);
            translate([24.5,0,0]) cylinder(d=10, h=5, $fn=60);
          }
          translate([-24.5,0,-1]) cylinder(d=4.6, h=8, $fn=60);
          translate([24.5,0,-1]) cylinder(d=4.6, h=8, $fn=60);
        }
    
        hull(){
          translate([-8,-15,0]) cylinder(d=10, h=5, $fn=60);
          translate([8,-15,0]) cylinder(d=10, h=5, $fn=60);
        }
      }
    }
    translate([0,-15,12]) rotate([60,0,0]) {
      translate([-24.5,0,-5]) cylinder(d=4.6, h=20, $fn=60);
      translate([24.5,0,-5]) cylinder(d=4.6, h=20, $fn=60);
      
      translate([-24.5,0,-10]) cylinder(d=11, h=10, $fn=60);
      translate([24.5,0,-10]) cylinder(d=11, h=10, $fn=60);
    }
    translate([-5,-21,10]) cube([4,50,10],center=true);
  
    translate([5.5,-40,10]) cube([15.5,40,10],center=true);
  
  
    // mount holes
    translate([-10,-8,-2]) cylinder(d=3.2, h=20, $fn=60);
//    translate([-10,-8,8]) cylinder(d=6, h=15, $fn=60);
    
    translate([10,-8,-2]) cylinder(d=3.2, h=20, $fn=60);
    translate([6,1.5,15.1]) rotate([180,0,0]) gt2_belt(length=12.9,width=10);
    translate([8.2,-5.3,15.1]) rotate([0,180,0]) gt2_belt(length=6.9,width=10);
    difference(){
      translate([10,-8,5]) cylinder(d=9.0, h=15, $fn=60);
      translate([10,-8,5]) cylinder(d=6, h=15, $fn=60);
      translate([5.3,-5,12.5]) cube([2,10,15],center=true);
    }
    
    translate([10,-28,-2]) cylinder(d=3.2, h=20, $fn=60);
    translate([10,-28,1]) cylinder(d=6, h=15, $fn=60);
    
    translate([-10,-28,-2]) cylinder(d=3.2, h=20, $fn=60);
//    translate([-10,-28,1]) cylinder(d=6, h=15, $fn=60);
    translate([-10,-28,1.5]) rotate([0,0,30]) fhex(5.7,5);
  
     // Tensioner screw
    translate([1,1,12.75]) rotate([90,0,0]) cylinder(d=3.8, h=45, $fn=60);
    translate([1,1,12.75]) rotate([90,0,0]) cylinder(d=6, h=15, $fn=60);
    
    // end stop screw
    translate([0,1,5]) rotate([90,0,0]) cylinder(d=3.1, h=15, $fn=8);
  }
}

module mps_ballmount2_top(){
  difference(){
    union(){
      translate([0,-22.5,15]) 
      hull(){
        for(X=[-1,1], Y=[-1,1]){
          translate([14*X,20*Y,0]) cylinder(d=5, h=0.6, $fn=60);
        }
        for(X=[-1,1], Y=[-1,1]){
          translate([12*X,18*Y,5]) sphere(d=5, $fn=60);
        }
      }
    }
  
    translate([5.5,-40,13]) cube([15.5,40,10],center=true);
      translate([0,0,1]) hull(){
        translate([0,-15,12]) rotate([60,0,0]) 
         translate([-20,-5,0]) cube([40,10,5]);
    
        hull(){
          translate([-8,-15,0]) cylinder(d=10, h=5, $fn=60);
          translate([8,-15,0]) cylinder(d=10, h=5, $fn=60);
        }
      }
  
    // mount holes
    translate([-10,-8,12.8]) cylinder(d=3.2, h=5, $fn=60);
    translate([-10,-8,18]) cylinder(d=6, h=10, $fn=60);
    
    translate([10,-8,12.8]) cylinder(d=3.2, h=5, $fn=60);
    translate([10,-8,18]) cylinder(d=6, h=10, $fn=60);
    
    translate([-10,-28,12.8]) cylinder(d=3.2, h=5, $fn=60);
    translate([-10,-28,18]) cylinder(d=6, h=10, $fn=60);
  
     // Tensioner screw
    translate([1,1,12.75]) rotate([90,0,0]) cylinder(d=6, h=15, $fn=60);
    
    // label
    translate([-12,-22.5,20]) linear_extrude(10) text("MPS", 8);
  }
}

module test_module(){
  difference(){
    translate([3,-20,0]) cube([10,20,15]);
    translate([6,1.5,15.1]) rotate([180,0,0]) gt2_belt(length=12.9,width=10);
    translate([8.2,-5.3,15.1]) rotate([0,180,0]) gt2_belt(length=6.9,width=10);
    difference(){
      translate([10,-8,5]) cylinder(d=8.8, h=15, $fn=60);
      translate([10,-8,5]) cylinder(d=6, h=15, $fn=60);
      translate([5.3,-5,12.5]) cube([2,10,15],center=true);
    }
  }
}

module mps_belt_tensioner2(){
  difference(){
    translate([0,0,0]) cube([15,12,12]);
      
    translate([8,-0.2,-0.1]) gt2_belt(length=15.9);
    translate([12,13.1,-0.1]) rotate([0,0,180]) gt2_belt(length=15.9);
    translate([3.5,18,7.75]) rotate([90,0,0]) cylinder(d=3.8, h=45, $fn=60);
    translate([3.5,2,7.75]) rotate([90,30,0]) fhex(5.7,5);
  }
}

module mps_belt_tensioner(){
  difference(){
    translate([0,0,0]) cube([12,12,12]);
    translate([8,-0.2,0]) gt2_belt(length=15.9);
    translate([3.5,18,7.75]) rotate([90,0,0]) cylinder(d=3.8, h=45, $fn=60);
    translate([3.5,2,7.75]) rotate([90,30,0]) fhex(5.7,5);
  }
}

module full_carriage(){
  translate([0,-43,-10.1]) mps_carriage();
  translate([-1.9,-45,5.3]) mps_belt_tensioner();
  mps_ballmount2();
  mps_ballmount2_top();
}
//full_carriage();

//Output oriantation
//rotate([0,180,0]) mps_carriage();

//rotate([0,180,0]) mps_belt_tensioner2();

//mps_ballmount2();
//rotate([0,180,0]) mps_ballmount2_top();

//test_module();
//translate([-1.9,-45,5.3]) mps_belt_tensioner2();