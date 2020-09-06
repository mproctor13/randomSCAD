include <MCAD/shapes.scad>
include <slot_fill.scad>


module fhex(wid,height){
  hull(){
    cube([wid/1.7,wid,height],center=true);
    rotate([0,0,120]) cube([wid/1.7,wid,height], center=true);
    rotate([0,0,240]) cube([wid/1.7,wid,height], center=true);
  }
}

module dyze_mount(fudge=0.2){
  translate([0,0,(2+fudge)/2]) cylinder(d=16+fudge, h=2+fudge, $fn=60, center=true);
  translate([0,0,(2+fudge)+((5-fudge)/2)]) cylinder(d=12+fudge, h=5-fudge, $fn=60, center=true);
  translate([0,0,7+25/2]) cube([16,25,25], center=true);
}


dyze_mount();

