include <MCAD/shapes.scad>
include <vslot.scad>
//color([1,1,1]) %cube([140,140,5]);


module slot_fill(length = 20){
  difference(){
		translate([0, 0, 0]) rotate([0, 0, 0])
		 cylinder(r=4.5, h=length, center=true,  $fn=4);	

//plane sides
		translate([-3.8, 0, 0]) rotate([0, 0, 0])
		 cube([4, 20, length*2], center=true);
		translate([3, 0, 0]) rotate([0, 0, 0])
		 cube([6, 20, length*2], center=true);
  }
}

module corner(height=1,width=1){
  offset=2.5;
  thickness=2.5;
  radius=5;
  size=140;
  difference(){
    union(){
      hull(){
        translate([10*width,size/2,0.5]) roundedBox(20*width,size,1, 2.5);
        translate([size/2,10*height,0.5]) roundedBox(size,20*height,1, 2.5);
        translate([offset,offset,thickness]) sphere(d=radius, $fn=30);
        translate([offset,size-offset,thickness]) sphere(d=radius, $fn=30);
        translate([(width*20)-offset,size-offset,thickness]) sphere(d=radius, $fn=30);

        translate([size-offset,offset,thickness]) sphere(d=radius, $fn=30);
        translate([size-offset,(height*20)-offset,thickness]) sphere(d=radius, $fn=30);
      }
      for(i=[10 : 20 : (20*height)]){
        translate([(size/2)+(10*width),i,0]) rotate([0,-90,0]) slot_fill(length=size-10-(20*width));
      }
      for(i=[10 : 20 : (20*width)]){
        translate([i,(size/2)+(10*height),0]) rotate([90,-90,0]) slot_fill(length=size-10-(20*height));
      }
    }
    translate([10,10,1]) cylinder(d=5, h=thickness+radius+1, center=true,  $fn=30);
    ylength=size-10-(20*height);
    for(X=[10 : 20 : (20*width)], Y=[5 : ylength/3 : ylength]){
      translate([X,(20*height)+15+Y,1]) cylinder(d=5, h=thickness+radius+1, center=true,  $fn=30);
    }
    xlength=size-10-(20*width);
    for(Y=[10 : 20 : (20*height)],X=[5 : xlength/3 : xlength]){
      translate([(20*width)+15+X,Y,1]) cylinder(d=5, h=thickness+radius+1, center=true,  $fn=30);
    }
  }
}

difference(){
  union(){
    difference(){
      translate([0, 0,0.75+3.5+6.4+10]) color([.75,.75,.75]) cylinder(d=5.95, h=13, center=true,  $fn=30);
      translate([0, 4,0.75+3.5+6.4+11.6]) cube([10, 5, 10], center=true);
    }
      
    translate([0, 0,0.75+3.5+6.4]) color([.75,.75,.75]) cylinder(d=6.75, h=7, center=true,  $fn=30);
    translate([0, 0, 0.75+3.2]) color([.75,.75,.75]) cube([11.77, 11.9, 6.4], center=true);
    translate([-1.265, -2.9, 0.75]) color([.25,.25,.25]) cube([18.5, 26, 1.5], center=true);
      
    translate([-0.6, -13.8, 1.2+0.75]) color([0,0,0]) cube([12.8, 2.4, 2.4], center=true);
    for(X=[-6,-3.5,-0.6,2,4.5]){
      translate([X, -13.8-3.15, 3.8]) color([0.7,0.7,0.7]) cube([0.6, 6.3, 0.6], center=true);
    }
  }
  translate([-8.32, 5.6, 0.75]) cylinder(d=2.55, h=1.7, center=true,  $fn=30);
  translate([-8.32, -8.15, 0.75]) cylinder(d=2.55, h=1.7, center=true,  $fn=30);
}
/*
13
9.25
5.95+4.15

2.9

5.9
*/