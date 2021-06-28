
//%brew_jacket_mount();
presure_mount();

module brew_jacket_mount(offset_len=-75,mount_width=50,mount_thickness=7.5){
  %translate([-16.5,0,2])
    import("../printer/brewbubble/Bubble Counter Holder with Collimator.stl");

  difference(){
    hull(){
      cylinder(d=35,h=5, $fn=60);
//      translate([offset_len,0,-7.5])
//        %cube([mount_thickness,mount_width,25], center=true);
      translate([offset_len,0,-7.5])
        hull(){
          for(Z=[-1,1], Y=[-1,1]) 
            translate([0, (mount_width/2-5/2)*Y,10*Z]) 
              rotate([0,90,0]) 
                cylinder(d=5,h=mount_thickness, center=true, $fn=60);
        } 
    }
    translate([offset_len+mount_thickness/2-1.1,0,-12.5]) 
      cube([2.2,mount_width+1,25], center=true); 
    translate([0,0,-1]) cylinder(d=14,h=30, center=true);
  }
}


module presure_mount(offset_len=-75,mount_width=50,mount_thickness=5){
  dia=365;

  difference(){
    union(){
      hull(){
      cylinder(d=35,h=5, $fn=60);
      translate([offset_len,0,-7.5])
        hull(){
          for(Z=[-1,1], Y=[-1,1]) 
            translate([0, (mount_width/2-5/2)*Y,10*Z]) 
              rotate([0,90,0]) 
                cylinder(d=5,h=mount_thickness, center=true, $fn=60);
        } 
    }
      translate([mount_thickness+offset_len+7,0,0])
      hull(){
        translate([0,0,4.5]) 
          for(Y=[-1,1]) translate([0,(mount_width/2-5)*Y,0]) 
              cylinder(d=6,h=0.1,center=true,$fn=60);
        translate([0,0,-12]) 
          for(Y=[-1,1]) translate([0,(mount_width/2+5)*Y,0]) 
              sphere(d=6,$fn=60);
      }
    }
    translate([0,0,-1]) cylinder(d=14,h=30, center=true);
    translate([-dia/2+mount_thickness+offset_len+3,0,-22]) ray();
    translate([-365/2+offset_len,0,0]) cylinder(d=365,h=50, $fn=360, center=true);
  }
}

module ray(size=6,mount_width=100, mount_thickness=7.5, dia=365, height=20){
  intersection(){
    rotate_extrude($fn=360) translate([dia/2,0,0]) 
      hull(){
        square(size,center=true);
        translate([0,height,0]) circle(d=size, $fn=60);
      }
    translate([dia/2,0,height/2])
      cube([mount_thickness*2,mount_width+2,height*2], center=true);
  }
}