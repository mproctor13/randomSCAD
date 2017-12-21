top();
front();

module front(){
  difference(){
    cube([571.5,5,40], center=true);
    for(X=[-1,1]) translate([((571.5/2)-2.5)*X,0,0]) cube([5.1,6,15], center=true);
    for(X=[-200,-100,0,100,200]) translate([X,0,17.5]) cube([15,6,5.1], center=true);
  }
}

module top(){
  difference(){
    union(){
      translate([0,-27.5,17.5]) cube([571.5,50,5], center=true);
      for(X=[-200,-100,0,100,200]) translate([X,0,17.5]) cube([15,5,5], center=true);
    }
    for(X=[-1,1]) translate([((571.5/2)-2.5)*X,-27.5,17.5]) cube([5.1,15,6], center=true);
  }
}