
include <MCAD/shapes.scad>
include <delta/griffin/beagleboneblack.scad>
$fn=60;
//translate([-47.5,-27.4,11.5]) beagleboneblack();

//%cube([80, 60, 20], center=true);
//
difference(){
//    cube([85, 65, 1], center=true);
    union(){
        roundedBox(90, 70, 3, 3);
        beaglebone_holes(hole_size=6, height=8);
    }
    translate([0,0,-3]) lerge_holes(hole_size=3.5);
    translate([0,0,-1]) beaglebone_holes();
    roundedBox(80, 35, 10, 2);
    roundedBox(60, 60, 10, 2);
}

//translate([-55-33,0,0])
//%for(Y=[-1,1]){
//        translate([55,24.1*Y,7]) cylinder(d=6, h=8, center=true, $fn=30);
//        translate([121,20.95*Y,7]) cylinder(d=6, h=8, center=true, $fn=30);
//      }
//translate([0,0,5]) beaglebone_holes();

module beaglebone_holes(hole_size=3, height=10){
    for(Y=[-1,1]){
        translate([-33, 24.1*Y, 0]) cylinder(d=hole_size,h=height);
        translate([33, 20.95*Y, 0]) cylinder(d=hole_size,h=height);
    }
}

module lerge_holes(hole_size=3, height=10){
    for(X=[-1,1], Y=[-1,1]){
        translate([40*X, 30*Y, 0]) cylinder(d=hole_size,h=height);
    }
}