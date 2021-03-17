
length=10;
side=-1;
angle=2.5;
screw_hole=1.5;
thickness=3.25;
front_offset=-1;
back_offset=2.0;

translate([-10,0,0]) spacer();
translate([10,0,0]) spacer(side=1);

  
module spacer(side=-1){
  difference(){
    hull()
      for(X=[-1,1], Y=[-1,1])
        translate([5.5*X, ((thickness/2)-1)*Y, 0])
          cylinder(d=2, h=length, center=true, $fn=60);
//    %cube([13,4,length], center=true);
    translate([-10*side,0,2.5+length/2]) 
      rotate([0,angle*side,0]) 
        translate([10*side,0,0]) 
          cube([20,thickness+1,5], center=true);
    translate([10*side,0,2.5-length]) 
      rotate([0,angle*side,0]) 
        translate([-10*side,0,0]) 
          cube([20,thickness+1,5], center=true);
    translate([4.5*side,thickness-1,0])
      rotate([90,90*(side*-1),0])
          mirror([1,0,0]) 
        linear_extrude(1)
      text(text = str(back_offset), size=2, halign="center", valign="center");
  }
  translate([0,3.29+thickness/2,length/2-1.5-2]) rotate([0,90,0]) 
    difference(){
      hull(){
        translate([front_offset,0,0]) 
          cylinder(d=3, h=6, center=true, $fn=60);
        translate([0,-3.3,0]) 
          cube([6,.01,6], center=true);
      }
      cube([6,6.5,1.5], center=true);
      translate([front_offset,0,0]) 
        cylinder(d=screw_hole, h=8, center=true, $fn=60);
    }
  translate([0,3.2+thickness/2,-length/2]) rotate([0,90,0]) 
    difference(){
      hull(){
        translate([back_offset,0,0]) 
          cylinder(d=3, h=6, center=true, $fn=60);
        translate([-3.2,-3.2,0]) 
          cube([5,.1,6], center=true);
      }
      translate([back_offset,0,0]) 
        cylinder(d=screw_hole, h=8, center=true, $fn=60);
      for(X=[-1,1]) translate([back_offset,0,1.4*X])
        hull(){
          cylinder(d=4.2, h=1.2, center=true, $fn=60);
          translate([2,-1,0])
          cylinder(d=4.2, h=1.2, center=true, $fn=60);
        }
    }
}
