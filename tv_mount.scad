$fn=60;
//mount_test();

height=276;
ps4_width=53;
strap_width=50;
sq_nutX=5.6;
sq_nutY=2.2;
//
//%tv_frame();
//%translate([86,200,0]) rotate([90,0,180])
tv_frame_hook(width=strap_width);
//ps4_mount();

module mount_test(){
    difference(){
        cube([25,85,1], center=true);
        for(Y=[-2,-1,0,1,2]){
            translate([0,16.5*Y,0]) cylinder(d=7.5, h=6, center=true);
        }
    }
}

module tv_frame_hook(width=20, offset=35, length=80){
    difference(){
        union(){
            hull(){
                translate([0,0,20-3]) rotate([-90,0,0]) 
                    cylinder(d=8, h=width);
                translate([0,0,20-3-5]) rotate([-90,0,0]) 
                    cylinder(d=8, h=width);
            }
            hull(){
                translate([0,0,20-3]) rotate([-90,0,0]) 
                    cylinder(d=8, h=width);
                translate([15,0,20-3]) rotate([-90,0,0]) 
                    cylinder(d=8, h=width);
            }
            hull(){
                translate([15,0,20-3]) rotate([-90,0,0]) 
                    cylinder(d=8, h=width);
                translate([15,0,20-3-15]) rotate([-90,0,0]) 
                    cylinder(d=8, h=width);
            }
            hull(){
                translate([15,0,20-3-15]) rotate([-90,0,0]) 
                    cylinder(d=8, h=width);
                translate([15+offset,0,20-3-45]) rotate([-90,0,0]) 
                    cylinder(d=8, h=width);
            }
            hull(){
                translate([15+offset,0,20-3-45]) rotate([-90,0,0]) 
                    cylinder(d=8, h=width);
                translate([15+offset,0,20-45-length-1]) rotate([-90,0,0]) 
                    cylinder(d=8, h=width);
            }
        }
        tv_frame(width, offset, length);
        for(Z=[-50,-75,-100]){
          for(Y=[.25,.75]) translate([28,width*Y,Z+sq_nutX/2]) 
              rotate([0,90,0]) cylinder(d=3, h=200, center=true);
        }
    }
}
module tv_frame(width=20, offset=32.5, length=50){
    cube([14.5,width,17.5]);
    hull(){
        translate([0,0,-1]) cube([14,width,1]);
        translate([0,0,-30]) cube([14+offset,width,1]);
    }
    translate([0,0,-30-length]) cube([14+offset,width,length]);
}

module ps4_mount(width=50){
  difference(){
    hull() for(Y=[-1,1])
      translate([0,height/2*Y,0]) rotate([0,0,30]) 
        cylinder(d=80, h=width, $fn=$fn);
    translate([-ps4_width/2,-height/2,-1]) 
            cube([ps4_width,height,width+2]);
//    translate([32,90,0]) %cube([8,75,width]);
    translate([40-4,90+4,0])
      hull() for(Y=[0,100]) translate([0,Y,-1]) cylinder(d=8, h=width+2);
    for(Y=[100,125,150]){
      translate([28,Y,-1]) 
        cube([sq_nutY,sq_nutX,width+2], center=false);
        for(Z=[.25,.75]) translate([28,Y+sq_nutX/2,width*Z]) 
          rotate([0,90,0]) cylinder(d=3, h=20, center=true);
    }
  }
}