
test_cube();
module test_cube(size=30, h=10, wall=1){
    translate([-size/2, -size/2, 0])
    difference(){
        cube([size, size, h]);
        translate([wall, wall, wall]) 
            cube([size-wall*2, size-wall*2, h]);
    }
}
