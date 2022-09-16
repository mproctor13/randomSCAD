// Download back from: https://github.com/bigtreetech/Raspberry-Pad/tree/master/Pad5/3D
// Download logo from: https://www.printables.com/model/14260-raspberry-pi-logo-fixed/files

pi_back();

module pi_back(){
  difference(){
    blank();
    translate([40,-45,-4]) rotate([0,0,180])
      scale([0.4,0.4,0.4]) import("raspberrylogo_fixed-sharp-edge.stl");
  }
}

module blank(){
  translate([0,0,18]) rotate([180,0,0]) import("Pad5-Backboard.STL");
  translate([25.5,-75,0]) cube([28,55,1]);
}