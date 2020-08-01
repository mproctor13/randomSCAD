
$fn=60;
sq_nutX=5.5;
sq_nutY=2;
//assembly();
mmu();

module mmu(){
  offset=12;
  difference(){
    import("MPMU_D6_Helix_e3D_Body_v1.stl");
    translate([0,offset,4]) 
    difference(){
        cube([60,sq_nutX,sq_nutY], center=true);
        cube([20,sq_nutX+1,sq_nutY+1], center=true);
    }
    for(X=[-1,1]) translate([15*X,offset,-2]) cylinder(d=3.3, h=10);
//    %translate([0,21,33]) cube([60,5.5,2], center=true);
  }
}


module assembly(){
  translate([0,-7,40]) rotate([90,0,0]) mmu();
  translate([0,0,50]) rotate([0,180,0])
    import("BLTouch_extracted.stl");
}
