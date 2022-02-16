bextra=0.2;
ball_dia=5.91;
$fn=120;
main_diameter=75;
race_spacing=0.5;
race_width=10;
race_height=10;
holes=24;
hole_diameter=3;

//cutout_race();
//difference(){
//  union(){
//    inside_race();
//    outside_race();
//  }
//  cube(100);
//}

module inside_race(diameter=main_diameter, holes=holes, ball_dia=ball_dia,
                    offset=-0.5, race_spacing=race_spacing, 
                    race_width=race_width, race_height=race_height,
                    bextra=bextra){
  translate([0,0,-offset])
  difference(){
  rotate_extrude()
    translate([diameter-race_width+race_spacing,0,0]) 
      difference(){
        square([race_width-race_spacing,race_height]);
        translate([race_width-race_spacing,race_height/2+offset,0]) 
          circle(d=ball_dia+bextra);
      }
    translate([0,diameter,race_height/2+offset]){
      cylinder(d=ball_dia+bextra, h=race_height/2+abs(offset));
      cylinder(d=ball_dia/2, h=race_height+2, center=true);
    }
    if(holes > 0)
      for(R=[0:360/holes:360]) rotate([0,0,R])
        translate([0,diameter-ball_dia/2-(race_width-ball_dia/2)/2,-0.5]) 
          cylinder(d=hole_diameter, h=race_height+1);
  }
}

module outside_race(diameter=main_diameter, holes=holes, ball_dia=ball_dia,
                    offset=+0.5, race_spacing=race_spacing, 
                    race_width=race_width, race_height=race_height, 
                    bextra=bextra){
  translate([0,0,-offset])
  difference(){
    rotate_extrude()
      translate([diameter+race_spacing,0,0]) 
        difference(){
          square([race_width-race_spacing,race_height]);
          translate([-race_spacing,race_height/2+offset,0]) 
            circle(d=ball_dia+bextra);
        }
      translate([0,diameter,race_height/2+abs(offset)]){
        cylinder(d=ball_dia+bextra, h=race_height/2+offset);
        cylinder(d=ball_dia/2, h=race_height*2, center=true);
      }
      if(holes > 0)
        for(R=[0:360/holes:360]) rotate([0,0,R])
          translate([0,diameter+ball_dia/2+(race_width-ball_dia/2)/2,-0.5]) 
            cylinder(d=hole_diameter, h=race_height+1);
  }
}

module cutout_race(diameter=main_diameter, ball_dia=ball_dia,
                    race_spacing=race_spacing, race_height=race_height,
                    pushout=race_height*2, bextra=bextra){
    rotate_extrude()
      translate([diameter,0,0]) {
          translate([0,race_height/2,0]) 
            circle(d=ball_dia+bextra);
          translate([-race_spacing/2,0,0]) 
          square([race_spacing,race_height+1]);
        }
      translate([0,diameter,race_height/2]){
        cylinder(d=ball_dia, h=race_height);
        cylinder(d=ball_dia/2, h=pushout, center=true);
      }
}