
link();
module link(){
  difference(){
    cube([130,32,5], center=true);
    for(X=[-1,1]) translate([((130/2)-10)*X, 0, 0]) 
      cube([20,3.75,6], center=true);
    for(X=[-1,1]) translate([((130/2)-2.5)*X, 0, 0]) 
      cube([5,13.4,6], center=true);
    for(X=[-1,1]) translate([((130/2)-10.5)*X, 0, 0]) 
      cube([3.5,6,6], center=true);
    hull()
    for(X=[-1,1]) translate([20*X, 0, 0]) 
      cylinder(d=16,h=6, center=true);
  }
}

