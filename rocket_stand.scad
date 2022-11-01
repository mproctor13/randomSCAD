$fn=360;
//$fn=60;

dia=79;
thickness=20;
height=50;
difference(){
  union(){
    hull(){
      cylinder(d=dia+20,h=thickness,center=true);
      translate([0,-dia/2-height/2,0])
      cube([15,height,thickness],center=true);
    }
    translate([0,-height-dia/2,0]) hull(){
      for(X=[-1,1], Y=[-1,1])
        translate([(dia/2+20)*X,5*Y,0]) cylinder(d=5,h=thickness,center=true);
      translate([0,15,0]) cube([15,30,thickness],center=true);
    }
  }
  cylinder(d=dia,h=thickness+1,center=true);
  translate([0,dia/2,0]) cube([dia+21,dia,thickness+1],center=true);
  translate([0,1-dia/2-height/2,0])
    cube([3,height,thickness+1],center=true);
  for(R=[-90,0,90]) rotate([0,0,R])
    translate([0,1-dia/2,0]) rotate([0,0,45])
      cube([12,12,thickness+1],center=true);
}


module vertical_stand(motor_dia=37.5, mount_length=50){
  cylinder(d=motor_dia,h=mount_length+20);
  cylinder(d=motor_dia+20,h=20);
  translate([0,0,3]) rotate_extrude(angle=360) 
  translate([100,0,0]) hull(){
    circle(d=5);
    translate([0,-2.5,0]) square([5,1],center=true);
  }
  for(R=[0:360/6:360]) rotate([0,0,R])
    hull(){
      translate([0,100,2.5]) cube([10,1,5],center=true);
      translate([0,motor_dia/2,5]) cube([10,1,10],center=true);
    }
}
