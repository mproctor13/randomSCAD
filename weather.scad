base_dia=60;
base_height=100;

//shell();

difference(){
    case();
    translate([0,0,-12]) cube([base_dia*2,base_dia*2,300]);
}

module case(){
//  translate([0,0,base_height+base_dia/2+13]) cube([95,95,5], center=true);
  translate([0,0,base_height+base_dia/2]) top_shell();
//  for(Z=[-8:20:base_height+base_dia/2])
  for(Z=[0:1:6])
    translate([0,0,-8+Z*20]) rotate([0,0,60*Z]) shell();
  translate([0,0,base_height-5]) outside();
  top();
  bottom();
//  translate([0,0,base_height+5]) fan();
  base_mount();
  translate([0,0,base_height+base_dia/2+10]) solar_top();
}

module solar_top(){
  hull(){
  translate([0,0,10]) cube([95,95,1], center=true);
  cube([125,125,0.3], center=true);
  }
}

module base_mount(thickness=3){
translate([0,0,-11]){
  difference(){
    union(){
      for(R=[0,120,240]) rotate([0,0,R]) 
        hull(){
          translate([0,base_dia-5,0]) 
            cylinder(d=10, h=thickness);
          cylinder(d=base_dia+20, h=thickness);
        }
      translate([0,0,5])
        cylinder(d1=base_dia+18, d2=base_dia, h=11);
      cylinder(d=base_dia+18, h=5);
    }
    difference(){
      union(){
        translate([0,0,-1])
          cylinder(d1=base_dia+18, d2=base_dia, h=11);
        cylinder(d=base_dia-1, h=20);
      }
      cylinder(d=base_dia-5, h=20);
      for(R=[15:45:360]) rotate([0,0,R]) cube([base_dia*2,1,100], center=true);
    }
    for(R=[0,120,240]) rotate([0,0,R]) 
      translate([0,base_dia-5,-5])
        cylinder(d=3.3, h=10,$fn=30);
    translate([0,0,11]) difference(){
      cylinder(d=base_dia+0.2, h=10);
//      cylinder(d=base_dia-2.2, h=10);
    }
  }
}
}

module shell(dia=base_dia, thickness=1){
//  %translate([0,0,0]) cube([100,20,5]);
  difference(){
  rotate_extrude() 
  union(){
    translate([dia+10, 0, 0]){
      difference(){
        intersection(){
          circle(d=20);
          square([20,20]);
        }
        translate([-thickness,-thickness,0]) circle(d=20);
      }
    }
    translate([dia+10, 20-thickness, 0]){
      difference(){
        intersection(){
          circle(d=20);
          translate([-20,-20,0]) square([20,20]);
        }
        translate([thickness,thickness,0]) circle(d=20);
      }
    }
    translate([base_dia/2+10,20-thickness,0]) 
      square([dia+thickness-base_dia/2-10,thickness]);
    translate([base_dia/2+10,0,0]) 
      square([thickness,20]);
    translate([dia+20,0,0]) 
      rotate([0,0,180]) square([thickness, 5]);
    
  }
    for(R=[60,180,300]) rotate([0,0,R]) translate([0,dia-5,5])
      translate([0,0,10]) cylinder(d=3.3, h=10,$fn=30);
  }
  for(R=[0,120,240]) rotate([0,0,R]) translate([0,dia-5,0])
  difference(){
    cylinder(d1=6, d2=10, h=20);
    translate([0,0,-1]) cylinder(d=2.85, h=10,$fn=30);
  }
}

module top_shell(dia=base_dia, thickness=1){
  rotate_extrude() 
  union(){
    translate([dia+10, 0, 0]){
      difference(){
        intersection(){
          circle(d=20);
          square([20,20]);
        }
        translate([-thickness,-thickness,0]) circle(d=20);
      }
    }
    translate([0,10-thickness,0]) 
      square([dia+10,thickness]);
    translate([dia+20,0,0]) 
      rotate([0,0,180]) square([thickness, 5]);
    
  }
  for(R=[0,120,240]) rotate([0,0,R]) translate([0,dia-5,0])
  difference(){
    cylinder(d1=6, d2=10, h=10);
    translate([0,0,-1]) cylinder(d=2.85, h=10,$fn=30);
  }
}

module outside(){
  difference(){
    intersection(){
      sphere(d=base_dia+6);
      cylinder(d=base_dia+6, h=base_dia+6);
    }
    difference(){
      intersection(){
        sphere(d=base_dia+4);
        translate([0,0,-0.1]) cylinder(d=base_dia+4, h=base_dia+4);
      }
      for(R=[0,90,180,270])
      rotate([0,0,R]) translate([20,0,5]) difference(){
        cylinder(d=6,h=100);
        translate([0,0,-1]) cylinder(d=2.85,h=10,$fn=30);
      }
    }
  }
  translate([0,0,-base_height+10]) difference(){
    cylinder(d=base_dia+6, h=base_height-10);
    cylinder(d=base_dia+4, h=base_height+1);
  }
}

module top(){
  difference(){
    cylinder(d=base_dia, h=base_height);
    translate([0,0,-1.5]) difference(){
      cylinder(d=base_dia-2, h=base_height);
      translate([0,0,-0.5]) cylinder(d=base_dia-9, h=base_height+1);
      translate([0,0,base_height-1]) for(R=[0,60,120]) rotate([0,0,R]) cube([base_dia,1,5], center=true);
    }
    cylinder(d=base_dia-2, h=5);
    translate([0,0,-0.5]) cylinder(d=base_dia-11, h=base_height-1);
    translate([0,0,base_height-2]) cylinder(d=30, h=4);
    
    for(R=[0,90,180,270]) rotate([0,0,R]) 
      translate([20,0,base_height-4]) cylinder(d=3.3,h=5,$fn=30);
  }
}


module bottom(){
  difference(){
    cylinder(d=base_dia-5, h=base_height-5);
    translate([0,0,1]) cylinder(d=base_dia-6, h=base_height+1);
  }
}

module fan(){
  cube([30,30,7],center=true);  
}