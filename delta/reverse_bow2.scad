difference(){
  union(){
    translate([1.25,10,25]) cube([2.5,20,50],center=true);
    translate([-7.5,10,48.75]) cube([20,20,2.5],center=true);
    translate([-7.5,-1.25,40]) cube([20,2.5,20],center=true);
    hull(){
      translate([-7.5,-1.25,48.75]) cube([20,2.5,2.5],center=true);
      translate([-40,-45,48.75]) cylinder(d=20, h=2.5, center=true, $fn=120);
    }
    translate([-40,-45,28.75]) rotate([0,90,0]) cylinder(d=5, h=1, center=true, $fn=120);
    translate([-7.5,-5,45]) rotate([0,90,90]) cylinder(d=10, h=1, center=true, $fn=120);
  }
  translate([-40,-45,50]) rotate([0,0,0]) cylinder(d=5.7, h=11, center=true, $fn=60);
}