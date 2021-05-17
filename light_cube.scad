board_x=66.2;
board_y=67.2;


translate([0,0,-.5]) cover_test();
//translate([0,0,-3]) matrix();

module cover_test(){
    cube([70,70,1], center=true);
  translate([0,0,-1.5])
  difference(){
    cube([70,70,4], center=true);
    translate([0,0,-0.5]) cube([board_x,board_y,4], center=true);
//    for(X=[-3.5,-2.5,-1.5,-0.5,0.5,1.5,2.5,3.5], 
//        Y=[-3.5,-2.5,-1.5,-0.5,0.5,1.5,2.5,3.5])
//      translate([X*8,Y*8,1.2]) cube([5.6, 5.6, 1.65], center=true);
  }
  for(X=[-4,-3,-2,-1,0,1,2,3,4])
    translate([8.3*X,0,-1.25]) cube([2,70,1.5], center=true);
  for(X=[-1,1], Y=[-1,0,1])
    translate([25*X,25*Y,-3]) cylinder(d=2.7, h=3, $fn=60);
}

module matrix(){
  color("grey") cube([board_x,board_y,1.6], center=true);
  for(X=[-3.5,-2.5,-1.5,-0.5,0.5,1.5,2.5,3.5], 
      Y=[-3.5,-2.5,-1.5,-0.5,0.5,1.5,2.5,3.5])
  translate([X*8,Y*8,1.5]) ws2812b();
}

module ws2812b(){
    color("white") cube([5,5,1.6], center=true);
    for(X=[-1,1], Y=[-1,1])
      translate([(0.45+1.7)*X,1.7*Y,-0.4]) 
        color("silver") cube([0.9,0.9,0.8], center=true);
}

