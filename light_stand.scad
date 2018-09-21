$fn=120;
translate([0, 0, 10.1]) cube([80, 20, 0.2], center=true);
difference(){
  union(){
    hull(){
      translate([75, 50, 0]) cylinder(d=30, h=5);
      translate([-75, -50, 0]) cylinder(d=30, h=5);
//      cylinder(d=100, h=5);
//      translate([0, 0, 10]) cube([90, 20, 20], center=true);
      for(X=[-35,35]) translate([X, 0, 10]) cylinder(d=12, h=20, center=true, $fn=60);
    }
    hull(){
      translate([75, -50, 0]) cylinder(d=30, h=5);
      translate([-75, 50, 0]) cylinder(d=30, h=5);
//      cylinder(d=100, h=5);
//      translate([0, 0, 10]) cube([90, 20, 20], center=true);
      for(X=[-35,35]) translate([X, 0, 10]) cylinder(d=12, h=20, center=true, $fn=60);
    }
  }
  for(X=[-35,0,35]) translate([X, 0, 10]) cylinder(d=6, h=30, center=true, $fn=60);
  for(X=[-35,0,35]) translate([X, 0, -1]) cylinder(d=15, h=11, $fn=60);
}

//for(X=[-1,1], Y=[-1,1]) translate([75*X, 50*Y, 0])
//cylinder(d=35, h=5, $fn=60);

