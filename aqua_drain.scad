
//drain(length=75, offset=0,offset_length=0); // strait 
drain(length=75, offset=20,offset_length=40); // side
module drain(length=75, offset=20,offset_length=40,d=24){
  coupler(d=d);
  translate([0,0,-length]) difference(){
    tube(length,offset,offset_length,d=d+2);
    tube(length,offset,offset_length,d=d-4);
  }
}

module coupler(d=23.8){
  difference(){
    cylinder(d1=d, d2=d-0.05, h=16.5);
    translate([0,0,-0.2]) cylinder(d=d-4, h=17);
  }
}

module tube(length=100, offset=20, offset_length=20, d=23.8){
  hull(){
    translate([0,0,length]) cylinder(d=d,h=0.1);
    translate([0,offset,length-offset_length]) cylinder(d=d,h=0.1); 
  }
  hull(){
    translate([0,offset,length-offset_length]) cylinder(d=d,h=0.1);
    translate([0,offset,0]) cylinder(d=d,h=0.1); 
  }
}