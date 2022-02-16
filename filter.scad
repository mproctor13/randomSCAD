$fn=60;
filter=[72.5,110,20];
fan_dia=116;
sthickness=20;

//filter_120();
fan_grill(blank=true);
//cover();

module assemble(){
    translate([0, 0, -2]) fan_120(thickness=4);
    translate([0, 0, 10]) filter_120();
    for(X=[-1,1]) translate([((filter[0]+1)/2)*X, 0, 30]) filter();
    translate([0,0,sthickness/2+filter[2]+1]) cover();
}
module cover(){
  difference(){
    union(){
      cube([filter[0]*2+5, filter[1]+4, filter[2]+2], center=true);
      translate([0,0,-filter[2]+4])
      cube([filter[0]*2+5, filter[1], filter[2]+2], center=true);
      for(Y=[-0.5,1])
      hull(){
        translate([0,(filter[1]-8)/2*Y,filter[2]/2])
        cube([filter[0]*2+5,8,1], center=true);
      for(X=[-1,1])
        translate([(filter[0]+8)*X,(filter[1]-8)/2*Y,-filter[2]*1.5+3])
          cylinder(d=8, h=4);
      }
    }
    for(X=[-1,1]){
      translate([((filter[0]+1)/2)*X, 0, filter[2]-filter[2]/2]) 
        cube([filter[0]-12,filter[1]-12,4], center=true);
    }
    translate([0,0,-1])
    cube([filter[0]*2+2, filter[1]+2, filter[2]+2], center=true);
    translate([0,0,-filter[2]-2])
      cube([filter[0]*2+3, filter[1]+5, filter[2]+2], center=true);
    for(Y=[-0.5,1], X=[-1,1])
        translate([(filter[0]+8)*X,(filter[1]-8)/2*Y,-filter[2]*1.5+2]) 
          cylinder(d=3.2, h=10);
  }
}

module filter_120(){
  difference(){
    union(){
      cube([filter[0]*2+1, filter[1]+10, sthickness], center=true);
      hull()
      for(X=[-1,1])
        translate([(filter[0]+sthickness/2)*X,-filter[1]/2-2,0]) 
          rotate([90,0,0]) cylinder(d=sthickness, h=4);
      for(Y=[-0.5,1])
      hull()
      for(X=[-1,1])
        translate([(filter[0]+8)*X,(filter[1]-8)/2*Y,-sthickness/2]) 
          cylinder(d=8, h=4);
    }
    for(X=[-1,1]){
      translate([0,0,-sthickness/2]) hull(){
          translate([((filter[0]+1)/2)*X, 0, sthickness]) 
            cube([filter[0]-12,filter[1]-12,0.1], center=true);
          intersection(){
            cylinder(d=fan_dia, h=0.1, center=true);
            translate([fan_dia/4*X,0,0])
              cube([fan_dia/2, fan_dia, 0.1], center=true);
          }
        }
      for(Y=[-0.5,1], X=[-1,1])
        translate([(filter[0]+8)*X,(filter[1]-8)/2*Y,-sthickness/2]) 
          cylinder(d=4, h=6);
      translate([(filter[0]+sthickness/2)*X,-filter[1]/2-2,0]) 
          rotate([90,0,0]) cylinder(d=4, h=6);
    }
    for(X=[-1,1], Y=[-1,1]) translate([52.5*X, 52.5*Y, 0]){
      cylinder(d=5, h=sthickness+2, center=true);
      hull()
      for(Y2=[0,-6])
      translate([0, Y2*Y, 3])
        cylinder(d=8, h=sthickness+2, center=true);
    }
  }
}

module fan_base(thickness=5){
    difference(){
        hull()
        for(X=[-1,1], Y=[-1,1])
            translate([56*X, 56*Y, 0]) 
                cylinder(d=8, h=thickness, center=true);
        for(X=[-1,1], Y=[-1,1])
            translate([52.5*X, 52.5*Y, 0]) 
                cylinder(d=4, h=thickness+2, center=true);
    }
}

module fan_120(thickness=25){
    difference(){
        fan_base(thickness);
        cylinder(d=116, h=thickness+2, center=true);
    }
}

module fan_grill(thickness=3, blank=false){
    difference(){
        fan_base(thickness);
        if( ! blank )
        intersection(){
            cylinder(d=117, h=thickness+2, center=true);
            for(X=[-6:1:6], Y=[-6:1:6]){
                translate([10*X+5*(Y%2),9*Y,0]) rotate([0,0,30])
                cylinder(d=10,h=thickness+1, $fn=6, center=true);
            }
        }
        
    }
}

module filter(){
    color("white")
    difference(){
        cube([filter[0],filter[1],filter[2]], center=true);
        translate([0,0,-1+filter[2]/2]) 
            cube([filter[0]-12,filter[1]-12,3], center=true);
        translate([0,0,-filter[2]/2]) 
            cube([filter[0]-12,filter[1]-12,1], center=true);
    }
}