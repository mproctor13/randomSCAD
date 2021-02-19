//layout=[3,4];
//layout=[2,3];
layout=[4,6];
//layout=[2,1];
//layout=[2,2];

thickness=6;
div_thickness=3;
ct=thickness;
ch=20;
lid_height=30;
lid_thickness=3;
lid_tab=20;
material_depth=304;
material_width=609.6;

upright=true;
handle_width=85;

// champain bottle
//bottle_height=299;
//bottle_width=85;

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

//%cube([300, 600, 6]);
//bottles();
//end();
%outside();
label();
//outside();
//divider();
//inside();
//lid();
//champagne_layout();
//lid_end();
//lid_side();
//end();
//model();
//bottom();
//case();


module champagne_layout(){
bottle_height=299;
bottle_width=85;
  %cube([300, 600, 6],center=true);
//  translate([-bottle_height/2,-120,0]) rotate([0,90,0]) outside();
  translate([-bottle_height/2,-160,0]) rotate([90,0,90]) divider();
}

module model(){
//  translate([end_length-thickness,0,bottle_height]) rotate([0,180,0]) lid();
  case();
  lid();
}

module lid(){
  translate([end_length/2-thickness/2,side_length/2-thickness/2,0]){
    bottom();
    for(X=[-1,1]) 
        translate([(end_length+lid_thickness)/2*X,0,(lid_height)/2-thickness]) 
            rotate([0,90,0]) lid_side();
    for(Y=[-1,1])
        translate([0,(side_length+lid_thickness)/2*Y,(lid_height)/2-thickness]) 
            rotate([-90,0,0]) lid_end();
  }
}

module lid_end(){
    cube([end_length, lid_height-thickness,lid_thickness], center=true);

    end_tabs = floor(floor(end_length/ch)/2);
    if(ch*end_tabs+ch/2 > end_length/2){
        end_tabs = end_tabs-1;
        for(X=[-end_tabs:2:end_tabs])
          translate([ch*X, lid_height/2,0]) 
            cube([ch, thickness, lid_thickness], center=true);
        }
    else{
        for(X=[-end_tabs:2:end_tabs])
          translate([ch*X, lid_height/2,0]) 
            cube([ch, thickness, lid_thickness], center=true);
    }
    echo(end_tabs);
    for(X=[-1,1])
      translate([(end_length+lid_thickness)/2*X,0,0])
        cube([lid_thickness, lid_height/2, lid_thickness], center=true);
}

module lid_side(){
  difference(){
    union(){
      cube([lid_height-thickness,side_length+lid_thickness*2,lid_thickness], center=true);
      
      side_tabs = floor(floor(side_length/ch-1)/2);
      for(Y=[-side_tabs:2:side_tabs])
        translate([lid_height/2,Y*ch,0]) 
            cube([thickness, ch, lid_thickness], center=true);
    }
    for(Y=[-1,1])
      translate([0,(side_length+lid_thickness)/2*Y,0])
        cube([lid_height/2, lid_thickness, lid_thickness], center=true);
  }
}


module bottom(){
  translate([0,0,-thickness])
  difference(){
    cube([end_length+lid_thickness*2, side_length+lid_thickness*2, thickness], center=true);
    end_tabs = floor(floor(end_length/ch)/2);
    if(ch*end_tabs+ch/2 > end_length/2){
        end_tabs=end_tabs-1;
        for(Y=[-1,1], X=[-end_tabs:2:end_tabs])
          translate([ch*X, (side_length+lid_thickness)/2*Y,0]) 
            cube([ch, lid_thickness, thickness+2], center=true);
    }
    else{
        for(Y=[-1,1], X=[-end_tabs:2:end_tabs])
          translate([ch*X, (side_length+lid_thickness)/2*Y,0]) 
            cube([ch, lid_thickness, thickness+2], center=true);
    }
    
    side_tabs = floor(floor(side_length/ch-1)/2);
    for(X=[-1,1], Y=[-side_tabs:2:side_tabs])
      translate([(end_length+lid_thickness)/2*X,Y*ch,0]) 
        cube([lid_thickness, ch, thickness+2], center=true);
  }
}

module case(){
  translate([0, -thickness/2, 0]) outside();
  translate([end_length-thickness, -thickness/2, 0]) outside();
  if(upright){
    for(X=[1:1:layout[0]-1])
      translate([(bottle_width+div_thickness)*X, 0, 0])
        inside();
  
    for(Y=[1:1:layout[1]-1])
      translate([-thickness/2, div_thickness/2+(bottle_width+  div_thickness)*Y,0])
        divider();
  }
  translate([0, side_length-thickness, 0]) end();
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

module label(){
//    linear_extrude(height = 5)
    translate([0,30,bottle_height/2])
    rotate([90,0,90])
    text("MPS BREW", size=75, font="East Border");
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
    hull()
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

module bottles(){
  for(X=[0:1:layout[0]-1], Y=[0:1:layout[1]-1]) 
    translate([((bottle_width+thickness)/2)+(bottle_width+div_thickness)*X,(bottle_width+thickness)/2+(bottle_width+div_thickness)*Y,0]) 
      %bottle();
}

module bottle(){
  cylinder(d=bottle_width, h=bottle_height*.50);
  translate([0,0,bottle_height*.50]) 
        cylinder(d1=bottle_width, d2=26, h=bottle_height*.50);
}