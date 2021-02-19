$fn=120;
spool_hole=53.5;
hole_diameter=30;
spool_height=10;

spool_adaptor();

module spool_adaptor(spool_hole=spool_hole){
    difference(){
        union(){
            translate([0,0,spool_height]) cylinder(d=hole_diameter,h=5);
            cylinder(d=spool_hole, h=spool_height);
        }
        translate([0,0,-0.5]) cylinder(d=hole_diameter-4, h=spool_height+6);
    }
}
