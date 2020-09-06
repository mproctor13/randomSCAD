
$fn=30;
sfn=30;
//drill_guide(length=190);
assembly();

module assembly(){
    translate([250,0,2]) repbox_mount();
    translate([-250,0,0]) mirror([1,0,0]) repbox_mount();
    translate([0,0,160]) %cube([500,320,320], center=true);
    translate([267,-2,1]) drill_guide();
//    translate([0,0,-25]) %cube([550,550,50], center=true);
    repbox_back();
    translate([0,160,200]) led_panel();
}


module repbox_back(){
    cube();
}

module led_panel(){
    cube([383, 13,190], center=true);
}

module drill_guide(length=200, height=5){
    difference(){
        union(){
            cube([20,length,2], center=true);
            translate([9,0,-height/2]) cube([2,length,height], center=true);
        }
        for(Y=[-1,0,1]) translate([10, 90*Y, -0.5])
            translate([-17,0,0]) cylinder(d=3.8, h=6, center=true);
    }
}

module repbox_mount(width=20, spacing=215, cutout_width=130){
    difference(){
        union(){
            hull(){
                for(Y=[-1,1]) translate([0,(spacing/2)*Y,20])
                    rotate([0,90,0]) cylinder(d=10, h=5);
                translate([0,-(spacing/2)-5,0])
                    cube([5,spacing+10,1]);
            }
            hull(){
                for(Y=[-1,1]) translate([10,((spacing/2)-10)*Y,0])
                    cylinder(d=10, h=5);
                translate([0,-(spacing/2)-5,0])
                    cube([5,spacing+10,5]);
            }
//            hull(){
//                for(Y=[-1,1]) 
//                    translate([5-width,((cutout_width/2)-7.5)*Y,21])
//                    rotate([0,90,0]) cylinder(d=15, h=width);
//                translate([5-width,-(cutout_width/2),0])
//                    cube([width,cutout_width,1]);
//            }
            translate([0,0,10])
            rotate([-90,0,-90]) handle();
            
        }
        translate([-8,-1-(135/2),19])
                    cube([8,cutout_width+12,10]);
        for(Y=[-1,1]) translate([-0.5,(spacing/2)*Y,20])
            rotate([0,90,0]) cylinder(d=3.3, h=6);
        for(Y=[-1,0,1]) translate([10, 90*Y, -0.5]){
            hull(){
                translate([0,-2.5,0]) cylinder(d=3.8, h=6);
                translate([0,2.5,0]) cylinder(d=3.8, h=6);
            }
            translate([0,5,0]) cylinder(d=8, h=6);
        }
//        hull(){
//            for(Y=[-1,1]) translate([0,40*Y,5]) rotate([0,90,0]) 
//                cylinder(d=20, h=35, center=true);
//            cube([35,100,1], center=true);
//        }
    }
}

module handle(){
    hull() for(X=[-1,1], Y=[-20,-30]) 
        translate([-50*X,Y,20]) sphere(d=5, $fn=sfn);
    for(X=[-1,1]) translate([-50*X,0,0]) hull(){
        translate([0,0,2.5]) sphere(d=5, $fn=sfn);
        translate([0,-20,20]) sphere(d=5, $fn=sfn);
        translate([0,-30,2.5]) sphere(d=5, $fn=sfn);
        translate([0,-30,20]) sphere(d=5, $fn=sfn);
    }
    hull() for(X=[-1,1]){
        translate([50*X,-30,2.5]) sphere(d=5, $fn=sfn);
        translate([108*X,-12,2.5]) sphere(d=5, $fn=sfn);
    }
    hull() for(X=[-1,1], Z=[2.5,20]) 
        translate([-50*X,-30,Z]) sphere(d=5, $fn=sfn);
}

