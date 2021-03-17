bextra=0.2;
ball_dia=5.91;
$fn=120;
main_diameter=75;
race_spacing=0.5;
race_width=10;
race_height=10;
holes=24;
hole_diameter=3;

//difference(){
//  union(){
//    inside_race();
    outside_race();
//  }
//  cube(100);
//}
module inside_race(diameter=main_diameter, holes=holes, 
                    offset=-0.5, race_spacing=race_spacing){
  translate([0,0,-offset])
  difference(){
  rotate_extrude()
    translate([diameter-race_width+race_spacing,0,0]) 
      difference(){
        square([race_width-race_spacing,race_height]);
        translate([race_width-race_spacing,race_height/2+offset,0]) 
          circle(d=ball_dia+bextra);
      }
    translate([-race_spacing,diameter,race_height/2+offset]){
      cylinder(d=ball_dia+bextra, h=race_height/2+abs(offset));
      cylinder(d=4, h=race_height+2, center=true);
    }
    if(holes > 0)
      for(R=[0:360/holes:360]) rotate([0,0,R])
        translate([0,diameter-ball_dia/2-(race_width-ball_dia/2)/2,-0.5]) 
          cylinder(d=hole_diameter, h=race_height+1);
  }
}

module outside_race(diameter=main_diameter, holes=holes, 
                    offset=+0.5, race_spacing=race_spacing){
  translate([0,0,-offset])
  difference(){
    rotate_extrude()
      translate([diameter+race_spacing,0,0]) 
        difference(){
          square([race_width-race_spacing,race_height]);
          translate([-race_spacing,race_height/2+offset,0]) 
            circle(d=ball_dia+bextra);
        }
      translate([0,diameter+race_spacing,race_height/2+abs(offset)]){
        cylinder(d=ball_dia+bextra, h=race_height/2+offset);
        cylinder(d=4, h=race_height+2, center=true);
      }
      if(holes > 0)
        for(R=[0:360/holes:360]) rotate([0,0,R])
          translate([0,diameter+ball_dia/2+(race_width-ball_dia/2)/2,-0.5]) 
            cylinder(d=hole_diameter, h=race_height+1);
  }
}