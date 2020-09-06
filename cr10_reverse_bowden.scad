$fn=60;
width=25;
length=25;
height=5;
rad=1;
offset=7;
hole_center=18;
difference(){
    hull() for(X=[-1,1], Y=[-1,1]) 
        translate([(width-rad*2)/2*X, (length-rad*2)/2*Y, 0]) 
            cylinder(r=rad, h=height);
    translate([0, (length/2)-offset, -1]){
        hull(){
            cylinder(h=height*2, d=10.5);
            translate([-5.25, length-offset, -1]) 
                cube([10.5, 1, height*2]);
        }
        for(X=[-1,1]) translate([(hole_center/2)*X,1,0]) 
            cylinder(d=3.8, h=height*2);
        for(X=[-1,1]) translate([(hole_center/2)*X,1,3]) 
            cylinder(d=6.2, h=height*2);
    }
}
difference(){
    translate([-10, -8.5, 20]){
            hull(){
            translate([1.5, 0, 0]) rotate([90,0,0]) 
                cylinder(d=14, h=4);
            translate([1.5, 0, -15]) rotate([90,0,0]) 
                cylinder(d=8, h=4);
            translate([18, 0, -16]) rotate([90,0,0]) 
                cylinder(d=8, h=4);
        }
        hull(){
            translate([1.5, 0, 0]) rotate([90,0,0]) 
                cylinder(d=14, h=4);
            translate([1.5, 0, -13]) rotate([90,0,0]) 
                cylinder(d=14, h=4);
            translate([1.5-18, 0, 0]) rotate([90,0,0]) 
                cylinder(d=14, h=4);
        }
    }
    translate([-8.5, -4, 20]) rotate([90,0,0]) cylinder(d=6, h=10);
    translate([-8.5-10, -4, 20]) 
        hull(){
            rotate([90,0,0]) cylinder(d=7.2, h=10);
            translate([-8, 0, 0])rotate([90,0,0]) cylinder(d=7.2, h=10);
        }
    translate([-27, -15, 18]) cube([9, 10, 10]);
}

