
aligner();

module aligner(spaces=4){
  translate([spaces*5,0,0]) difference(){
    cube([10*spaces,10,10], center=true);
    cube([10*spaces-3.8,6.3,20], center=true);
//    %for(X=[0:1:spaces-1]) translate([6*X+5,0,-10]) cylinder(d=5.8,h=10);
  }
}
