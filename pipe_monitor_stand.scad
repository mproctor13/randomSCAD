$fn=60;
pipe_dia=49; // 1.5" abs
pipe_width=175;
thickness=3;
pipe_length=36*25.4;
tab_width=10;
side_hole_diameter=5;
foot_spacing=40;
foot_length=150;

//plywood_mount();
//plywood_foot();
//pipe_foot();

projection()
pipe_mount();
//vesa_mount(holes=false);

//projection()
//pipe_mount_foot();
//foot_stringer();
//pipe_mount();
//vesa_mount();
//middle_mount();

module plywood_foot(){
    
    translate([0,0,00]) pipe_mount_foot();
    translate([0,0,foot_spacing]) pipe_mount_foot();
    
    for(X=[-1,1])
      translate([((pipe_width/2))*X, 0, 0])
      rotate([0,0,-10*X])
      translate([(-pipe_dia/2-thickness/2)*X, 0, foot_spacing/2])rotate([90,0,90]) 
      foot_stringer();
    
    
    translate([0,0,pipe_length/2]) %pipes(height=pipe_length);
}

module foot_stringer(){
  difference(){
    cube([60,foot_spacing-thickness,thickness], center=true);
    cylinder(d=side_hole_diameter, h=thickness+1, center=true);
  }
  hull(){
    translate([30,-thickness/2,0]) cube([1,foot_spacing,thickness], center=true);
    translate([30.5+foot_length,-thickness/2-foot_spacing/4,0]) cube([1,foot_spacing/2,thickness], center=true);
  }
  for(X=[-1,1], Y=[-1,1])
    translate([20*X, ((foot_spacing-thickness)/2+thickness/2)*Y, 0])
    cube([tab_width, thickness, thickness], center=true);
}

module plywood_mount(){
    translate([0,30+thickness/2,200]) 
      rotate([90,0,0]) vesa_mount();
    
    translate([0,0,160]) pipe_mount();
    translate([0,0,240]) pipe_mount();
    
    for(X=[-1,1])
    translate([((pipe_width/2)-pipe_dia/2-thickness/2)*X,0,200]) 
      rotate([90,0,90]) middle_mount();
    
    
    translate([0,0,pipe_length/2]) %pipes(height=pipe_length);
}

module middle_mount(){
  difference(){
    cube([60,80-thickness,thickness], center=true);
    cylinder(d=side_hole_diameter, h=thickness+1, center=true);
  }
  for(Y=[-1,0,1])
    translate([30+thickness/2, 30*Y, 0])
    cube([thickness, tab_width, thickness], center=true);
  for(X=[-1,1], Y=[-1,1])
    translate([20*X, ((80-thickness)/2+thickness/2)*Y, 0])
    cube([tab_width, thickness, thickness], center=true);
}

module pipe_mount(){
  difference(){
    pipe_mount_base();
    
    for(X=[-1,1], Y=[-1,1])
      translate([((pipe_width/2)-pipe_dia/2-thickness/2)*X, 20*Y, 0])
        cube([thickness, tab_width, thickness], center=true);
        
  }
  for(X=[-1,0,1])
    translate([40*X, 30+thickness/2, 0])
    cube([tab_width, thickness, thickness], center=true);
}

module pipe_mount_foot(){
  difference(){
    pipe_mount_base();
    
    for(X=[-1,1])
      translate([((pipe_width/2))*X, 0, 0])
      rotate([0,0,-10*X])
      for(Y=[-1,1])
      translate([(-pipe_dia/2-thickness/2)*X, 20*Y, 0])
        cube([thickness, tab_width, thickness], center=true);
        
  }
}

module pipe_mount_base(){
  difference(){
    hull() for(X=[-1,1])
      translate([pipe_width/2*X,0,0]) cylinder(d=60, h=thickness, center=true);
    for(X=[-1,1])
      translate([pipe_width/2*X,0,0]) cylinder(d=49, h=thickness+1, center=true);
  }
}

module vesa_mount(inner_dia=100, holes=true){
  difference(){
    union(){
      if(holes){
        for(X=[-1,1], Y=[-1,1]){
          hull(){
        translate([50*X, 50*Y, 0])
          cylinder(d=20, h=thickness, center=true);
          cylinder(d=inner_dia, h=thickness, center=true);
        }
      }
  }
      hull() for(X=[-1,1], Y=[-1,1])
        translate([((pipe_width/2)-pipe_dia/2-thickness/2)*X, 40*Y, 0]) cylinder(d=10, h=thickness, center=true);
    }
    vesa_mount_holes();
    for(X=[-1,0,1], Y=[-1,1])
      translate([40*X, 40*Y, 0])
      cube([tab_width, thickness, thickness], center=true);
    for(X=[-1,1], Y=[-1,0,1])
      translate([((pipe_width/2)-pipe_dia/2-thickness/2)*X, 30*Y, 0])
      cube([thickness, tab_width, thickness], center=true);
  }
}

module vesa_mount_holes(hole_seperation=100, hole_dia=4.5, hole_height=10){
  for(X=[-1,1], Y=[-1,1]){
    translate([hole_seperation/2*X, hole_seperation/2*Y, 0])
      cylinder(d=hole_dia, h=hole_height, center=true);
  }
}

module pipe_foot(height=20){
    %difference(){
        hull(){
            cylinder(d=pipe_dia+10, h=5);
            translate([0, -150, 0]) cylinder(d=30, h=5);
        }
        translate([0, 0, -10]) cylinder(d=pipe_dia, h=100);
    }
    hull(){
        translate([0, -150, 5]) rotate([90,0,0]) cylinder(d=5, h=1);
        translate([0, -pipe_dia/2, 5]) cylinder(d=5, h=height);
    }
}

module big_monitor(){
  cube([10, 650, 450]);
}

module pipes(height=500){
  for(X=[-1,1]) translate([pipe_width/2*X, 0,0]) 
    cylinder(d=pipe_dia, h=height, center=true);
}
