$fn=60;
fudge=0.2;
R=2.5;
tap_holder();

module tap_holder(){
    difference(){
        union(){
            translate([0,-15,0]) hull() for(X=[-1,1], Y=[-1,1], Z=[-1,1])
                translate([(30-R)*X,(7.5-R)*Y,(15-R)*Z+15]) 
                sphere(r=R);
            hull() for(X=[-1,1], Y=[-1,1], Z=[-1,1])
                translate([(15-R)*X,(15-R)*Y,(15-R)*Z+15]) 
                sphere(r=R);
        }
        translate([0,0,5]) cylinder(d=21, h=30);
        
        translate([22.5,-15,5]) cylinder(d=5.8+fudge, h=30);
        translate([12,-15,5]) cylinder(d=5.6+fudge, h=30);
        translate([0,-15,5]) cylinder(d=4.6+fudge, h=30);
        translate([-12,-15,5]) cylinder(d=3.65+fudge, h=30);
        translate([-22.5,-15,5]) cylinder(d=2.85+fudge, h=30);
    }
}

module ream_holder(){
    difference(){
        hull() for(X=[-1,1], Y=[-1,1], Z=[-1,1])
            translate([(40-R)*X,(7.5-R)*Y,(15-R)*Z+15]) 
            sphere(r=R);
        translate([30,0,5]) cylinder(d=10+fudge, h=30);
        translate([18,0,5]) cylinder(d=9+fudge, h=30);
        translate([7,0,5]) cylinder(d=8+fudge, h=30);
        translate([-3,0,5]) cylinder(d=7+fudge, h=30);
        translate([-12,0,5]) cylinder(d=6+fudge, h=30);
        translate([-20,0,5]) cylinder(d=5+fudge, h=30);
        translate([-28,0,5]) cylinder(d=4+fudge, h=30);
        translate([-35,0,5]) cylinder(d=3+fudge, h=30);
    }
}