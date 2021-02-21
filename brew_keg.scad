
use <PiZero.scad>

translate([0,0,50]) rotate([0,90,0]) PiZeroBody();

%scale([4,4,4]) 
translate([-100,-100,0]) 
import("../printer/keg.stl");

