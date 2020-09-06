$fn=120;
tank_dia=135;
support_height=100;
support_length=200;

//%cube([300,300,300], center=true);
tank_support();

module tank_support(){
  difference(){
    union(){
      cylinder(d=tank_dia+10, h=support_height);
      hull(){
        cylinder(d=tank_dia+10, h=5);
        translate([support_length-25,0,0]) cylinder(d=50, h=5);
      }
      hull(){
        translate([support_length-2.5,0,0]) cylinder(d=5, h=5);
        translate([tank_dia/2,0,0]) cylinder(d=5, h=support_height);
      }
    }
    translate([0,0,2.5]) cylinder(d=tank_dia, h=support_height);
  }
}


