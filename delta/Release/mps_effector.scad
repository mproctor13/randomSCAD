
module tabs(){
  for(y=[1,-1]){
    translate([17, 11*y, 0]) 
    union(){
      difference(){
        hull(){
          translate([-3, -3, 0]) cube([6,6,10]);
          translate([0, 12*y, 0]) cylinder(r=3, h=10, center=false, $fn=60);
          translate([-12, 12*y, 0]) cylinder(r=3, h=10, center=false, $fn=60);
        }
        translate([-10, 8*y, 5]) color([0,0,0]) rotate([0, 90, 0]) cylinder(r=2.2, h=15, center=false, $fn=60);
      }
      translate([12, 8*y, 5]) sphere(d=10, $fn=60);
      //translate([-8, 8*y, 5]) color([0,0,0]) rotate([0, 90, 0]) cylinder(r=2.2, h=15, center=false, $fn=60);
    }
  }
}

//PolyStroooder Tri Hotend mount hole shape
module mountHole() 
{
    union() 
    {
        hull() 
        {
            for (a = [90:120:360]) 
            {
                rotate([0, 0, a])
                translate([11.5, 0, 0])
                square([1, 5], center=true);
            }
        }
     
        for (a = [10:120:360]) 
        {
            rotate([0, 0, a]) 
            {
                translate([0, 11.7, 0])
                circle(r=1, center=true, $fn=15);
            }
            rotate([0, 0, a-20]) {
                translate([0, 11.7, 0])
                circle(r=1, center=true, $fn=15);
            }
        }
    }
}

module mount_tubes(){
  rotate([0,-90,0])
  union(){
    difference(){
      union(){
          for(y=[1,-1]){
            translate([22, 19*y, 5]) rotate([0, 90, 0]) cylinder(d=8, h=6, center=false, $fn=60);
          }
      }
      for(y=[1,-1]){
        translate([15, 19*y, 5]) rotate([0, 90, 0]) cylinder(r=2.2, h=15, center=false, $fn=60);
      }
    }
  }
}

rotate([0,50,0]) translate([10, 0, -10]) mount_tubes();
rotate([0,50,120]) translate([10, 0, -10]) color([0,0,0]) mount_tubes();
rotate([0,50,240]) translate([10, 0, -10]) color([0,0,1]) mount_tubes();


difference(){
  rotate([0, 0, 60]) cylinder(r=29, h=10, center=false, $fn=3);
  translate([00, 0, -2]) rotate([0, 0, -30]) linear_extrude(h=5) mountHole();
}

difference(){
  cylinder(d=60, h=2, center=false, $fn=60);
  translate([0, 0, -1]) cylinder(d=50, h=4, center=false, $fn=60);
}