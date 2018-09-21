
//projection(cut = false) top();
//projection(cut = false) rotate([90,0,0]) front();
//translate([((571.5/2)-2.5),0,0]) support();
projection(cut = false) rotate([0,90,0]) support();

module support(){
  hull(){
    translate([0,-5,0]) cube([5,5,30], center=true);
    translate([0,-22.5,12.5]) cube([5,40,5], center=true);
  }
  translate([0,0,0]) cube([5,5,15], center=true);
  translate([0,-22.5,17.5]) cube([5,15,5], center=true);
}

module front(){
  difference(){
    cube([571.5,5,40], center=true);
    for(X=[-1,1]){
      translate([((571.5/2)-2.5)*X,0,0]) cube([5.1,6,15], center=true);
      translate([100*X,0,0]) cube([5.1,6,15], center=true);
    }
    for(X=[-200,-100,0,100,200]) translate([X,0,17.5]) cube([15,6,5.1], center=true);
  }
}

module top(){
  difference(){
    union(){
      translate([0,-22.5,17.5]) cube([571.5,40,5], center=true);
      for(X=[-200,-100,0,100,200]) translate([X,0,17.5]) cube([15,5,5], center=true);
    }
    for(X=[-1,1]){
      translate([((571.5/2)-2.5)*X,-22.5,17.5]) cube([5.1,15,6], center=true);
      translate([100*X,-22.5,17.5]) cube([5.1,15,6], center=true);
    }
  }
}