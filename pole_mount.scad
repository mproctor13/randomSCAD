$fn=60;
main_fn=240;
pip=20;

//translate([0,42,0]) import("../printer/5_Headpone_post_-_mount.stl");

translate([0,-20,0]) difference(){
    union(){
        cylinder(d=42, h=35, $fn=main_fn);
        hull(){
            translate([0,13,17.5]) cube([35,20,35], center=true);
            translate([0,14.9,17.5]) cube([31,20,35], center=true);
        }
        hull(){
            translate([0,-15,17.5]) 
                cube([19, 10, 35], center=true);
            translate([0,-29,17.5]) rotate([0,90,0]) 
                cylinder(d=20, h=19, center=true);
        }
    }
    translate([0,0,-0.5]) cylinder(d=35.5, h=36, $fn=main_fn);
    for(Z=[7,27]) translate([0,20,Z]) rotate([0,90,0]) 
        cylinder(d=3, h=50, center=true);
    translate([0,-29,17.5]) rotate([0,90,0]) 
        cylinder(d=6.25, h=20, center=true);
    translate([0,-25,17.5]) cube([8, 30, 36], center=true);
    translate([-11.5,-29,17.5]) rotate([0,90,0]) 
        cylinder(d=11.7, h=10, center=true);
    translate([11.5,-29,17.5]) rotate([0,90,0])
        fhex(11.8,10);
    
}
translate([-3.5,-49.25,17.25]) difference(){
rotate([0,90,0]) for(R=[0:360/pip:360]) rotate([0,0,R]) 
    translate([0,5.5,-0.25]) nub();
translate([0,-20,-15]) cube([7.2, 30, 30]);
}

module nub(length=4, width=10){
    hull(){
        cylinder(d=0.5, h=width, $fn=30);
        translate([0,length-1,0]) cylinder(d=0.5, h=width, $fn=30);
    }
}

module fhex(wid,height){
  hull(){
    cube([wid/1.7,wid,height],center=true);
    rotate([0,0,120]) cube([wid/1.7,wid,height], center=true);
    rotate([0,0,240]) cube([wid/1.7,wid,height], center=true);
  }
}