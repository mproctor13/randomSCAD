$fn=60;
//vesa_mount_holes();

translate([50,50,0]){
    difference(){
        hull(){
            cylinder(d=10, h=2);
            translate([0,10,27.5]) cube([10,1,55], center=true);
            translate([0,85,27.5]) cube([10,1,55], center=true);
        }
        translate([-6,12.5,5]) cube([12,69,45]);
        translate([0,0,2]) cylinder(d=9, h=100);
        translate([0,0,0]) cylinder(d=4.5, h=100, center=true);
    }
}

module vesa_mount_holes(hole_seperation=100, hole_dia=4.5, hole_height=10){
  for(X=[-1,1], Y=[-1,1]){
    translate([hole_seperation/2*X, hole_seperation/2*Y, 0])
      cylinder(d=hole_dia, h=hole_height, center=true);
  }
}


