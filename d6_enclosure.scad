$fn=60;
sfn=30;
fudge=0.3;
side_spacing=248;
panel_height=284;
panel_width=256;
thickness=3.5;
include <fhex.scad>

//handle();
//door();
//translate([35,0,3]) test_template();
//translate([0,0,-1]) side_panel_test();


//top_side_support();

//for(Z=[-1,1]) translate([0,0,-145*Z]) rotate([90,0,0]) 
//    mirror([0,1-Z,0]) side_panel_support();
//for(X=[-1,1]) 
//translate([side_spacing/2*X,0,0]) mirror([1-X,0,0])
//    vertical_side_panel_support();
//translate([-234/2,-180,0])
//rotate([90,0,0])
//door_assembly();
//for(X=[-1,1])
//translate([175*X,0,0])
//rotate([0,0,90*X]) side_assembly();
//for(X=[-1,1]) translate([124*X,0,0]) rotate([90,90,0]) vert_test(width=294);

//translate([-141,11,0]) import("../printer/camera-mount.stl");

//translate([107.5,60+35,-5]) rotate([0,90,0]) door_camera_mount(height=35);
top_enclosure();
//test_template2();
//door();
    
module export_door(){
    projection(cut = true) rotate([0,0,0]) door();
}

module door(){
    difference(){
        translate([120,0,0]) 
        hull() for(X=[-1,1], Y=[-1,1]){
            translate([((265/2)-2.5)*X,((305/2)-2.5)*Y,0]) cylinder(d=5, h=thickness);
        }
        
        for(Y=[-92.5,-67.5,67.5,92.5]) translate([0, Y, 0])
            cylinder(d=4.2+fudge, h=10, center=true); 
        for(X=[224,233]) translate([X, 0, 0])
            cylinder(d=4.2+fudge, h=10, center=true);
        for(Y=[65, 45]) %translate([120,Y,0])
            for(X=[-1,1]) translate([7*X,0,-1]) 
                cylinder(d=3.8, h=thickness+2);
    }
}

module export_side_panel(){
    projection(cut = true) rotate([90,0,0]) side_panel();
}



module top_enclosure(sthickness=3){
    width=300;
    depth=300;
    height=145;
//    translate([0,0,height/2]) 
//        %cube([width, depth, height], center=true);
  translate([0,0,145-sthickness/2])
    enclosure_top(width, depth, sthickness);
  for(X=[-1,1]) translate([((width/2)-sthickness/2)*X,0,0])
    enclosure_side(height, depth, sthickness);
  translate([0,-depth/2+sthickness/2,height/2-sthickness/2])
    enclosure_front();
  translate([0,depth/2-sthickness/2,height/2-sthickness/2])
    enclosure_back();
}

module enclosure_top(width=300, depth=300, sthickness=3){
  difference(){
    cube([width,depth,sthickness], center=true);
    for(X=[-1,1], Y=[-1,1])
      translate([X*75, Y*(150-sthickness/2), -1])
        cube([30,sthickness,sthickness+2], center=true);
    for(X=[-1,1], Y=[-1,1])
      translate([X*(150-sthickness/2), Y*75, -1])
        cube([sthickness,30,sthickness+2], center=true);
  }
}

module enclosure_side(height=145, depth=300, sthickness=3){
    // 190 length minus 110 
    translate([0,0,height/2-sthickness/2])
      difference(){
        cube([sthickness, depth, height-sthickness], center=true);
        for(Y=[-1,1]) translate([0,(depth/2-sthickness/2)*Y,0])
          cube([sthickness, sthickness, 30], center=true);
      }
    for(Y=[-1,1]) translate([0,Y*75,height-sthickness/2]) 
      cube([sthickness, 30, sthickness], center=true);
    translate([0,0,-sthickness/2])
      difference(){
        cube([sthickness, 190, sthickness], center=true);
        cube([sthickness, 110, sthickness], center=true);
      }
}

module enclosure_front(height=145, width=300, sthickness=3){
    translate([0,0,0])
      cube([width-sthickness*2, sthickness, height-sthickness], center=true);
    for(X=[-1,1]) translate([X*75,0,height/2]) 
      cube([30, sthickness, sthickness], center=true);
    for(X=[-1,1]) translate([X*(width/2-sthickness/2),0,0]) 
      cube([sthickness, sthickness, 30], center=true);
}

module enclosure_back(height=145, width=300, sthickness=3){
  difference(){
    enclosure_front(height, width, sthickness);
    translate([-80,0,30]) cube([80,10,30], center=true);
  }
}

module door_camera_mount(down_tilt=40, height=0){
    difference(){
        union(){
            hull(){
                cylinder(d=9, h=25);
                translate([-5,-4.5,0]) cube([1,9,25]);
                translate([-5,-height-20,0])
                    cube([5,height+20,25]);
            }
        }
        translate([0,0,5]) rotate([0,0,-down_tilt]) hull(){
            cylinder(d=10, h=15.5);
            translate([10,-5,0]) cube([1,10,15.5]);
        }
        translate([0,0,-0.5]) cylinder(d=3.8, h=26);
        translate([0,0,0.7]) fhex(5.6,1.5);
        translate([0,-5,5]) cube([30,10,15.5]);
        
        for(Z=[-7,7]){
            translate([0,-height-15,12.5+Z]) rotate([0,90,0]) 
                cylinder(d=3.8, h=26, center=true);
            translate([0,-height-15,12.5+Z]) rotate([0,90,0]) 
                fhex(m3_hex_nut,5);
        }
    }
}

module camera_mount(height=30){
    difference(){
        union(){
            hull(){
                cylinder(d=9, h=25);
                translate([-5,-4.5,0]) cube([1,9,25]);
                translate([-5,-height-30,0]) cube([5,height+30,25]);
            }
            hull(){
                translate([30,-height-41.5,0]) cube([40,5,25]);
                translate([-5,-height-30,0]) cube([75,5,25]);
            }
            translate([-2,-height,0]) rotate([0,0,-45]) 
                cube([45,5,25]);
        }
        translate([0,0,5]) cylinder(d=10, h=15.5);
        translate([0,0,-0.5]) cylinder(d=3.8, h=26);
        translate([0,0,0.7]) fhex(5.6,1.5);
        translate([0,-5,5]) cube([30,10,15.5]);
        
        translate([48,-height-20,12.5]){
            rotate([90,0,0]) cylinder(d=5, h=26);
            translate([0,-18,0]) rotate([90,0,0]) 
                cylinder(d=6, h=5);
            hull(){
                rotate([90,0,0]) cylinder(d=15, h=10);
                translate([30,-6,0]) cube([1,10,15], center=true);
            }
        }
        for(Z=[5,20]) translate([60,-height-35,Z]) rotate([90,0,0]) 
            cylinder(d=3.3, h=10);
        translate([38,-height-36,-0.5]) cube([33,6,26]);
    }
}

module vert_test(width=293, thickness=1){
    difference(){
        hull() for(X=[-1,1]) translate([width/2*X,0,0]) 
            cylinder(d=10, h=thickness);
        for(X=[-1,1]) translate([width/2*X,0,-1]) 
            cylinder(d=5.2, h=thickness+2);
    }
}

module side_assembly(){
    translate([0,0,5+142]) rotate([90,180,0]) top_side_support();
    %side_panel();
    translate([0,0,-5-142]) rotate([90,0,0]) side_panel_support();
}

module side_panel(){
    difference(){
        translate([0,-thickness/2,0]) 
            cube([panel_width, thickness, panel_height], center=true);
        for(Z=[-1,0,1], X=[-1,1]) 
            translate([((panel_width/2)-5)*X,0,(panel_height/2-20)*Z])
            rotate([90,0,0]) 
            cylinder(d=3.2+fudge, h=40, center=true);
    }
//    for(Z=[-1,0,1], X=[-1,1]) 
//        translate([((panel_width/2)-5)*X,0,(panel_height/2-20)*Z])
//        rotate([90,0,0]) 
//        %cylinder(d=3.2+fudge, h=40, center=true);
}

module side_panel_test(spacing=side_spacing){
    dia=5;
    thickness=3;
    difference(){
        hull() for(X=[-1,1]) translate([spacing/2*X,0,0]) 
            cylinder(d=5+4, h=thickness);
        for(X=[-1,1]) translate([spacing/2*X,0,-0.5]) 
            cylinder(d=5+fudge, h=thickness*2);
    }
}

module vertical_side_panel_support(dia=20, sep=290){
    difference(){
        hull()
            for(Z=[-1,1]) translate([0,0,sep/2*Z]) 
                sphere(d=dia, $fn=sfn);
        translate([0,dia/2,0])
            cube([dia, dia, sep+dia], center=true);
        translate([-(dia/2)+4.5,-thickness+fudge*4,0])
            cube([dia, thickness+fudge*3, sep+dia], center=true);
        for(Z=[-1,1]){
            translate([dia,-1,sep/2*Z]) rotate([0,-90,0])
                cylinder(d=dia, h=dia*2);
        }
        for(Z=[-1,0,1]){
            translate([-1,0,(panel_height/2-20)*Z])
                rotate([90,0,0]) {
                cylinder(d=3.2+fudge, h=40, center=true);
                translate([0,0,11]) fhex(m3_hex_nut+fudge,10);
            }
        }
    }
}

module top_side_support(){
    hull() for(X=[-1,1], Y=[-20,-30]) 
        translate([-50*X,Y,20]) sphere(d=5, $fn=sfn);
    for(X=[-1,1]) translate([-50*X,0,0]) hull(){
        translate([0,0,2.5]) sphere(d=5, $fn=sfn);
        translate([0,-20,20]) sphere(d=5, $fn=sfn);
        translate([0,-30,2.5]) sphere(d=5, $fn=sfn);
        translate([0,-30,20]) sphere(d=5, $fn=sfn);
    }
    hull() for(X=[-1,1]){
        translate([50*X,-30,2.5]) sphere(d=5, $fn=sfn);
        translate([115*X,0,2.5]) sphere(d=5, $fn=sfn);
    }
    hull() for(X=[-1,1], Z=[2.5,20]) 
        translate([-50*X,-30,Z]) sphere(d=5, $fn=sfn);
    side_panel_support(dia=20);
    
}

module side_panel_support(dia=20){
    difference(){
        hull()
            for(X=[-1,1]) translate([side_spacing/2*X,0,0]) 
                sphere(d=dia, $fn=sfn);
        translate([0,0,-dia/2])
            cube([side_spacing+dia, dia, dia], center=true);
        translate([0,(dia/2)+4.5,(thickness/2)-fudge])
            cube([side_spacing+dia, dia, thickness+fudge*3], center=true);
        for(X=[-1,1]){
            translate([side_spacing/2*X,0,-0.5])
                cylinder(d=5+fudge, h=dia);
            translate([side_spacing/2*X,0,dia/4])
                cylinder(d=dia, h=dia);
        }
    }
}

module handle(){
    curve=75;
    difference(){
        union(){
            hull() for(X=[0,16]) translate([X,0,0])
            cylinder(d=15, h=15);
            translate([8,0,12])
            intersection(){
                translate([0,0,curve/2]) 
                    sphere(d=curve, $fn=300);
                cylinder(d=35, h=5);
            }
        }
        for(X=[-2, 7]) translate([X,0,-10]) screw_cutout(20);
        translate([16,0,-0.01]){
            %magnet();
            cylinder(d=11.1125+fudge, h=4.7625);
        }
    }
    
}

module test_template2(thickness=3.2){
//    265
    difference(){
        union(){
            hull() for(Y=[-1,1], X=[-1,0])
                translate([8*X,185/2*Y,0]) 
                cylinder(d=10, h=thickness);
            translate([227, 0, 0])
            hull() for(X=[0,15]) translate([X,0,0]) cylinder(d=15, h=thickness);
            for(Y=[-1,1])
            hull(){
                translate([0,185/2*Y,0]) cylinder(d=5, h=3);
                translate([227,0,0]) cylinder(d=5, h=3);
            }
            translate([265/2-12.5,45,0])
            hull() for(X=[-1,1])
            translate([7*X,0,0]) cylinder(d=10, h=thickness);
        }
        for(Y=[-92.5,-67.5,67.5,92.5]) translate([0, Y, 0])
            cylinder(d=4.2+fudge, h=10, center=true); 
        for(X=[224,233]) translate([X, 0, 0])
            cylinder(d=4.2+fudge, h=10, center=true);
        translate([227+15, 0, 2.9])
            cylinder(d=11.1125+fudge, h=thickness);
        translate([120,45,0])
            for(X=[-1,1])
            translate([7*X,0,-1]) cylinder(d=3.8, h=thickness+2);
    }
}

module test_template(thickness=3.2){
    translate([-27,0,-6.5])
    difference(){
        union(){
            hull() for(Y=[-1,1], X=[-1,0])
                translate([8*X,185/2*Y,0]) 
                cylinder(d=10, h=thickness);
            translate([227, 0, 0])
            hull() for(X=[0,15]) translate([X,0,0]) cylinder(d=15, h=thickness);
            for(Y=[-1,1])
            hull(){
                translate([0,185/2*Y,0]) cylinder(d=5, h=3);
                translate([227,0,0]) cylinder(d=5, h=3);
            }
        }
        for(Y=[-92.5,-67.5,67.5,92.5]) translate([0, Y, 0])
            cylinder(d=4.2+fudge, h=10, center=true); 
        for(X=[224,233]) translate([X, 0, 0])
            cylinder(d=4.2+fudge, h=10, center=true);
        translate([227+15, 0, 2.9])
            cylinder(d=11.1125+fudge, h=thickness);
    }
}

module magnet(){
    cylinder(d=11.1125, h=4.7625);
}

module door_assembly(){
    width=234;
    translate([35,0,0]) test_template();
    translate([8,0,-thickness]) %door();
    translate([width,0,0]) handle();
    for(Y=[-80,80]){
        translate([-7,Y,0])
        rotate([0,0,270]){
            hinge(offset=3);
            moving_hinge();
        }
    }
//    translate([122.5,0,0]) %cube([245, 295, 1], center=true);
//    for(Y=[-1,1]) %translate([-12,135/2*Y,0]) cylinder(d=3, h=20, center=true);
}

module moving_hinge(){
    translate([0,10,0]) rotate([0,0,180]) hinge(nut=false);
}

module screw_cutout(length=5){
    translate([0,0,-0.2]) cylinder(d=4.2+fudge, h=length);
    translate([0,0,length-0.21]) 
        cylinder(d1=4.2+fudge, d2=m4_hex_nut+fudge, h=m4_nut_height);
    translate([0,0,length+m4_nut_height-0.211]) 
        cylinder(d=m4_hex_nut+fudge, h=length);
}

module hinge(hole_center=25, height=30, offset=0, nut=true){
    diameter=5;
    
    difference(){
        union(){
            hull() translate([0,-5,-offset])
            for(X=[-1,1], Y=[-1,1]) 
                translate([height/2*X, 3.75*Y, 0]) 
                cylinder(d=5, h=3+offset);
            hull(){
                translate([0,5,5]) rotate([0,90,0]) 
                    cylinder(d=10, h=(height+diameter)/2);
                translate([0,-5,0])
                cube([(height+diameter)/2,10,0.1]);
            }
        }
        for(X=[-1,1]) translate([hole_center/2*X, -5, -5-offset])
            screw_cutout(5+offset);
        translate([-2,5,5]) rotate([0,90,0])
            cylinder(d=3.3+fudge, h=height);
        if(nut){
            translate([1,5,5]) rotate([0,90,0]) 
                fhex(m3_hex_nut+fudge,m3_nut_height);
        }
        translate([-(height/2)-diameter,5,5])
            rotate([0,90,0])
            cylinder(d=11, h=(height/2)+diameter);
    }
}