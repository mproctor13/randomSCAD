


sensor_offset=0.5;
load_cell=[12.7,12.7,70];
load_cell_holes=[5,22];

big_cell=[12.7,12.7,80];
big_cell_holes=[7.5,25];


module strain_gauge(load_cell=load_cell,load_cell_holes=load_cell_holes){
  
  translate([0,0,load_cell[2]/2]) rotate([0,180,90])
  difference(){
    union(){
      cube([load_cell[0],load_cell[1],load_cell[2]], center=true);
      cube([load_cell[0],load_cell[1]+2,20], center=true);
      translate([1,0,11]) cube([load_cell[0],load_cell[1],20], center=true);
      translate([6.5,0,30]) cube([2,5,30], center=true);
    }
    for(Z=[-1,1]) translate([0,0,4*Z]) rotate([0,90,0])
      cylinder(d=9.8, center=true, h=20);
    for(Z=[-1,1], Z2=[-1,1]) translate([0,0,load_cell_holes[1]*Z2]) translate([0,0,load_cell_holes[0]*Z]) rotate([90,0,0]) cylinder(d=5, center=true, h=20);
  }
}

//load_mount_test();
module load_mount_test(load_cell=load_cell,load_cell_holes=load_cell_holes){
  difference(){
    cube([18,16,30], center=true);
    translate([0,2,0]) cube([load_cell[0],load_cell[1],30], center=true);
    for(Z=[-1,1]) translate([0,0,load_cell_holes[0]*Z]) rotate([90,0,0]) 
      cylinder(d=5,h=20,center=true);
  }
}
