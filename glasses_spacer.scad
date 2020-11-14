
length=10;
side=-1;
angle=2.5*side;
difference(){
    cube([13,4,length], center=true);
    translate([-10*side,0,2.5+length/2]) rotate([0,angle,0]) 
        translate([10*side,0,0]) cube([20,5,5], center=true);
    translate([10*side,0,2.5-length]) rotate([0,angle,0]) 
        translate([-10*side,0,0]) cube([20,5,5], center=true);
}
translate([0,2+1.5+1.75,length/2-1.5-2]) rotate([0,90,0]) 
    difference(){
        hull(){
            cylinder(d=3, h=6, center=true, $fn=60);
            translate([0,-3.3,0]) cube([6,.01,6], center=true);
        }
        cube([6,6.5,1.5], center=true);
        cylinder(d=1.4, h=8, center=true, $fn=60);
    }
translate([0,2+1.5+1.75,-length/2]) rotate([0,90,0]) 
    difference(){
        hull(){
            translate([2,0,0]) cylinder(d=3, h=6.4, center=true, $fn=60);
            translate([-2.5,-3.2,0]) cube([5,.1,6.4], center=true);
        }
        translate([2,0,0]) cylinder(d=1.4, h=8, center=true, $fn=60);
        for(X=[-1,1]) translate([2,0,1.4*X]) 
            cylinder(d=4.2, h=1.2, center=true, $fn=60);
    }
