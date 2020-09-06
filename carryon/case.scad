
include <MCAD/boxes.scad>
include <MCAD/stepper.scad>

//roundedBox([285, 510, 42], 20, true);

printer();

module printer(){
//Upper half
translate([-200,0,215]) rotate([0,80,0]) %roundedBox([285, 510, 42], 20, true);
//translate([-200,0,215]) rotate([0,80,0]) %cube([285, 510, 42], center=true);


//Lower half
%roundedBox([285, 510, 155], 20, true);
//%roundedBox([285, 510, 155], 20, true);
//%cube([285, 510, 155], center=true);


fold_angle=0;
z_height=100;
translate([0,-210,20]) rotate([fold_angle*-1,0,0]) plate_box();
    
translate([0,-180, 76]) y_axis_holder();
    
//translate([0,0,20]) refill3d_spool();
    
//translate([0,0,90]) cube([200,500,6], center=true);
//translate([0,0,165+96]) %cube([200,450,330], center=true);

}

//y_axis_holder();

module y_axis_holder(){
translate([0,-72,-78]) cube([150,6,150], center=true);
translate([0,72,-78]) cube([150,6,150], center=true);
  difference(){
    cube([150, 150, 6], center=true);
    cylinder(d=23.5, h=6.2, center=true, $fn=60);
  }
  translate([0,0,-1]) rotate([180,0,0]) motor(Nema17, NemaMedium, dualAxis=false);
}

//belt_part(diameter=12, thickness=2, width=8, type=1);
module belt_part(length=400,diameter=12, thickness=2, width=8, type=1){
  difference(){
    hull(){
      translate([0,0,length]) rotate([-90,0,0]) cylinder(d=diameter+thickness, h=width, center=true);
      translate([0,0,0]) rotate([-90,0,0]) cylinder(d=diameter+thickness, h=width, center=true);
    }
    hull(){
      translate([0,0,length]) rotate([-90,0,0]) cylinder(d=diameter, h=width+0.1, center=true);
      translate([0,0,0]) rotate([-90,0,0]) cylinder(d=diameter, h=width+0.1, center=true);
    }
    if(type == 1){
      translate([(diameter+thickness)/2*-1,0,length/2]) 
        cube([diameter+thickness,width+0.1,length+diameter+thickness*2], center=true);
    }
    else if(type == 2){
      translate([(diameter+thickness)/2,0,length/2]) 
        cube([diameter+thickness,width+0.1,length+diameter+thickness*2], center=true);
    }
    else if(type == 3){
      translate([(diameter+thickness)/2*-1,0,length/2]) 
        cube([diameter+thickness,width+0.1,length+diameter+thickness*2], center=true);
      translate([0,0,length+(diameter/2)-2]) 
        cube([diameter+thickness,width+0.1,(diameter/2)+2], center=true);
    }
    else if(type == 4){
      translate([(diameter+thickness)/2,0,length/2]) 
        cube([diameter+thickness,width+0.1,length+diameter+thickness*2], center=true);
      translate([0,0,length+(diameter/2)-2]) 
        cube([diameter+thickness,width+0.1,(diameter/2)+2], center=true);
    }
  }
}

module right_belt(){
  translate([132,0,445]) rotate([0,-93.5,0]) belt_part(length=253,type=1);
  translate([132,0,45]) belt_part(length=400,type=1);
  translate([120,0,30]) rotate([0,40,0]) belt_part(length=20,type=1);
    
  translate([-120,-4,133]) cube([100,8,1]);
    
  translate([120,0,30]) rotate([0,25,0]) belt_part(length=30,type=4);
  translate([120,0,60]) belt_part(length=80,type=1);
    
  translate([-120,0,430]) rotate([0,180,0]) belt_part(length=290,type=1);
    
  translate([20,-4,146]) cube([100,8,1]);
}

module left_belt(){
  translate([-132,0,445]) rotate([0,93.5,0]) belt_part(length=253,type=2);
  translate([-132,0,45]) belt_part(length=400,type=2);
  translate([-120,0,30]) rotate([0,-40,0]) belt_part(length=20,type=2);
    
  translate([-120,-4,146]) cube([100,8,1]);
    
  translate([-120,0,30]) rotate([0,-25,0]) belt_part(length=30,type=3);
  translate([-120,0,60]) belt_part(length=80,type=2);
    
  translate([120,0,430]) rotate([0,180,0]) belt_part(length=290,type=2);
    
  translate([20,-4,133]) cube([100,8,1]);
}

module belt(){
  translate([0,30,0]) color("blue") right_belt();
  translate([0,44,0]) color("red") left_belt();
    
//  difference(){
//    hull(){
//      translate([132,35,445]) rotate([-90,0,0]) cylinder(d=14, h=8, center=true);
//      translate([132,35,45]) rotate([-90,0,0]) cylinder(d=14, h=8, center=true);
//    }
//    hull(){
//      translate([132,35,445]) rotate([-90,0,0]) cylinder(d=12, h=8.1, center=true);
//      translate([132,35,45]) rotate([-90,0,0]) cylinder(d=12, h=8.1, center=true);
//    }
//    translate([122,30,30]) cube([10,10,430]);
//  }
//  difference(){
//    hull(){
//      translate([132,35,45]) rotate([-90,0,0]) cylinder(d=14, h=8, center=true);
//      translate([120,35,30]) rotate([-90,0,0]) cylinder(d=14, h=8, center=true);
//    }
//    hull(){
//      translate([132,35,45]) rotate([-90,0,0]) cylinder(d=12, h=8.1, center=true);
//      translate([120,35,30]) rotate([-90,0,0]) cylinder(d=12, h=8.1, center=true);
//    }
//  }
}

module plate_box(){
  
  translate([132,35,445]) rotate([-90,0,0]) color("silver") 16tooth_pully();
  translate([-132,35,445]) rotate([-90,0,0]) color("silver") 16tooth_pully();
    
    
  translate([132,35,45]) rotate([-90,0,0]) color("silver") 16tooth_pully();
  translate([-132,35,45]) rotate([-90,0,0]) color("silver") 16tooth_pully();
    
  translate([120,35,60]) rotate([-90,0,0]) color("silver") 16tooth_pully();
  translate([-120,35,60]) rotate([-90,0,0]) color("silver") 16tooth_pully();
    
  translate([120,35,430]) rotate([-90,0,0]) color("silver") 16tooth_pully();
  translate([-120,35,430]) rotate([-90,0,0]) color("silver") 16tooth_pully();
    
  
  translate([100,0,270]) cylinder(d=12, h=350, center=true);
  translate([-100,0,270]) cylinder(d=12, h=350, center=true);
  translate([0,0,0]) rotate([0,90,0]) cylinder(d=12, h=400, center=true);
  
  translate([0,20,220]) rotate([90,0,0]) main_plate();  
   
  translate([120,20,30]) rotate([90,0,0]) motor(Nema17, NemaMedium, dualAxis=false);
  translate([-120,20,30]) rotate([90,0,0]) motor(Nema17, NemaMedium, dualAxis=false);
    
  translate([120,35,30]) rotate([-90,0,0]) color("silver") 16tooth_pully();
  translate([-120,35,30]) rotate([-90,0,0]) color("silver") 16tooth_pully();
  
  
  // Max = 410, Min = 140
  translate([120,30,140]) move_plate();
  translate([-120,30,140]) move_plate();
  
  belt();
}

module move_plate(){
  
  translate([0,12,0]) rotate([90,0,0]) color("silver") 16tooth_pully();
//  translate([-10,12,-10]) rotate([90,0,0]) color("silver") 16tooth_pully();
  rotate([90,0,0]) roundedBox([40, 40, 6], 10, true);
}



module main_plate(){
  color("black")
  difference(){
    roundedBox([280, 465, 6], 10, true);
    translate([0,-10,0]) roundedBox([210, 420, 6.2], 10, true);
  }
//    roundedBox([285, 510, 155], 20, true);
}


module 16tooth_pully(){
  difference(){
    difference(){
      cylinder(d=16, h=16, center=true, $fn=30);
      translate([0,0,-0.1]) cylinder(d=8, h=16.3, center=true, $fn=30);
    }
    translate([0,0,3.25]) difference(){
      cylinder(d=18, h=7, center=true, $fn=30);
      translate([0,0,-0.1]) cylinder(d=12.4, h=7.3, center=true, $fn=30);
    }
  }
}

module refill3d_spool(){
  color("white")
  difference(){
    union(){
      translate([0,0,-45]) cylinder(d=160, h=3.0, $fn=360, center=true);
      translate([0,0,0]) cylinder(d=50, h=90, $fn=360, center=true);
      translate([0,0,45]) cylinder(d=160, h=3.0, $fn=360, center=true);
    }
    translate([0,0,0]) cylinder(d=32, h=93.2, $fn=360, center=true);
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
