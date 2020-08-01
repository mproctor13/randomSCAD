//layout=[3,4];
//layout=[2,3];
layout=[4,6];
thickness=6;
div_thickness=3;
ct=thickness;
ch=20;
lid_height=30;
material_depth=304;
material_width=609.6;

upright=true;
handle_width=85;

// champain bottle
bottle_height=299;
bottle_width=85;

// 750ml bottle
//bottle_height=291;
//bottle_width=80;

// 12oz normal
bottle_height=196;
bottle_width=65.5;

// 12oz tall
//bottle_height=226;
//bottle_width=61;

// 16oz swingtop
//bottle_height=256;
//bottle_width=71;

div_height=bottle_height/2;
side_length=layout[1]*bottle_width+
             (layout[1]-1)*div_thickness+
             thickness*2;
end_length=layout[0]*bottle_width+
             (layout[0]-1)*div_thickness+
             thickness*2;

%cube([300, 600, 6]);
//bottles();
case();
//bottles24();
//end();
//inside();
//outside();
//divider();
//lid();
//lid_end();
//champagne_layout();

module champagne_layout(){
bottle_height=299;
bottle_width=85;
  %cube([300, 600, 6],center=true);
//  translate([-bottle_height/2,-120,0]) rotate([0,90,0]) outside();
  translate([-bottle_height/2,-160,0]) rotate([90,0,90]) divider();
}

module model(){
  translate([0,0,bottle_height+thickness]) rotate([0,180,0]) lid();
  case();
  lid();
}

module lid(){
  bottom();
  for(X=[-1,1]) translate([(bottle_width*1.5+thickness*2.5)*X,0,(lid_height-thickness)/2]) rotate([0,90,0]) lid_side();
  for(Y=[-1,1]) translate([0,(bottle_width*2+thickness*3)*Y,(lid_height-thickness)/2]) rotate([-90,0,0]) lid_end();
}

module lid_end(){
    union(){
      translate([0,-thickness/2,0])
    cube([bottle_width*3+thickness*4, lid_height-thickness,thickness], center=true);

    for(X=[-1,0,1])
      translate([bottle_width*X, (lid_height-thickness)/2,0]) 
        cube([bottle_width/2, ct, thickness], center=true);
    for(X=[-1,1])
      translate([(bottle_width*1.5+thickness*2.5)*X,0,0])
        cube([ct, lid_height/2, thickness], center=true);
    }
}

module lid_side(){
  difference(){
    union(){
      translate([-thickness/2,0,0])
    cube([lid_height-thickness,bottle_width*4+thickness*7,thickness], center=true);
    for(Y=[-1.5,0,1.5])
      translate([(lid_height-thickness)/2, bottle_width*Y, 0])
        cube([ct, bottle_width/2, thickness], center=true);
    }
    for(Y=[-1,1])
      translate([0,(bottle_width*2+thickness*3)*Y,0])
        cube([lid_height/2, ct, thickness+2], center=true);
  }
}


module bottom(){
  difference(){
    cube([bottle_width*3+thickness*6, bottle_width*4+thickness*7, thickness], center=true);
    for(Y=[-1,1], X=[-1,0,1])
      translate([bottle_width*X, (bottle_width*2+thickness*3)*Y,0]) 
        cube([bottle_width/2, ct, thickness+2], center=true);
    for(X=[-1,1], Y=[-1.5,0,1.5])
      translate([(bottle_width*1.5+thickness*2.5)*X, bottle_width*Y,0]) 
        cube([ct, bottle_width/2, thickness+2], center=true);
  }
}

module case(){
//  translate([0, -thickness/2, 0]) outside();
//  translate([end_length-thickness, -thickness/2, 0]) outside();
  if(upright){
    for(X=[1:1:layout[0]-1])
      translate([(bottle_width+div_thickness)*X, 0, 0])
        inside();
  
    for(Y=[1:1:layout[1]-1])
      translate([-thickness/2, div_thickness/2+(bottle_width+  div_thickness)*Y,0])
        divider();
  }
//  translate([0, side_length-thickness, 0]) end();
  translate([0, 0, 0]) end();
}

module outside(){
  difference(){
    translate([-thickness/2,0,0])
      cube([thickness, side_length, bottle_height]);
    for(Y=[thickness/2,side_length-thickness/2], Z=[30:40:bottle_height])
      translate([0, Y, Z]) 
        cube([thickness+2, ct, ch], center=true);
    for(Y=[1:1:layout[1]-1], Z=[30:40:div_height+1])
      translate([0, -div_thickness/2+thickness+(bottle_width+div_thickness)*Y,Z]) 
        cube([thickness+2, div_thickness, ch], center=true);
  }
}

module inside(){
  difference(){
    translate([0,-thickness/2,0]) 
      cube([div_thickness, side_length, div_height]);
    
    for(Y=[1:1:layout[1]-1])
    translate([0, div_thickness/2+(bottle_width+div_thickness)*Y,div_height*.25])
      cube([thickness+2, div_thickness, div_height/2], center=true);
    for(Y=[0,side_length-thickness], Z=[30:40:bottle_height])
      translate([0, Y, Z]) 
        cube([thickness+2, ct, ch], center=true);
  }
}

module end(){
  difference(){
    translate([-thickness/2,-thickness/2,0]) 
      cube([end_length, thickness, bottle_height],center=false);
     translate([end_length/2, 0, 0])
    %hull()
      for(X=[-1,1]) rotate([90,0,0]) translate([(handle_width/2-15)*X, bottle_height-lid_height-15, 0]) 
        cylinder(d=30,h=thickness+2, center=true);
    for(X=[0,end_length-thickness], Z=[10:40:bottle_height])
      translate([X,0,Z]) 
        cube([ct, thickness+2, ch], center=true);
    
    if(upright){
      for(X=[1:1:layout[0]-1], Z=[10:40:div_height])
        translate([div_thickness/2+(bottle_width+div_thickness)*X, 0, Z])
        cube([div_thickness, thickness+2, ch], center=true);
    }
  }
}

module divider(){
  difference(){
    translate([0,-div_thickness/2,0]) 
      cube([end_length, div_thickness, div_height]);
    for(X=[thickness/2,end_length-thickness/2], Z=[10:40:div_height])
      translate([X,0,Z]) 
        cube([ct, thickness+2, ch], center=true);
    for(X=[1:1:layout[0]-1]) 
      translate([thickness/2+div_thickness/2+(bottle_width+div_thickness)*X, 0, div_height*.75]) 
        cube([div_thickness, thickness+2, div_height/2], center=true);
  }
}

module bottles24(){
  for(X=[0:1:layout[0]-1], Y=[0:1:layout[1]-1]) 
    translate([((bottle_width+thickness)/2)+(bottle_width+div_thickness)*X,(bottle_width+thickness)/2+(bottle_width+div_thickness)*Y,0]) 
      %bottle();
}

module bottles(){
  for(X=[-1,0,1], Y=[-1.5,-0.5,0.5,1.5]) 
    translate([(bottle_width+thickness)*X,(bottle_width+thickness)*Y,0]) 
      %bottle();
}

module bottle(){
  cylinder(d=bottle_width, h=bottle_height*.50);
  translate([0,0,bottle_height*.50]) cylinder(d1=bottle_width, d2=26, h=bottle_height*.50);
}