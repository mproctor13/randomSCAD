$fn=120;
odiameter=314;
inner_dia=295;
ridge_dia=320;

//full_model();
//%cube([200,200,20]);
//quarter();

spacer();

module spacer(){
    intersection(){
    difference(){
        union(){
            cylinder(d=odiameter, h=10, center=true);
            translate([0,0,3])
                cylinder(d=inner_dia-0.2, h=15, center=true);
        }
        cylinder(d=inner_dia-5, h=50, center=true);
    }
        translate([0,-inner_dia/2,3]) cube([20,20,30], center=true);
    }
}

module quarter(){
    
    difference(){
        intersection(){
            full_model();
            translate([0,0,-15]) cube([200,200,40]);
        }
        for(ZR=[0,90]) rotate([0,0,ZR]) 
         translate([(inner_dia+(odiameter-inner_dia)/2)/2,0,-3]) 
            rotate([90,0,0]) cylinder(d=3.3, h=25, center=true);
        translate([0,15,0])
        hull(){
        translate([(inner_dia+(odiameter-inner_dia)/2)/2,0,-3]) 
            rotate([90,0,0]) cylinder(d=8, h=20, center=true);
        translate([10+(inner_dia+(odiameter-inner_dia)/2)/2,0,-3]) 
            rotate([90,0,0]) cylinder(d=8, h=20, center=true);
        }
        translate([5,1+(inner_dia+(odiameter-inner_dia)/2)/2,-3])
            cube([2.4,10,5.4], center=true);
    }
}

module full_model(){
    difference(){
        union(){
//            cylinder(d=ridge_dia, h=3, center=true);
            translate([0,0,-3]) 
                cylinder(d=odiameter, h=10, center=true);
            translate([0,0,9])
            cylinder(d1=308, d2=304, h=15, center=true);
        }
        cylinder(d=inner_dia, h=50, center=true);
    }
}

