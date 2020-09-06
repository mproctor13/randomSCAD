include <MCAD/shapes.scad>
//color([1,1,1]) %cube([140,140,5]);

module slot_fill(length = 20) {
	difference() {
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
  size=140;
  hull(){
    translate([10*width,size/2,0.5]) roundedBox(20*width,size,1, 2.5);
    translate([size/2,10*height,0.5]) roundedBox(size,20*height,1, 2.5);
    translate([offset,offset,thickness]) sphere(d=5, $fn=30);
    translate([offset,size-offset,thickness]) sphere(d=5, $fn=30);
    translate([(width*20)-offset,size-offset,thickness]) sphere(d=5, $fn=30);

    translate([size-offset,offset,thickness]) sphere(d=5, $fn=30);
    translate([size-offset,(height*20)-offset,thickness]) sphere(d=5, $fn=30);
  }
  translate([45+(20*width),10,0]) rotate([0,-90,0]) slot_fill(length=size-10-(20*width));
}

corner(height=1,width=2);



//roundedBox(20, 140, 1, 2.5, center=true);


