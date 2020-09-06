
length=140;
width=130;
side_height=5;
side_width=2;
height=5;

module base_module(length=140, width=130, side_height=5, side_width=2, height=5) {
  difference(){
    union(){
      cube([length,width,height]);
      translate([0,0,height]) cube([side_width,width,height]);
      translate([0,0,height]) cube([length,side_width,height]);
      translate([0,width-side_width,height]) cube([length,side_width,height]);
      translate([length-side_width,0,height]) cube([side_width,width,height]);
    }
    translate([side_width*2,-side_width*2,height]) cube([5,10,2]);
    translate([length-5-(side_width*2),-side_width*2,height]) cube([5,10,2]);
    translate([length/2,-side_width*2,height]) cube([5,10,2]);
    
    translate([side_width*2,width-side_width*2,height]) cube([5,10,2]);
    translate([length-5-(side_width*2),width-side_width*2,height]) cube([5,10,2]);
    translate([length/2,width-side_width*2,height]) cube([5,10,2]);
    
    translate([-side_width*2,width/4,height]) cube([10,5,2]);
    translate([-side_width*2,(width/4)*3,height]) cube([10,5,2]);
    
    translate([length-side_width*2,width/4,height]) cube([10,5,2]);
    translate([length-side_width*2,(width/4)*3,height]) cube([10,5,2]);
  }
}

module roof(length=30){
  difference(){
  translate([0,0,50]) cube([length,55,30]);
  translate([length/2,28.5,52.5]) rotate([0,90,0]) cylinder(d=55, h=length+1, center=true, $fn=360);
  }
    
}

module back_right(){
  difference(){
    union(){
      base_module();
      translate([0,130-2,10]) cube([30,2,70]);
      translate([0,0,10]) cube([30,2,70]);
      translate([0,0,80]) cube([30,130,5]);
        
      translate([0,55,0]) cube([30,20,80]);
      roof(length=30);
      translate([0,73,0]) roof(length=30);
    }
    translate([side_width*2,-side_width*2,height+5]) cube([5,10,2]);
    translate([side_width*2,width-side_width*2,height+5]) cube([5,10,2]);
    
    translate([side_width,-side_width*2,height+10]) cube([2,10,5]);
    translate([side_width,width-side_width*2,height+10]) cube([2,10,5]);
   
    translate([side_width,-side_width*2,height+50]) cube([2,10,5]);
    translate([side_width,width-side_width*2,height+50]) cube([2,10,5]);
  }
}
module front_right(){
  difference(){
    union(){
      base_module();
      translate([0,130-2,10]) cube([140,2,70]);
      translate([0,0,10]) cube([140,2,70]);
      translate([0,0,80]) cube([140,130,5]);
    
      translate([0,55,0]) cube([140,20,80]);
      roof(length=140);
      translate([0,73,0]) roof(length=140);
    }
    
    translate([side_width*2,-side_width*2,height+5]) cube([5,10,2]);
    translate([length-5-(side_width*2),width-side_width*2,height+5]) cube([5,10,2]);
    translate([length/2,width-side_width*2,height+5]) cube([5,10,2]);
    
    translate([side_width*2,width-side_width*2,height+5]) cube([5,10,2]);
    translate([length-5-(side_width*2),-side_width*2,height+5]) cube([5,10,2]);
    translate([length/2,-side_width*2,height+5]) cube([5,10,2]);
    
    
    translate([length-(side_width*2),-side_width*2,height+10]) cube([2,10,5]);
    translate([length-(side_width*2),width-side_width*2,height+10]) cube([2,10,5]);
    
    translate([length-(side_width*2),-side_width*2,height+50]) cube([2,10,5]);
    translate([length-(side_width*2),width-side_width*2,height+50]) cube([2,10,5]);
  }
}
    
    
back_right();

//translate([0,-131,0]) back_right();
//
//translate([-141,0,0]) front_right();
//
//translate([-141,-131,0]) front_right();



