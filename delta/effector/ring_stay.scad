
module ring_stay(){
  difference(){
    union(){
      hull(){
        translate([0, 0, 0]) cylinder(r1=4, r2=3.5, h=2, center=false, $fn=60);
        translate([-16, 0, 0]) cylinder(r1=4, r2=3.5, h=2, center=false, $fn=60);
      }
      translate([0, 0, 0]) cylinder(r1=4, r2=3, h=4, center=false, $fn=60);
      translate([-16, 0, 0]) cylinder(r1=4, r2=3, h=4, center=false, $fn=60);
      hull(){
        translate([-8, 10, 0]) cylinder(r1=2, r2=1.5, h=2, center=false, $fn=60);
        translate([-8, 0, 0]) cylinder(r1=2, r2=1.5, h=2, center=false, $fn=60);
      }
      hull(){
        translate([-8, 7, 2]) cylinder(r1=1.5, r2=1, h=1.5, center=false, $fn=60);
        translate([-8, 0, 2]) cylinder(r1=1.5, r2=1, h=1.5, center=false, $fn=60);
      }
    }
    translate([0, 0, -0.5]) cylinder(r=2, h=6, center=false, $fn=60);
    translate([-16, 0, -0.5]) cylinder(r=2, h=6, center=false, $fn=60);
  }
}

ring_stay();