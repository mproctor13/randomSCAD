inside_offset=0.5;
$fn=360;

top();
//inside();
//bottom();
//screen_mount();
    
//cube([30, 43.2, 1], center=true);
//translate([0,0,79.8]) rotate([0,0,90]) screen_mount();


//use <../PiZero.scad>
//translate([-6,-10,40]) rotate([0,90,0]){
//  PiZeroBody();
//  PiGPIO(1);
//}

module top(){
  intersection(){
    model();
    translate([0,0,62.7]) cylinder(d=70.8,h=66.55);
  }
}

module bottom(){
  difference(){
    intersection(){
      model();
      cylinder(d=80,h=66.55);
    }
    translate([0,0,62.7]) cylinder(d=70.95,h=66.55);
  }
}

module screen_mount(){
  difference(){
    cylinder(d=66-inside_offset,h=5);
    translate([0,0,3.5]) cube([25,50,5], center=true);
    for(Y=[-1,1]) translate([0,29*Y,3.5])
      cube([37,10,5], center=true);
    for(X=[-1,1]) translate([18*X,0,3.5])
      cube([1,50,5], center=true);
    translate([0,0,0.8+1]) cube([36,43.35,1.6], center=true);
      
    translate([0,43.35/2-0.55-1.5,0]) cube([28.5,3,5], center=true);
    cube([22,25,5], center=true);
    hull() for(Y=[-1,1])
      translate([0,Y*20,6]) rotate([55*Y,0,0]) cube([36,5,5], center=true);
  }
  
}

module inside(){
  difference(){
    union(){
      translate([0,0,10]) cylinder(d=66-inside_offset,h=63);
      translate([0,0,2]) 
        cylinder(d1=41.8-inside_offset,d2=66-inside_offset,h=10);
    }
    translate([0,-15,43]) cube([20,40,75], center=true);
    translate([15,-15,43+6]) cube([13,40,50], center=true);
    rotate([0,0,90]){
        hull() for(Y=[-1,1])
          translate([0,Y*20,79]) rotate([55*Y,0,0]) cube([36,5,5], center=true);
        translate([0,0,75.6]) cube([25,50,5], center=true);
        translate([0,0,0.8+74]) cube([36,43.35,1.6], center=true);
      
    }
    difference(){
      translate([0,0,11]) cylinder(d=63.8,h=68);
      translate([0,-14,43]) cube([22,40,75], center=true);
      translate([16,-9,37]) cube([13,30,72], center=true);
    }
    for(Y=[-21.5,1.5], Z=[69, 11])
      translate([0,Y,Z]) rotate([0,90,0]) 
        cylinder(d=2.5, h=100, center=true);
    
    for(Y=[-21.5,1.5], Z=[69, 11])
      translate([-23.5,Y,Z]) rotate([0,90,0]) 
        cylinder(d=6, h=25, center=true);
  }
}

module model(){
  difference(){
    body();
    translate([0,0,91.5]) cube([30,30,15], center=true);
    translate([0,0,10]) cylinder(d=66,h=77);
    translate([0,0,2]) cylinder(d1=42,d2=66,h=10);
    difference(){
      hull() for(Y=[-1,1])
        translate([0,5*Y,93.5]) rotate([0,90,0]) 
          cylinder(d=8, h=100, center=true);
      cylinder(d=66, h=100);
    }
    translate([0,-25,40]) cube([20,30,55], center=true);
  }
}

module body(scaling=1.1){
  rotate_extrude(angle=360) 
  scale([scaling,scaling,scaling]) difference(){
    rotate([0,0,90]) import("keg.dxf");
    square(100);
  }
}
module outline(){
projection(cut=true) rotate([90,0,0])
rotate([0,90,0])
  scale([4,4,4])
  import("Keg1a.stl");
}