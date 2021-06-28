
brew_jacket_mount();

module brew_jacket_mount(offset_len=-75,mount_width=50,mount_thickness=7.5){
  %translate([-16.5,0,2])
    import("../printer/brewbubble/Bubble Counter Holder with Collimator.stl");

  difference(){
    hull(){
      cylinder(d=35,h=5, $fn=60);
      translate([offset_len,0,-7.5])
        %cube([mount_thickness,mount_width,25], center=true);
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