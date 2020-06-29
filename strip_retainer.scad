$fn=60;
difference(){
    union(){
        hull() 
        for(X=[0, 1], Y=[-1,1]){
            translate([30*X,24*Y,0]) cylinder(r=2, h=3);
            translate([12*X,21*Y,43]) sphere(r=2);
        }
        for(Y=[-1,1]) translate([0,16*Y,0]){
            difference(){
                hull(){
                    translate([-10,0,0]) cylinder(d=12, h=3);
                    translate([10,0,0]) cylinder(d=14, h=20);
                }
                translate([-10,0,-1]) cylinder(d=5, h=10);
                translate([-10,0,3]) cylinder(d1=5, d2=8.2, h=5);
                translate([-10,0,7.99]) cylinder(d=8.2, h=5);
            }
        }
    }
    translate([22,0,22]) cube([40,41,40], center=true);
    translate([3.5+2+10,0,3.5+2+1]) 
    hull(){
        rotate([90,0,0]) cylinder(d=7, h=60, center=true);
        translate([0,0,40]) rotate([90,0,0]) 
            cylinder(d=7, h=60, center=true);
        translate([40,0,0]) rotate([90,0,0]) 
            cylinder(d=7, h=60, center=true);
        translate([40,0,40]) rotate([90,0,0]) 
            cylinder(d=7, h=60, center=true);
    }
}
