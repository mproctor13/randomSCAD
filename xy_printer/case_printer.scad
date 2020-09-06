include <BOLTS.scad>
include <MCAD/stepper.scad>
include <vslot.scad>


module 16tooth_pully(){
  translate([0,0,8]) 
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

%cube([510,285,200], center=true);
//translate([-70,-450,0]) linear_extrude(10) text("FRONT", 30);
 corexz();


module corexz(){
  plane_height=510;
  plane_width=280;
  nema_offset=28;
  
  difference(){
    cube([6,280,510], center=true);
    translate([0, (plane_width/2)-nema_offset, -((plane_height/2)-nema_offset)]) 
      rotate([0,90,0]) cylinder(d=39, h=8, center=true, $fn=60);
    translate([0, -((plane_width/2)-nema_offset), -((plane_height/2)-nema_offset)]) 
      rotate([0,90,0]) cylinder(d=39, h=8, center=true, $fn=60);
  }
  translate([0, (plane_width/2)-nema_offset, -((plane_height/2)-nema_offset)]) 
    rotate([0,90,0]) motor(Nema23, NemaMedium, dualAxis=false);
  translate([0, -((plane_width/2)-nema_offset), -((plane_height/2)-nema_offset)]) 
    rotate([0,90,0]) motor(Nema23, NemaMedium, dualAxis=false);
}

