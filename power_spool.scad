
include <NewBearing/bearing_test.scad>


main_diameter=35;
//inside_race(diameter=main_diameter, holes=holes, ball_dia=ball_dia,
//                    offset=-0.5, race_spacing=race_spacing, 
//                    race_width=race_width, race_height=race_height,
//                    bextra=bextra);
//outside_race(diameter=main_diameter, holes=holes, ball_dia=ball_dia,
//                    offset=+0.5, race_spacing=race_spacing, 
//                    race_width=race_width, race_height=race_height, 
//                    bextra=bextra);
//assembly();
tv_stand_mount();
module assembly(){

%cylinder(d=75.5,h=60);
%rotate([0,90,0]) strong_hero();
%cylinder(d=90,h=10);
}

module strong_hero(){
  difference(){
    union(){
      for(Z=[-1,1]) translate([0,0,28.5*Z]) 
        cylinder(d=200,h=3,center=true);
      cylinder(d=80,h=60,center=true);
    }
    cylinder(d=74.5,h=61,center=true);
  }
}

module tv_stand_mount(width=100){
  %for(X=[-1,1]) translate([100*X,0,0]) 
    cylinder(d=50,h=200,center=true);
  difference(){
    hull() for(X=[-1,1]){
      translate([width*X,0,0]) cylinder(d=60,h=10,center=true);
    }
    for(X=[-1,1]){
      translate([width*X,0,0]) cylinder(d=50,h=11,center=true);
      %translate([65*X,0,0]) rotate([90,0,0]) cylinder(d=5,h=100,center=true);
    }
  }
}