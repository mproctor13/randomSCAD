include <configuration.scad>;
include <bltouch.scad>

separation = 42;  // Distance between ball joint mounting faces.
offset = 20;  // Same as DELTA_EFFECTOR_OFFSET in Marlin.
push_fit_height = 4.9;  // Length of brass threaded into printed plastic.
push_fit_radius = 4.7; //M10 x 1.0 thread for manual tap
push_fit_manual_tap = true;
height = 10;
cone_r1 = 3;
cone_r2 = 12;
cone_supports = false;
hotend_rotation = 25;

module effector(){
    difference(){
        union(){
            cylinder(r=offset-2, h=height, center=true, $fn=180);
            for (a = [60:120:359]) rotate([0, 0, a]){
                rotate([0, 0, 30]) translate([offset-2, 0, 0]) cube([10, 13, height], center=true);
                for (s = [-1, 1]) scale([s, 1, 1]) {
                    translate([0, offset, 0]){
                        if(cone_supports){
                            translate([separation / 2 - 2.5,0,-height / 2 + 1.7]) rotate([0,0,90]) cube([1,5,height / 2 - 1.6], center=true);
                            translate([separation / 2 - 5.4,3.425,-height / 2 + 2.5]) rotate([0,0,160]) cube([1,5,height / 2], center=true);
                        }
                        difference(){
                            intersection(){
                                cube([separation, 40, height], center=true);
                                translate([0, -4, 0]) rotate([0, 90, 0]) cylinder(r=10, h=separation, center=true);
                                translate([separation/2-7, 0, 0]) rotate([0, 90, 0]) cylinder(r1=cone_r2, r2=cone_r1, h=14, center=true, $fn=96);
                            }
                            rotate([0, 90, 0]) cylinder(r=m3_radius, h=separation+1, center=true, $fn=96);
                            rotate([90, 90, 90]) cylinder(r=m3_nut_radius, h=separation-23, center=true, $fn=6);
                        }
                    }
                }
            }
        }
    }
}

module generic_cyclops_effector(){
    difference(){
        effector();
        for(X=[-9,9]) translate([X, 0, -10]) cylinder(d=12,  h=20, $fn=60);
        translate([0, -3, -10]) cylinder(d=3.5,  h=20, $fn=60);
        for(X=[-8.5,8.5]) translate([X, 9, -10]) cylinder(d=3.5,  h=20, $fn=60);
    }
    hull(){
        translate([0,-12,-5]) cylinder(d=12,  h=1, $fn=6);
        translate([0,-18,-15.55]) cylinder(d=12,  h=1, $fn=6);
    }
    translate([0,-18,-15.55]) bltouch_base_mount();
}

module generi_cyclops(cutouts=true,nozzle=true){
    difference(){
        translate([0, 0, -15]) cube([30,18,30], center=true);
        translate([0, -6, -7]) cylinder(d=3.5,  h=8, $fn=60);
        for(X=[-8.5,8.5]) translate([X, 6, -7]) cylinder(d=3.5,  h=8, $fn=60);
            
        for(X=[-9,9]) translate([X, -3, -31]) cylinder(d=7,  h=14.5, $fn=60);
        for(X=[-9,9]) translate([X, -3, -31]) cylinder(d=4,  h=32, $fn=60);
        for(X=[-9,9]) translate([X, -3, -7.5]) cylinder(d=9,  h=8, $fn=60);
        if(cutouts){
            for(Z=[-1.75:-4:-26]) translate([0, 6, Z-1.25]) cube([31,6.1,2.5], center=true);
        }
    }
    if(nozzle){
        nozzle_depth=30+29;
        translate([-9-(11.5/2), -3-4.5, -nozzle_depth+5.5]) color("silver") cube([12,20,20]);
        translate([9-(11.5/2), -3-8.5, -nozzle_depth+5.5]) color("silver") cube([12,24,20]);
        for(X=[-9,9]) translate([X, -3, -nozzle_depth]) color("gold") cylinder(d1=1.5, d2=4,  h=2.5, $fn=60);
        for(X=[-9,9]) translate([X, -3, -nozzle_depth+2.5])  color("gold") cylinder(d=8,  h=3, $fn=6);
    }
}

//translate([0,-18,-14.7]) rotate([0,180,0]) bltouch();
//translate([0, 3, 0]) generi_cyclops();
//translate([-40,25,35]) rotate([0,157,270]) import("Radial_Fan_Fang_5015_chimera_fix_V1_1_repaired.stl");
translate([0, 0, height/2]) generic_cyclops_effector();
