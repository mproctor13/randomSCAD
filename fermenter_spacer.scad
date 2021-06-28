$fn=120;

//spacer();
//air_lock_holder();
adapter();

module spacer(){
    difference(){
        cylinder(d=55, h=25, center=true);
        cylinder(d=38.5, h=27, center=true);
    }
}

module air_lock_holder(){
    difference(){
        hull(){
            cylinder(d=40, h=15, center=true);
            translate([0,30,0]) cube([40,1,15], center=true);
        }
        translate([0,0,5]) cylinder(d=35, h=15, center=true);
        translate([0,0,-5]) cylinder(d=13, h=7.5, center=true);
        
        translate([0,22.5,-5]) cube([45, 5, 15],center=true);
//        %hull(){
//            translate([0,22.5,2.5]) rotate([0,90,0]) 
//                cylinder(d=5, h=45, center=true);
//            translate([0,22.5,-10]) rotate([0,90,0]) 
//                cylinder(d=5, h=45, center=true);
//        }
    }
}

module adapter(length=8){
  
  difference(){
    union(){
      translate([0,0,25]) cylinder(d=9.8,h=20, center=true);
      translate([0,0,30]) cylinder(d1=11.80, d2=9.50,h=10, center=true);
      translate([0,0,24]) cylinder(d2=11.80, d1=9.50,h=2, center=true);
      cylinder(d=25,h=10,$fn=6);
      translate([0,0,10]) cylinder(d1=20, d2=10,h=5);
//      %cylinder(d=25,h=15);
    }
    cylinder(d=5, h=100, center=true);
    translate([0,0,-0.1]) cylinder(d1=13.4,d2=13.2,h=length);
    translate([0,0,length-0.2]) cylinder(d1=13.2,d2=4,h=3);
//    cube([100,100,100]);
  }
}