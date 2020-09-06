width=100;
depth=100;
height=100;
thickness=3;
tab=10;
tabs_per_side=5;

for(Z=[0,-1]) translate([0,0,Z*(height)]) top();
for(Y=[-1,1]) translate([0, Y*(depth/2)+(thickness/2)*(Y*-1), -(height/2)+(thickness/2)]) rotate([90,0,0]) side();
for(X=[-1,1]) translate([X*(width/2)+(thickness/2)*(X*-1), 0, -(height/2)+(thickness/2)]) rotate([0,90,0]) end();

module end(){
  cube([height-thickness*2, depth-thickness*2, thickness], center=true);
  for(R=[0,180]) rotate([0,0,R]) cutouts_x(width=height, depth=depth);
  for(R=[0,180]) rotate([0,0,R]) cutouts_y(width=height);
}

module side(){
  cube([width-thickness*2, height-thickness*2, thickness], center=true);
  for(R=[0,180]) rotate([0,0,R]) cutouts_x(width=width, depth=height);
  for(R=[0,180]) rotate([0,0,R]) cutouts_y(width=width, depth=height);
}
module top(){
  difference(){
    cube([width, depth, thickness], center=true);
    for(R=[0,180]) rotate([0,0,R]) cutouts_x();
    for(R=[0,180]) rotate([0,0,R]) cutouts_y();
  }

}

module cutouts_x(width=width, depth=depth){
  translate([-width/2, -depth/2, 0]) for(X=[tab:tab*2:width]) translate([X,(thickness/2)-0.05,0]) cube([tab, thickness, thickness+0.1], center=true);
}

module cutouts_y(width=width, depth=depth){
  translate([-width/2, -depth/2, 0])
  for(Y=[tab*2:tab*2:depth-tab]) translate([(thickness/2)-0.05,Y,0]) cube([thickness, tab, thickness+0.1], center=true);
}
