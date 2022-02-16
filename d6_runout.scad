
//projection(cut=true)
//intersection(){
//  translate([10.5,-60,0])
//    import("../printer/Wanhao_D6_Clip_2.stl");
//  translate([4,-69.5,0])
//    import("../printer/Wanhao_D6_Clip_2.stl");
//  translate([0,-3,0]) cube([10,10,10], center=true);
//  cylinder(d=8,h=20);
//}
//  %cylinder(d=5,h=20);

//linear_extrude(18) import("d6_back_mount.dxf");

runout_mount();

module runout_mount(thickness=3){
  $fn=60;
  translate([5,1,0])
  linear_extrude(18) import("d6_back_mount.dxf");
  
  difference(){
    translate([-20,0,0]) cube([30,thickness,50]);
    for(Y=[0,1]) translate([-5,4+3.3,23+20*Y]){
        rotate([90,0,0]) cylinder(d=3.3, h=thickness*2);
      translate([0,-4.91,0]) 
        rotate([90,0,0]) cylinder(d1=3.3, d2=6.2, h=2.1);
      translate([0,-7,0]) 
        rotate([90,0,0]) cylinder(d=6.2, h=2);
    }
  }
  %translate([7,4+3.3,-2]) cylinder(d=2.5, h=40);
  translate([4+3,7.3,0]) 
  difference(){
    hull(){
      cylinder(d=6, h=10);
      translate([-3,-6,0]) cube([6,1,10]);
    }
    translate([0,0,-1]) cylinder(d=4, h=12);
//    translate([0,0,-1]) cylinder(d=4, h=10);
//    translate([0,0,8]) cylinder(d=3, h=5);
  }
}

module mount_test(){
difference(){
  $fn=60;
  cube([25,10,2], center=true);
  for(X=[-1,1]) translate([10*X,2,0]) cylinder(d=3.3, h=4, center=true);
  for(X=[-1,1]) translate([9*X,-2,0]) cylinder(d=3.3, h=4, center=true);
}
}