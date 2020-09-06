$fn=120;

lower=0;
forward=35;
down_angle=5;

mount_height = 15;
xaxis_mount(height=mount_height);
translate([-5.63-20,-lower-25, forward]) rotate([90,0,90]) 
difference(){
    union(){
        rotate([0,-down_angle,0]) cylinder(d=35, h=20);
        hull(){
            rotate([0,-down_angle,0]) difference(){
                cylinder(d=30, h=20);
                cylinder(d=28, h=40);
                translate([-11,5,0]) cylinder(d=50, h=20);
            }
            translate([lower+17, -forward, 20]) 
                cube([10, mount_height, 20]);
        }
        translate([0,28,6.5]) rotate([0,0,180]) 
            mount_point(link=true);
    }
    rotate([0,-down_angle,0]) translate([0,0,-1]) cylinder(d=27.5, h=40);
    rotate([0,-down_angle,0]) translate([-25,0,18]) rotate([0,90,0]) cylinder(d=20, h=20);
    
    translate([25+lower,0,25.63]) rotate([90,0,0])
            cylinder(d=3, h=50);
    translate([25+lower,5,25.63]) rotate([90,0,0])
            cylinder(d=6, h=50);
}


module link(){
    
}

module xaxis_mount(height=15, screw_length=12){
    difference(){
        translate([-5.5,-50.2,0]) 
            linear_extrude(height) import("mk3_xaxis_mount.dxf");
        translate([0,0,screw_length]) 
            cylinder(d=6, h=height-screw_length+20);
    }
}

module mount_point(pip=28, link=false, link_length=30){
    difference(){
        hull(){
            cylinder(d=23, h=7);
            if(link == true){
                translate([0,link_length,3.5]) cube([23,1,7], center=true);
            }
        }
        translate([0,0,-1]) cylinder(d=6.5, h=9);
    }
    for(R=[0:360/pip:360]) rotate([0,0,R]) translate([0,5.5,-0.25]) nub();
}

module nub(length=4, width=7.5){
    hull(){
        cylinder(d=0.5, h=width, $fn=30);
        translate([0,length-1,0]) cylinder(d=0.5, h=width, $fn=30);
    }
}

module mk_dxf(){
    projection(cut = true){
        difference(){
            translate([-0.39, 0,-4]) import("xaxisbracket.stl");
            translate([-1,0,-2]) cube(42);
        }
        hull(){
            translate([0.1,42,0]) cube([30,4,1]);
            translate([21,50,0]) cube([1,1,1]);
        }
    }
}
