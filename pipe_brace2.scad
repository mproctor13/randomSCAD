/*%cube(300, center=true);*/
faces=60;
pipe_dia=48;
con_dia=35;

/*pipe_clamp2();*/

/*scale(6) rotate([25,0,-90]) translate([0,-15,-25]) import("tie/tiefighter.stl");*/
/*scale(6) rotate([0,0,-20]) translate([-5,14,-35]) import("tie/tie_advanced.stl");*/
/*difference(){
  scale(20) rotate([0,0,0]) translate([0,0,0]) import("tie/tie_vader.stl");
  cylinder(d=pipe_dia,h=300, $fn=faces, center=true);
}*/
/*import("tie/tie_advanced.stl");*/
pipe_holder(part=0);
module pipe_holder(part=0){
  if(part == 1){
    difference(){
      pipe_holder_internal();
      translate([0, -50, 0]) cube(100, center=true);
    }
  }
  else if(part == 2){
    intersection(){
      pipe_holder_internal();
      translate([0, -50, 0]) cube(100, center=true);
    }
  }
  else{
    pipe_holder_internal();
  }
}

module pipe_holder_internal(){
  difference(){
    union(){
      translate([0, pipe_dia/4, 0]) sphere(d=90, $fn=faces);

    }
    translate([0, 25, 0]) rotate([-90,0,0]) cylinder(d=pipe_dia,h=100, $fn=faces);
    cylinder(d=pipe_dia,h=300, $fn=faces, center=true);
    translate([0,37.5,0]) rotate([0,90,0]){
      cylinder(d=5.4,h=110, $fn=60, center=true);
      for(Z=[-1,1]) translate([0,0,(pipe_dia+10)*Z]) cylinder(d=12,h=50, $fn=faces, center=true);
      cylinder(d=10,h=pipe_dia+10, $fn=faces, center=true);
    }
    for(X=[-1,1]) translate([35*X,0,0]) {
      rotate([90,0,0]) cylinder(d=5.4,h=110, $fn=60, center=true);
      for(Y=[-1,1]) translate([0,30*Y,0]) rotate([90,0,0]) cylinder(d=12,h=50, $fn=faces, center=true);
    }
    /*for(Z=[-1,1]) translate([0,0,(pipe_dia+10)*Z]) cylinder(d=12,h=50, $fn=faces, center=true);*/
  }
}

module pipe_clamp2(){
  difference(){
    union(){
      rotate_extrude(convexity=10, $fn=faces)
        translate([pipe_dia/2, 0, 0]) circle(d=con_dia);
      leg();
      for(X=[-1,1]) translate([100*X,-100,0]) sphere(d=con_dia, $fn=faces);

    }
    cylinder(d=pipe_dia,h=100, $fn=faces, center=true);
    hull(){
      translate([0,-50,-25]) rotate([0,90,0]) cylinder(d=10,h=250, center=true);
      translate([0,-125,-25]) cube([250, 100, 50], center=true);
    }
    for(Z=[-1,1]){
      translate([0,0,7.5*Z]) rotate([0,90,0])
        cylinder(d=5.4,h=150, $fn=faces, center=true);
      for(X=[-1,1]) translate([70*X,0,7.5*Z]) rotate([0,90,0])
        cylinder(d=12,h=50, $fn=faces, center=true);
    }
  }
}

module leg(curve=100, faces=faces){
  translate([0,-curve,0])
  intersection(){
    translate([-curve*2,0,-curve]) cube(curve*4);
    rotate_extrude(convexity=10, $fn=faces) translate([curve, 0, 0]) circle(d=con_dia);

    /*cylinder(d=pipe_dia,h=100, $fn=faces, center=true);*/
  }

}
