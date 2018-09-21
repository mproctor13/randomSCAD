

// START CR10
// 600mm width  | 24"
// 700mm depth  | 28"
// 900mm tall    | 36"
// END CR10

// START CART
// width 26.5"
// Depth 18"
// Height 24"
// END CART

material_width=(25.4*12*4)/2;// 600;
material_depth=750;
material_height=900;
material_thickness=(25.4*1.5);

vertial_offset=material_thickness+5;

sheet_width=25.4*12*4;
sheet_length=25.4*12*8;

module bottom(){
  cube([material_width, material_depth, material_thickness]);
}

module top(){
  cube([material_width, material_depth, material_thickness]);
}

module back(){
  cube([material_width, material_thickness, material_height+(material_thickness*2)]);
}

module front(){
  cube([material_width, material_thickness, material_height+(material_thickness*2)]);
}


module side(){
  cube([material_thickness, material_depth, material_height]);
}

module blown_assembled(){
  translate([0,0,material_height+vertial_offset+5]) top();
  bottom();
  translate([0,material_depth+5,0]) back();
  translate([0,0, vertial_offset]) side();
  translate([material_width-material_thickness,0, vertial_offset]) side();
  translate([0,-material_thickness-5,0]) front();
}

module sheet(){
  %cube([sheet_width, sheet_length, 1]);
}

module layout(){
  sheet();
  translate([0,0,0])
  projection(cut = true) bottom();
  translate([(25.4*12*4)-material_width,0,0]) projection(cut = true) top();
  
  translate([0,material_depth+1,0]) 
  projection(cut = true) rotate([0,90,0]) side();
  
  
  translate([0,(material_depth+1)*2,0]) 
  projection(cut = true) rotate([0,90,0]) side();
  
  translate([-sheet_width-100,0,0]){
    sheet();
    projection(cut = true) rotate([-90,0,0]) back();
    translate([(25.4*12*4)-material_width,0,0]) 
    projection(cut = true) rotate([-90,0,0]) front();
    
    
    
    // Cart parts
    translate([0,material_height+(material_thickness*2)+5,0]) 
    rotate([0,90,0]) cart_back();
    
    translate([0,(material_height+(material_thickness*2)+(25.4*26.5))+10,0]) 
    rotate([0,90,0]) cart_back();
    
    translate([(25.4*12*2),material_height+(material_thickness*2)+5,0]) 
    rotate([90,0,90]) cart_side();
    
    translate([(25.4*12*2),material_height+(material_thickness*2)+(25.4*18)+10,0]) 
    rotate([90,0,90]) cart_side();
  }
}

module cart_side(){
  cube([(25.4*18), material_thickness, (25.4*24)]);
}

module cart_back(){
  cube([material_thickness, (25.4*26.5), (25.4*24)]);
}

blown_assembled();
//layout();





