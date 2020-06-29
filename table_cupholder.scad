$fn=60;
inner_dia=75;
thickness=5;
depth=75;
tab_width=inner_dia+thickness*2;


translate([62-8,0,82]) %cube([25,100,15], center=true);
table_cupholder();

module table_cupholder(offset=-8){
    main_fn=240;
    difference(){
        union(){
            hull(){
                cylinder(d=inner_dia+thickness*2, h=depth, $fn=main_fn);
                translate([(inner_dia/2)+thickness,0,depth-2.5]) 
                    rotate([90,0,0]) 
                    cylinder(d=5, h=tab_width, center=true);
            }
            for(Y=[-1,1])
            translate([(inner_dia/2)+thickness+15+offset,((tab_width-12)/2)*Y,depth]){
                translate([0,-(tab_width/4)*Y,0])
                rotate([0,180,90]) screw_pad();
                translate([-8,0,8])
                    rotate([-90,0,90]) screw_pad(over=8, up=10);
            }
        }
        translate([0,0,thickness])
            cylinder(d=inner_dia, h=depth, $fn=main_fn);
    }
}

//screw_pad();
module screw_pad(d=12, up=10, over=20){
    difference(){
        hull(){
            translate([0,0,2.5]) cylinder(d=d, h=5, center=true);
            translate([0,over,up]) rotate([90,0,0]) 
                cylinder(d=d, h=0.1, center=true);
            translate([0,over,0.5]) cube([d,0.1,1], center=true);
        }
        cylinder(d=5, h=30, center=true);
        translate([0,0,2]){
            cylinder(d1=5, d2=8.5, h=5);
            translate([0,0,4.9]) cylinder(d=8.5, h=10);
        }
    }
}
