
translate([0,0,135])
%difference(){
rotate([0,90,0]) cylinder(r=115, h=20, center=true, $fn=60);
rotate([0,90,0]) cylinder(d=8, h=25, center=true, $fn=60);
}

difference(){
  union(){
    hull(){
      for(Y=[-1,1]) translate([0,10*Y,0])
      rotate([0,90,0]) cylinder(d=20, h=10, center=true, $fn=60);
      translate([0,0,135]) rotate([0,90,0]) cylinder(d=40, h=10, center=true, $fn=60);
    }
    hull(){
      for(Z=[-1,1], Y=[-1,1]) {
        translate([0,16*Y,10]) rotate([0,90,0]) cylinder(d=8, h=20, center=true, $fn=60);
        translate([0,16*Y,-6]) rotate([0,90,0]) cylinder(d=8, h=20, center=true, $fn=60);
      }
    }
  }
  cube([40,20.2,20.2],center=true);
  
  hull() for(Z=[135,155]){
    translate([0,0,Z]) rotate([0,90,0]) cylinder(d=12.5, h=25, center=true, $fn=60);
  }
  translate([0,-8,0]) rotate([0,90,0]) cylinder(d=8, h=25, center=true, $fn=60);
  translate([0,15,0]) rotate([90,0,0]) cylinder(d=5, h=15, center=true, $fn=60);
  translate([0,20,0]) rotate([90,0,0]) cylinder(d=12, h=5, center=true, $fn=60);
}





