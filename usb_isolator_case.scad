
top();
//%bottom();

module top(){
  difference(){
    translate([0,0,6.5]) cube([28.5, 45.5, 13], center=true);
    translate([0,0,5]) cube([26.5, 43.5, 14], center=true);
    
    translate([0,20,4.5-3.25]) 
      cube([12.4, 10, 15], center=true);
    translate([2,-20,6]) cube([15, 10, 12], center=true);
    
    translate([7.25,10.75,11.5]) cube([5,10,2]);
    translate([-11.25,-6.5,11.5]) cube([8,13,2]);
  }
}

module bottom(){
  difference(){
    translate([0,0,6]) cube([26, 43, 12], center=true);
    translate([0,0,8.5]) cube([24, 41, 14], center=true);
    
    translate([0,20,7.5+4]) cube([12.4, 10, 15], center=true);
    translate([2,-20,7.5+5]) cube([15, 10, 15], center=true);
  }
}