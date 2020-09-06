
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
    
    
    translate([2,2,5]) cube([26,126,81]);
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
    
    
      translate([2,2,5]) cube([136,126,81]);
  }
}

module top(){
  difference(){
    translate([-110,0,82.1]) base_module(length=139.9, width=129.9, side_height=5, side_width=0, height=8);
    
    translate([-110.5,130-2.5,82.1]) cube([141,3,3]);
    translate([-110.5,-0.5,82.1]) cube([141,3,3]);
    
    translate([-110.5,-1.5,82.1]) cube([3,131,3]);
    translate([-2.2,-1.5,82.1]) cube([4.4,131,3]);
    translate([28.1,-1.5,82.1]) cube([3,131,3]);
    color([1,1,1]) back_right();
    translate([-140,0,0]) color([1,1,1]) front_right();
  }
}

translate([-140,-131,100]) front_right();
translate([-140,0,100]) front_right();

top();
translate([0,-131,0]) top();
    
back_right();
translate([-140,0,0]) front_right();

translate([0,-131,0]) back_right();
translate([-141,-131,0]) front_right();



