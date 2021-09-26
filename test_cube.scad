
test_cube();
//level_check();

module level_check(){
    difference(){
        cube([280, 280, 1], center=true);
        for(X=[-2,-1,0,1,2], Y=[-2,-1,0,1,2])
            translate([60*X,60*Y,0]) cube([55,55,2], center=true);
    }
}

module test_cube(size=30, h=5, wall=1){
    translate([-size/2, -size/2, 0])
    difference(){
        cube([size, size, h]);
        translate([wall, wall, wall]) 
            cube([size-wall*2, size-wall*2, h]);
    }
}
