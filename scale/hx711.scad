
include <fhex.scad>

module hx711(){
  difference(){
    cube([20.6,34,1.5],center=true);
    for(X=[-1,1]) translate([14.5/2*X,12.08,0]) 
      cylinder(d=2.85,h=10,center=true);
  }
//  %translate([0,15.25,0]) cube([20.6,3.5,3.5],center=true);
}

module hx711_mount(part="studs"){
  if( part== "cutout" ){
    for(X=[-1,1]) translate([14.5/2*X,12.5,-5.5]){
      cylinder(d=3.3,h=10);
      translate([0,0,-0.35]) fhex(m3_hex_nut+0.2,m3_nut_height*1.5);
    } 
    translate([0,-22.5,-1]) rotate([0,90,90]) 
      ziptie_channel(width=2,depth=0,radius=5);
  }
  else if( part == "plug" ){
    for(X=[-1,1]) translate([14.5/2*X,12.5,-2.712])
      cylinder(d=5,h=0.3);
  }
  else{ // studs
    for(X=[-1,1]) translate([14.5/2*X,12.5,-5.5]){
      cylinder(d=5,h=5);
      cylinder(d=10,h=4);
    }
    translate([0,-12,-5.5]) cylinder(d=5,h=5);
    translate([-6,-26.5,-5.5]) cube([12,8,3]);
  }
}

module ziptie_channel(width=2,depth=0,radius=5){
  difference(){
    hull()
      for(X=[-1,1], Y=[-1,1]){ 
      translate([(width)*X,depth*Y,0]) cylinder(r=radius,h=5, center=true);
    }
    hull() 
    for(X=[-1,1], Y=[-1,1]){ 
      translate([(width)*X,depth*Y,0]) cylinder(r=radius-2,h=5+1, center=true);
    }
  }
}
