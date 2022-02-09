
sq_nutX=5.5;
sq_nutY=2;
offset=-31;

//assembly(offset);
//mmu();
//pinda_mount(offset);
//crtouch_mount();
include <../threads.scad>

include <../NewBearing/bearing_test.scad>


$fn=120;
nut();
//difference(){
//intersection(){
//  spool_mount();
//  translate([0,0,120]) cube([100,100,100], center=true);
//}
//  translate([0,0,100]) rotate([0,180,0]) nut();
//  cube([50,50,100]);
//}
//metric_thread (diameter=40, pitch=5, length=20, angle=50);
//translate([0,0,25 ]) metric_thread (diameter=40, pitch=4, length=20);

//spool_internal();

module nut(thread_dia=40,tangle=50){
  difference(){
    union(){
      cylinder(d=70, h=5);
      translate([0,0,5]) cylinder(d1=70, d2=thread_dia+2, h=20);
    }
    metric_thread(diameter=thread_dia+1, pitch=4, angle=tangle, length=50, square=false);
  }
}

module spool_internal(thread_dia=40,length=75,tangle=50){
  difference(){
    union(){
      translate([0,0,20]) cylinder(d=thread_dia-15,h=length+7);
      translate([0,0,10]) cylinder(d1=46,d2=thread_dia-15,h=10);
      translate([0,0,0]) cylinder(d=46,h=10);
    }
    translate([0,0,length+15]) cutout_race(diameter=13);
    translate([0,0,10]) rotate([0,180,0]) cutout_race(diameter=23);
    %translate([0,0,length/2-10]) cube([15,15,length], center=true);
  }
}

module spool_mount(thread_dia=40,length=75,tangle=50){
  difference(){
    union(){
      translate([0,0,25]) intersection(){
        union(){
          translate([0,0,length-5])
            cylinder(d1=thread_dia, d2=thread_dia-5, h=10);
          cylinder(d=thread_dia+5, h=length-5);
        }
        metric_thread(diameter=thread_dia, pitch=4, length=length, angle=tangle);
      }
      cylinder(d=70, h=5);
      translate([0,0,5]) cylinder(d1=70, d2=thread_dia+2, h=20);
    }
    translate([0,0,-1]) cylinder(d=thread_dia-14,h=length+27);
    translate([0,0,10]) cylinder(d=thread_dia-12,h=15+length-9);
    translate([0,0,length+15]) cutout_race(diameter=13);
    translate([0,0,10]) rotate([0,180,0]) cutout_race(diameter=23);
  }
}

module crtouch_mount(x_offset=0, z_offset=-4){
//%translate([12,-2,0]) rotate([90,0,180]) import("../../printer/address/WanhoaD6Bltouch.stl");
    rotate([90,0,0]){
    difference(){
      union(){
        hull(){
            for(X=[-1,1]) translate([15*X,0,-1]) 
                cylinder(d=6, h=3);
            translate([x_offset,z_offset+5,0.5]) 
              for(X=[-1,1]) translate([10*X,0,0]) 
                cylinder(d=6,h=3,center=true);
        }
        translate([-14+x_offset,z_offset,0]) hull(){
          translate([14,5,0.5]) for(X=[-1,1]) translate([11*X,0,0]) 
            rotate([0,0,0]) cylinder(d=6,h=3,center=true);
          translate([0,0,-1]) cube([28,3,3]);
        }
        translate([x_offset,0,0]) difference(){
          hull(){
            translate([-14,z_offset,0]) cube([28,3,2]);
            translate([0,z_offset+1.5,-9.5]) {
              for(X=[-1,1]) translate([11*X,0,0]) 
                rotate([90,0,0]) cylinder(d=6,h=3,center=true);
              cube([10,3,10], center=true);
            }
          }
          translate([0,z_offset,-4.5])
            cube([14,10,4],center=true);
          translate([0,z_offset,-3])
            for(X=[-1,1]) translate([9*X,0,-6]) 
                rotate([90,0,0]) cylinder(d=3.4,h=10,center=true);
        }
      }
      for(X=[-1,1]) translate([15*X,0,0]){
        cylinder(d=3.3, h=10,center=true);
        translate([0,0,-7]) cylinder(d=6, h=12,center=true);
      }
    }
  }
}

module crtouch_mount2(x_offset=0, z_offset=-4){
//%translate([12,-2,0]) rotate([90,0,180]) import("../../printer/address/WanhoaD6Bltouch.stl");
    rotate([90,0,0]){
    difference(){
      union(){
        hull(){
            for(X=[-1,1]) translate([15*X,0,-1]) 
                cylinder(d=6, h=3);
            translate([x_offset,z_offset+5,0.5]) 
              for(X=[-1,1]) translate([10*X,0,0]) 
                cylinder(d=6,h=3,center=true);
        }
        translate([x_offset,0,0]) difference(){
          hull(){
            for(X=[-1,1]) translate([15*X,0,-1]) 
              cylinder(d=6, h=3);
            translate([-14,z_offset,0]) cube([28,3,2]);
            translate([0,z_offset+1.5,-9.5]) {
              for(X=[-1,1]) translate([11*X,0,0]) 
                rotate([90,0,0]) cylinder(d=6,h=3,center=true);
              cube([8,3,10], center=true);
            }
          }
        }
        
      }
          for(X=[-1,1]) translate([15*X,0,-1]){
            translate([0,0,-10]) cylinder(d=6.2, h=10);
            translate([0,0,-2.5]) cylinder(d=3.3, h=6);
          }
          translate([0,5+z_offset,-3])
            cube([14,abs(z_offset)+5,4],center=true);
          translate([0,z_offset,-3])
            for(X=[-1,1]) translate([9*X,0,-6]) rotate([90,0,0]){
                cylinder(d=3.4,h=10,center=true);
                translate([0,0,-8]) cylinder(d=6.3,h=10,center=true);
            }
        for(X=[-1,1]) translate([15*X,0,0]) 
            cylinder(d=3.3, h=10,center=true);
    }
    translate([-14+x_offset,z_offset,0]) hull(){
      translate([14,5,0.5]) for(X=[-1,1]) translate([11*X,0,0]) 
        rotate([0,0,0]) cylinder(d=6,h=3,center=true);
      translate([0,0,-1]) cube([28,3,3]);
    }
  }
}

module bltouch_mount(x_offset=0, z_offset=-13){
//%translate([12,-2,0]) rotate([90,0,180]) import("../../printer/address/WanhoaD6Bltouch.stl");
    rotate([90,0,0]){
    difference(){
        hull(){
            for(X=[-1,1]) translate([15*X,0,-1]) 
                cylinder(d=6, h=3);
            translate([x_offset,z_offset+5,0.5]) 
              for(X=[-1,1]) translate([10*X,0,0]) 
                cylinder(d=6,h=3,center=true);
        }
        for(X=[-1,1]) translate([15*X,0,0]) 
            cylinder(d=3.3, h=10,center=true);
    }
    translate([-13+x_offset,z_offset,0]) hull(){
      translate([13,5,0.5]) for(X=[-1,1]) translate([10*X,0,0]) 
        rotate([0,0,0]) cylinder(d=6,h=3,center=true);
      translate([0,0,-1]) cube([26,3,3]);
    }
    translate([x_offset,0,0]) difference(){
      hull(){
        translate([-13,z_offset,0]) cube([26,3,2]);
        translate([0,z_offset+1.5,-9.5]) {
          for(X=[-1,1]) translate([10*X,0,0]) 
            rotate([90,0,0]) cylinder(d=6,h=3,center=true);
          cube([8,3,10], center=true);
        }
      }
      translate([0,z_offset,-3])
        cube([10,10,4],center=true);
      translate([-1,z_offset,-3])
        for(X=[-1,1]) translate([9*X,0,-6]) 
            rotate([90,0,0]) cylinder(d=3,h=10,center=true);
    }
  }
}

module mmu(){
  offset=12;
  difference(){
    import("MPMU_D6_Helix_e3D_Body_v1.stl");
    translate([0,offset,4]) 
    difference(){
        cube([60,sq_nutX,sq_nutY], center=true);
        cube([20,sq_nutX+1,sq_nutY+1], center=true);
    }
    for(X=[-1,1]) translate([15*X,offset,-2]) cylinder(d=3.3, h=10);
//    %translate([0,21,33]) cube([60,5.5,2], center=true);
  }
}

module pinda_mount(offset=-10, use_round=false){
    rotate([90,0,0])
    difference(){
        hull(){
            for(X=[-1,1]) translate([15*X,0,0]) 
                cylinder(d=6, h=2);
            for(X=[-1,1]) translate([9*X,offset,0]) 
                cylinder(d=6, h=2);
        }
        for(X=[-1,1]) translate([15*X,0,0]) 
            cylinder(d=3.3, h=10);
    }
    difference(){
        union(){
            hull(){
                translate([0,10,offset]) 
                    cube([18,1,6], center=true);
                translate([0,-0.5,(offset/2)]) 
                    cube([18,1,6+abs(offset)], center=true);
            }
            translate([0,10,offset]) 
                cylinder(d=18, h=6, center=true);
        }
        if( use_round ){
            translate([0,10,offset+abs(offset/2)+3]) 
                cylinder(d=16, h=abs(offset), center=true);
            translate([0,10,offset-abs(offset/2)-3]) 
                cylinder(d=16, h=abs(offset), center=true);
        }
        else{
            translate([0,10,offset+abs(offset/2)+1]) 
                fhex(12, abs(offset));
            translate([0,10,offset-abs(offset/2)-3]) 
                fhex(12, abs(offset));
        }
        translate([0,10,offset-4]) cylinder(d=8, h=8);
    }
}

module pinda(){
    color("black") cylinder(d=6.4, h=5);
    color("silver") translate([0,0,5]) cylinder(d=7.8, h=30);
    color("red") translate([0,0,35]) cylinder(d1=8.1, d2=4.77, h=25);
    color("black") translate([0,0,60]) cylinder(d=2.8, h=25);
    translate([0,0,10]) pinda_nut();
    translate([0,0,18]) pinda_nut();
}

module pinda_nut(){
    color("silver") rotate([0,0,0]) fhex(11.8,3.9);
}

module assembly(offset=-10){
  translate([0,-2,-12]) rotate([90,0,0])
    import("MPMU_D6_Helix_e3D_Body_v1.stl");
  translate([0,-2,-12]) rotate([90,0,0]) mmu();
  bltouch_mount();
//  pinda_mount(offset);
//  translate([0,10,-15+offset]) pinda();
}

m3_hex_nut=5.6;
m3_nut_height=2.25;
m4_hex_nut=7.2;
m4_nut_height=2.9;
m5_hex_nut=7.8;
m5_nut_height=3.9;

module fhex(wid,height){
  hull(){
    cube([wid/1.7,wid,height],center=true);
    rotate([0,0,120]) cube([wid/1.7,wid,height], center=true);
    rotate([0,0,240]) cube([wid/1.7,wid,height], center=true);
  }
}
