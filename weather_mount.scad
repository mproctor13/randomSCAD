

inside=32;
$fn=360;
translate([0,0,100])
difference(){
  cylinder(d=26,h=75);
  cylinder(d=20,h=76);
}

translate([0,0,70])
difference(){
  cylinder(d1=38, d2=26, h=30);
  cylinder(d1=32, d2=20, h=30);
}

difference(){
  cylinder(d=38,h=70);
  cylinder(d=32,h=72);
}