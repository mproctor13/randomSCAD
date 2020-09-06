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

corner(height=1,width=2);
//translate([20,120,-10]) rotate([90,0,0]) vslot20x40(100, vslot_color_black);
//translate([0,10,-10]) rotate([0,90,0]) vslot20x20(140, vslot_color_black);

//translate([10,10,-10]) rotate([0,0,0]) vslot20x20(140, vslot_color_black);


//roundedBox(20, 140, 1, 2.5, center=true);


