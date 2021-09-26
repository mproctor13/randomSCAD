$fn=60;
inner_hole=25;
outer_dia=38;
height=5;

mount(offset=75);

module mount(offset=50){
  difference(){
    hull(){
      cylinder(d=outer_dia, h=height,center=true);
      translate([0,offset,0]) cube([outer_dia,1,height], center=true);
    }
    cylinder(d=inner_hole, h=height+1,center=true);
    translate([outer_dia/2,inner_hole,0])
      cylinder(d=inner_hole, h=height+1,center=true);
    translate([0,offset-9,0]) hull(){
      cylinder(d=14, h=height+1,center=true);
      translate([0,10,0]) cube([14,1,height+1], center=true);
    }
  }
  for(X=[-1,1]) translate([13*X,offset+.5,0]) 
  hull(){
    translate([0,0,5]) rotate([90,0,0])
      cylinder(d=(outer_dia-14)/2, h=height);
    translate([0,-2.5,0]) cube([(outer_dia-14)/2,5,1],center=true);
  }
}