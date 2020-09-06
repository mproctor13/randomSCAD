
right_cover();

module right_cover(){
    difference(){
        generic_cover();
        translate([-50, 0, -8]) rotate([0, 0, 0]) cylinder(d=12.5, h=6, $fn=60);
    }
}

module generic_cover(){
    difference(){
        union(){
        difference(){
            cube([157,96,10], center=true);
            translate([-1.1,0,1.1]) cube([155,92,8], center=true);
        }
            hull() for(X=[2.5,0], Y=[-8,8]) translate([82-X,Y,-5]) cylinder(d=5, h=10, $fn=60);
        for(Y=[-7,7]) translate([61,Y,-5]) cylinder(d=8, h=5, $fn=60);
        }
        translate([-82,0,0]) rotate([0,25,0]) cube([10,96.2,20], center=true);
        for(X=[0,20], Y=[-7,7]) translate([81-X,Y,-5.1]) cylinder(d=3.8, h=11, $fn=60);
    }
    
}