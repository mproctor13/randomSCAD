$fn=120;

tank_dia=134.5;
height=100;
width=300;

translate([75,75,0]) rotate([0,0,45]) tank_stand();
//%cube([250,250,10]);
//%cube([300,300,10]);
//height=5;
//  difference(){
//      cylinder(d=134+10, h=height);
//    translate([0,0,-1]) cylinder(d=134, h=height+5);
//  }

module tank_stand(){
  difference(){
    hull(){
      cylinder(d=134+10, h=height);
      translate([width-50,0,0]) cylinder(d=75, h=10);
    }
    translate([0,0,5]) cylinder(d=134, h=height);
  }
}
