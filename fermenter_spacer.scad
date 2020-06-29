$fn=120;

//spacer();
air_lock_holder();

module spacer(){
    difference(){
        cylinder(d=55, h=25, center=true);
        cylinder(d=38.5, h=27, center=true);
    }
}

module air_lock_holder(){
    difference(){
        hull(){
            cylinder(d=40, h=15, center=true);
            translate([0,30,0]) cube([40,1,15], center=true);
        }
        translate([0,0,5]) cylinder(d=35, h=15, center=true);
        translate([0,0,-5]) cylinder(d=13, h=7.5, center=true);
        
        translate([0,22.5,-5]) cube([45, 5, 15],center=true);
//        %hull(){
//            translate([0,22.5,2.5]) rotate([0,90,0]) 
//                cylinder(d=5, h=45, center=true);
//            translate([0,22.5,-10]) rotate([0,90,0]) 
//                cylinder(d=5, h=45, center=true);
//        }
    }
}