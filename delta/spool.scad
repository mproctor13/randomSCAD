include <MCAD/shapes.scad>
include <slot_fill.scad>


module fhex(wid,height){
  hull(){
    cube([wid/1.7,wid,height],center=true);
    rotate([0,0,120]) cube([wid/1.7,wid,height], center=true);
    rotate([0,0,240]) cube([wid/1.7,wid,height], center=true);
  }
}

module bearing(dia=22,hole=8,thinkness=7){
  color("silver")
  difference(){
    cylinder(d=dia, h=thinkness, $fn=60, center=true);
    cylinder(d=hole, h=thinkness+0.2, $fn=60, center=true);
  }
}

module refill3d_spool(){
  color("white")
  difference(){
    union(){
      translate([0,0,-45]) cylinder(d=160, h=3.0, $fn=360, center=true);
      translate([0,0,0]) cylinder(d=50, h=90, $fn=360, center=true);
      translate([0,0,45]) cylinder(d=160, h=3.0, $fn=360, center=true);
    }
    translate([0,0,0]) cylinder(d=32, h=93.2, $fn=360, center=true);
  }
}

module filament_spool(){
  color("black")
  difference(){
    union(){
      translate([0,0,-30]) cylinder(d=205, h=3.85, $fn=360, center=true);
      translate([0,0,0]) cylinder(d=90, h=64, $fn=360, center=true);
      translate([0,0,30]) cylinder(d=205, h=3.85, $fn=360, center=true);
    }
    translate([0,0,0]) cylinder(d=54, h=64.2, $fn=360, center=true);
  }
}

module spool_holder(printable=false, version=1){
  difference(){
    union(){
      translate([0,0,3]) cylinder(d=125, h=6, $fn=360, center=true);
      translate([0,0,10]) cylinder(d=25, h=20, $fn=90, center=true);
        
      intersection(){
        translate([0,0,12.5]) cylinder(d=30, h=15, $fn=90, center=true);
        translate([0,0,12.5]) cube([15,40,15], center=true);
      }
      intersection(){
        translate([0,0,12.5]) cylinder(d=30, h=15, $fn=90, center=true);
        translate([0,0,12.5]) cube([40,15,15], center=true);
      }
    }
    
    
    translate([0,0,85]) cylinder(d=9, h=180, $fn=90, center=true);
    translate([0,0,3]) cylinder(d=22.6, h=8, $fn=90, center=true);
    translate([0,0,5]) cylinder(d=15, h=18, $fn=90, center=true);
    translate([0,0,17]) cylinder(d=22.6, h=8, $fn=90, center=true);
//    translate([0,0,15]) cylinder(d=20, h=8, $fn=90, center=true);
    
    translate([0,0,4]) 
    difference(){
      cylinder(d=110, h=10, $fn=90, center=true);
      cylinder(d=40, h=10.02, $fn=90, center=true);
    
      cube([115,10,10.02], center=true);
      cube([10,115,10.02], center=true);
    }
    if(version==2){
      difference(){
        translate([0,0,3]) cylinder(d=126, h=12, $fn=90, center=true);
        translate([0,0,3]) cylinder(d=40.1, h=14, $fn=90, center=true);
      }
    }
  }
  
  if(printable){
    translate([0,0,7.15]) cylinder(d=23, h=0.3, $fn=30, center=true);
//    translate([0,0,9.15]) cylinder(d=12, h=0.3, $fn=30, center=true);
  }
}


module spool_arm(type=2){
  difference(){
    union(){
      translate([0,0,8.5]) cylinder(d=20, h=16, $fn=60, center=true);
      hull(){
        for(X=[-10,10], Y=[-10,10], Z=[2,12]){
          translate([X,Y,Z]) sphere(d=4, $fn=30, center=true);
        }
        for(X=[5,-5], Y=[120], Z=[2,8]){
           translate([X,Y,Z]) sphere(d=4, $fn=30, center=true);
        }
      }
      hull(){
        translate([0,115,70]) sphere(d=12,center=true);
        translate([0,115,4]) cylinder(d=12, h=1, $fn=60, center=true);
      }
    }
    translate([0,0,1.5]) cylinder(d=8.01, h=4.2, $fn=60, center=true);
    if(type==1){
      translate([0,123,65]) rotate([90,0,0]) cylinder(d1=20, d2=13, h=10, $fn=60, center=true);
      translate([0,115,65]) rotate([90,0,0]) cylinder(d=5.5, h=20, $fn=60, center=true);
    }
    else if(type==2){
      translate([-5,120,65]) rotate([90,0,45]) cylinder(d1=20, d2=13, h=10, $fn=60, center=true);
      translate([0,115,65]) rotate([90,0,45]) cylinder(d=5.5, h=20, $fn=60, center=true);
    }
    translate([0,0,13.5]) fhex(12.3,20);
  }
}

module spool_assembly_holders(offset=30){
  translate([0,0,0]) rotate([0,90,0]) bearing();
  translate([3,0,0]) rotate([0,90,180]) spool_holder();
  translate([-14,0,0]) rotate([0,90,0]) bearing();
}

module coupler(){
  //11.82x29.48
  difference(){
    fhex(12,29.5);
    cylinder(d=7,h=30, $fn=60, center=true);
  }
}

module spool_nut(printable=false){
//  translate([0,0,5]) coupler();
  difference(){
    union(){
//      translate([0,0,17.5]) cylinder(d1=45, d2=10, h=15, $fn=120, center=true);
      translate([0,0,5]) cylinder(d=35,h=10, $fn=120, center=true);
      for(R=[0,120, 240]){
        hull(){
          translate([0,0,5]) cylinder(d=20,h=10, $fn=60, center=true);
          rotate([0,0,R]) translate([40,0,5]) cylinder(d=20,h=10, $fn=60, center=true);
        }
      }
    }
    translate([0,0,14]) cylinder(d=8,h=30,$fn=60,center=true);
    translate([0,0,5]) fhex(12.3,29.5);
  }
  if(printable){
    translate([0,0,19.9]) cylinder(d=12, h=0.3, $fn=30, center=true);
  }
}

module standard_spool(fudge=1.5,printable=true,type=1){
  difference(){
    union(){
      translate([0,0,2]) cylinder(d=60, h=4, $fn=90, center=true);
      if(type==1){
        translate([0,0,14]) cylinder(d=56, h=20, $fn=90, center=true);
      }
      else if(type==2){
        translate([0,0,14]) cylinder(d=50, h=20, $fn=90, center=true);
      }
      else if(type==3){
        translate([0,0,14]) cylinder(d1=56, d2=50, h=20, $fn=120, center=true);
      }
    }
    translate([0,0,0]) cylinder(d=40+fudge, h=14, $fn=90, center=true);
    union(){
      intersection(){
        translate([0,0,12.5+fudge]) cylinder(d=30+fudge, h=15, $fn=90, center=true);
        translate([0,0,12.5+fudge]) cube([15+fudge,40,15], center=true);
      }
      intersection(){
        translate([0,0,12.5+fudge]) cylinder(d=30+fudge, h=15, $fn=90, center=true);
        translate([0,0,12.5+fudge]) cube([40,15+fudge,15], center=true);
      }
      translate([0,0,11.5]) cylinder(d=25+fudge, h=20, $fn=90, center=true);
    }
    translate([0,0,25]) cylinder(d=22, h=10, $fn=90, center=true);
  }
  if(printable){
    translate([0,0,7.15]) cylinder(d=40, h=0.3, $fn=30, center=true);
    translate([0,0,21.15]) cylinder(d=23, h=0.3, $fn=30, center=true);
  }
}

module pb_mount(){
//    translate([0,0,15]) %cube([90,15,30], center=true);
  R=2;
  difference(){
    hull(){  
      for(X=[-(95/2)+R,(95/2)-R], Y=[-7.5+R,7.5-R], Z=[0+R,30-R]){
        translate([X,Y,Z]) sphere(d=4,$fn=30);
      }
    }
    translate([-40.5,0,18]) rotate([90,0,0]) cylinder(d=3.4, h=16, $fn=30, center=true);
    translate([40.5,0,18]) rotate([90,0,0]) cylinder(d=3.4, h=16, $fn=30, center=true);
    for(X=[-25,25]){
      hull(){
        translate([X,0,5]) rotate([90,0,0]) cylinder(d=10, h=16, $fn=30, center=true);
        translate([X,0,-5]) rotate([90,0,0]) cylinder(d=10, h=16, $fn=30, center=true);
      }
    }
    translate([0,6,15]) rotate([90,0,0]) fhex(12.3,10);
    translate([0,0,15]) rotate([90,0,0]) cylinder(d=8.5, h=16, $fn=30, center=true);
  }
}

module spool_assembly(type=1){
  translate([-80,0,0]) rotate([0,90,0]) color("silver") cylinder(d=8, h=160, $fn=60, center=true);
  
  translate([-5,0,0]) rotate([0,90,0]) color("silver") fhex(13,7);
  translate([-12.5,0,0]) rotate([0,270,0]) spool_arm();
  translate([-20.1,0,0]) rotate([0,90,0]) color("silver") fhex(13,7);
  translate([-27.2,0,0]) rotate([0,90,0]) color("silver") fhex(13,7);
  
  translate([-35,0,0]) 
  if(type == 1){
    spool_assembly_holders();
    translate([-37,0,0]) rotate([0,90,180]) filament_spool();
    translate([-73,0,0]) rotate([0,0,180]) spool_assembly_holders();
    translate([-102,0,0]) rotate([0,90,0]) spool_nut();
  }
  else if(type == 2){
    spool_assembly_holders();
    translate([-50,0,0]) rotate([0,90,180]) refill3d_spool();
    translate([-100,0,0]) rotate([0,0,180]) spool_assembly_holders();
    translate([-130,0,0]) rotate([0,90,0]) spool_nut();
  }
}




module spool_mount_2020(){
  difference(){
    union(){
      translate([-10,20,42.5])
      hull(){
        for(Y=[-1,1], Z=[-1,1]){
          translate([10,5*Y,20*Z]) rotate([0,90,0]) cylinder(d=10, h=20, center=true, $fn=30);
          translate([10,5*Y,20*Z]) rotate([0,90,0]) cylinder(d=10, h=20, center=true, $fn=30);
        }
      }
      translate([0,12,42])
      hull(){
        for(Z=[-1,1]){
          translate([0,0,40*Z]) rotate([0,90,0]) cylinder(d=5, h=20, center=true, $fn=30);
        }
      }
      translate([0,9.5,42]) rotate([0,0,90]) slot_fill(length=78);
    }

    translate([0,14,42]) rotate([90,90,0]) fhex(12.3,15);
    translate([0,20,42]) rotate([90,0,0]) cylinder(d=8.5, h=25, $fn=30, center=true);
    
    translate([0,10,75]) rotate([90,0,0]) cylinder(d=6, h=10, center=true, $fn=30);
    translate([0,10,10]) rotate([90,0,0]) cylinder(d=6, h=10, center=true, $fn=30);
  }
}

//spool_mount_2020();
//pb_mount();
//spool_nut(printable=true);
//spool_assembly(type=2);
//spool_arm();
//standard_spool(printable=true,type=3);
spool_holder(printable=false,version=2);
//rotate([90,0,0]) pb_mount();
//spool_assembly_holders();


