
thickness=3;
$fn=60;

use <xy_printer/vslot.scad>

%translate([-125,40,-10-thickness/2]) rotate([90,0,90]) vslot20x40(250);
pi_mount();

module pi_mount(dem=[29,24.5], yoffset=20, xoffset=-10){
  difference(){
    union(){
      translate([xoffset,yoffset+5,0])
      hull() for(X=[-1,1], Y=[-1,1]) 
        translate([dem[0]*X,dem[1]*Y,0])
          cylinder(d=10, h=thickness, center=true);
      translate([0,40,0])
      hull() for(X=[-1,1], Y=[-1,1]) 
        translate([(dem[0]+20)*X,10*Y,0])
          cylinder(d=10, h=thickness, center=true);
    }
    
    translate([xoffset,yoffset+5,0])
    for(X=[-1,1], Y=[-1,1]) 
      translate([dem[0]*X,dem[1]*Y,0])
        cylinder(d=3.3, h=thickness+1, center=true);
    translate([0,40,0]) for(X=[-1,1], Y=[-1,1]) 
      translate([(dem[0]+20)*X,10*Y,0])
        cylinder(d=5, h=thickness+1, center=true);
    translate([xoffset,yoffset+5,0]) 
    hull() for(X=[-1,1], Y=[-1,1]) 
      translate([(dem[0]-8)*X,(dem[1]-8)*Y,0])
        cylinder(d=10, h=thickness+1, center=true);
  }
  translate([xoffset,0,0])
  for(X=[-1,1]) hull(){
    translate([(dem[0]+1)*X,19.5,-10]) 
      cube([6,1,19],center=true);
    translate([(dem[0]+1)*X,-dem[1]+yoffset+10,-1]) 
      cube([6,1,1],center=true);
  }
}