

// 38cm x 4xm x 4cm
//%cube([240,220,20]);
//translate([0,0,20])
//cube([370,20,40], center=true);
difference(){
cover();
translate([0,-100,0]) cube([250,200,200]);
}

module cover(){
    difference(){
        union(){
            shape(dia=44);
            for(X=[-1,0,1]) translate([185*X,0,0])
            hoop();
            hull()
            for(X=[-1,1], Y=[-1,1])
                translate([185*Y, 40*X, 0]) cylinder(d=5, h=2);
        }
        translate([0,0,-0.1]) shape();
    }
    
}

module hoop(){
    hull(){
        translate([-2,0,22]) 
            rotate([0,90,0]) cylinder(d=44, h=4);
//        for(Y=[-1,1]) translate([0,30*Y,0]) 
//            cylinder(d=4, h=2, $fn=60);
        translate([0,0,1]) cube([4,60,1], center=true);
    }
 }
module shape(dia=40, fn=60){
    hull()
    for(X=[-1,1]){
        translate([190*X,0,25]) sphere(d=dia, $fn=fn);
        translate([190*X,0,0]) cylinder(d=dia, $fn=fn);
    }
}