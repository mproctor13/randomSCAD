$fn=30;
offset=0;
zlimit();
module zlimit(){
    difference(){
        union(){
            hull() for(X=[-1,1], Y=[-1,1])
                translate([17.5*X, 17.5*Y, 0]) cylinder(d=5, h=5);
            translate([10,0,0])
            hull() for(X=[-1,1], Y=[17.5,-10-offset])
                translate([7.5*X, Y, 0]) cylinder(d=5, h=5);
             
        }
        translate([-9.8,4.45,-0.5]) for(X=[-1,1]){
            translate([7.5*X,0,0]) cylinder(d=2.6, h=6);
        }
        translate([-20+4.33,15-3.77,-0.5]) cube([14,5,6]);
        translate([-20+5.4,17-12.75,-0.5]) cube([9,3,6]);
        
        for(Y=[0,-20])
            translate([10,13.5+Y-offset,-0.5]) cylinder(d=5, h=6);
    }
}