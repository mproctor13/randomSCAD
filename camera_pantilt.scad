

internal_width=150;
mount_length=110;
use <NewBearing/bearing_test.scad>;
//ball_size=6;
race_width=3;
race_height=8;
ball_dia=3.5;
main_diameter=10;

//translate([0,0,1.5]) mag_mount();
//as_inner_test();
as_outer_test();
//test_foot();

//difference(){
//as5600_mount();0
//    cube(30);
//}
module as5600_mount(){
  translate([0,0,0]) %as5600_board();
//  translate([0,0,-2]) cylinder(d=22,h=1);
    as_inner_test();
    as_outer_test();
}

module mag_mount(type=1){
  difference(){
    mount_plug();
    if(type==1){
      translate([0,0,1.5]) hull(){
        rotate([0,90,0]) cylinder(d=3.2, h=10, $fn=120, center=true);
        translate([0,0,-4]) cube([10,3,0.1], center=true);
      }
    }
    else{
      cylinder(d=6.35, h=3.175, $fn=120);
    }
  }
}

module mount_plug(){
  cylinder(d=15-0.2, h=2, $fn=8);
  cylinder(d=11, h=4, $fn=60);
}

module test_foot(){
  difference(){
    cylinder(d=30, h=4, center=true, $fn=60);
    translate([0,0,1]) cylinder(d=26.2, h=4, center=true, $fn=12);
    translate([0,0,1]) cube([8,100,4], center=true);
  }
  for(X=[-1,1]) translate([6*X,0,-1.5]) cylinder(d=2,h=2, $fn=60);
}

module as_inner_test(){
  difference(){
    inside_race(diameter=main_diameter, 
                holes=0, offset=-1.5, 
                ball_dia=ball_dia,
                race_width=race_width+3, 
                race_height=race_height);  
    cylinder(d=15, h=4, $fn=8);
    cylinder(d=12, h=20, $fn=60);
  }
}

module as_outer_test(){
  intersection(){
    difference(){
      union(){
        outside_race(diameter=main_diameter, 
                        holes=0, offset=3, 
                        ball_dia=ball_dia, 
                        race_width=race_width, 
                        race_height=11);
//        translate([0,0,-1]) cylinder(d=25, h=1, center=true, $fn=12);
//        for(X=[-1,1]) translate([6*X,0,-1.5]) cylinder(d=2,h=2, $fn=60);
      }
      translate([0,0,-3]) rotate([0,90,90]) 
        cylinder(d=8, h=40, center=true, $fn=6);
    }
    cylinder(d=26, h=40, center=true, $fn=12);
  }
}

module as5600_board(){
  intersection(){
    difference(){
      cylinder(d=18,h=1);
      for(X=[-1,1]) translate([6*X,0,-1]) cylinder(d=2.2,h=3, $fn=60);
    }
    cube([15,16,4], center=true);
  }
}



