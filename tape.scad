$fn=60;

tape_mount();

module tape_mount(height=25){
    difference(){
        hull() for(X=[-1,1]) translate([9.5*X, 0, 0])
            cylinder(h=height, d=12);
        translate([-12.5, -3, -1]) cube([25, 4.5, height+2]);
//        translate([-12.5, 1.5, 0]) %cube([25, 4.5, height+2]);
        translate([0, 0, height/2]) rotate([90,0,0]) 
            cylinder(d=12, h=8);
        translate([0, 8, height/2]) rotate([90,0,0]) 
            cylinder(d=6, h=20);
    }
}
