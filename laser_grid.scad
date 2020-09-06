
diameter=40;
spacer_width=120;
bed_depth=545;
bed_width=745;

material_depth=304;
material_width=609.6;


//#cube([material_width, material_depth, 6], center=true);
//%cube([bed_width, bed_depth, 30], center=true);
//assembly();

//%cube([spacer_width, bed_depth, 6], center=true);
//%cube([spacer_width/2, bed_depth, 6]);
rotate([0,0,90]) 
projection(cut = false) spacer();

module assembly(){
  for(X=[-1,1]) translate([((bed_width-spacer_width)/2)*X,0,0]) mirror([1-X,0,0]) spacer();
}

module spacer(width=spacer_width){
  difference(){
    hull()
      for(X=[-1,1], Y=[-1,1]) 
        translate([(width-diameter)/2*X, (bed_depth-diameter)/2*Y, 0])
          cylinder(d=diameter, h=6);
    translate([-(bed_width-material_width)/2-(bed_width-material_width)/2,0,0])
      translate([width/2,-material_depth/2,0])
        cube([(bed_width-material_width)/2,material_depth,10]);
    for(Y=[-1,1]){
      translate([width/2-(bed_width-material_width)/2,material_depth/2*Y,0])
        cylinder(d=20, h=14, center=true);
      translate([0,(bed_depth/2-60)*Y,0])
        cylinder(d=60, h=14, center=true);
    }
  }
}


