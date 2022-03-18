
sq_nutX=5.5;
sq_nutY=2;
offset=-31;

//assembly(offset);
//mmu();
//pinda_mount(offset);
//crtouch_mount();
include <../threads.scad>

include <../NewBearing/bearing_test.scad>


$fn=$preview ? 30 : 120;

//mmu_cover();
//crtouch_mount();
//%bltouch_mount(x_offset=0, z_offset=-4);

mmu_clip();
module mmu_clip(width=7.4,offset=7){
  %translate([-24.75,0,0]) import("../../d6/d6_ribbon_cable_clip_v2.stl");
  difference(){
    union(){
      translate([-24.75,0,0]) import("../../d6/d6_ribbon_cable_clip_v2.stl");
      hull(){
        for(X=[-1,1]) translate([18.5*X,21+offset,0]) cylinder(d=3,h=width);
        for(X=[-1,1]) translate([23*X,21,0]) cylinder(d=3,h=width);
      }
    }
//    %translate([0,24,3.5]) cube([32,4,8],center=true);
    for(X=[-1,1]) translate([22*X,20,width-1.8]) linear_extrude(height=2) text(text=str(offset),size=3,halign="center");
    hull(){
      for(X=[-1,1]) translate([15.5*X,18+offset,-0.1]) 
        cylinder(d=3,h=width+0.2);
      for(X=[-1,1]) translate([20*X,18,-0.1]) 
        cylinder(d=3,h=width+0.2);
    }
  }
  for(X=[-1,1]) translate([28.5*X,4,0])
    hull() for(Y=[-1,1]) translate([0,1*Y,-0.1]) cylinder(d=3,h=width);
  
}

module mmu_cover(){
  difference(){
    union(){
      translate([5,-12,0]) import("MPMU_D6_Helix_e3D_HotendCover_v1.stl");
      translate([0,0.5,13]) cube([10,10,sq_nutY+0.5], center=true);
    }
    cylinder(d=3.3,h=20);
    translate([0,5.5,10.5]) cube([sq_nutX+0.5,20,sq_nutY+0.5], center=true);
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
