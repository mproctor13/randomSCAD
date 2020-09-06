base_thickness=8;
base_edge_width=2;
card_width = 79.3;
card_thickness = 2;
ball_size=2.85;
fudge=0.2;

//balls_per_side=[0]; // one ball
//balls_per_side=[-1,1]; // two balls
balls_per_side=[-1,0,1]; // three balls

settlers_base();
//settlers_fill();

module settlers_fill(){
    translate([0,0,-card_thickness/2*0.9]){
        difference(){
            fhex(card_width-5.5-fudge,(base_thickness-card_thickness)*0.9); //inner filler
            fhex(card_width-8.5-fudge,((base_thickness-card_thickness)*0.9)+0.2); //inner cutour
            for(R=[0:60:360]) rotate([0,0,R]){
                translate([0, -card_width-5.5-fudge, -5]) 
                    rotate([45,0,0]) cube([100,5,5], center=true);
            }
        }
    }
        for(R=[0:60:360]) rotate([0,0,R]){
            for(O=balls_per_side) {
                translate([15*O, 2.5-card_width/2, 0]) 
                   sphere(d=ball_size, $fn=30);
            }
        }
}

module settlers_base(){
    difference(){
        fhex(card_width+base_edge_width*2,base_thickness);
        translate([0,0,(base_thickness/2)-card_thickness/2+0.001])
            fhex(card_width,card_thickness); //card cutout
        fhex(card_width-5.5,base_thickness+0.002); //inner cutout
        for(R=[0:60:360]) rotate([0,0,R]){
            for(O=balls_per_side) {
            translate([15*O, -card_width/2, 0]) rotate([90,0,0]) 
                cylinder(d1=ball_size*.8, 
                          d2=ball_size*.5, 
                          h=10, center=true, $fn=60);
            translate([15*O, -card_width/2+3.5, 0]) rotate([90,0,0]) 
                cylinder(d=ball_size*1.2, h=10, 
                          center=true, $fn=60);
            }
            translate([0, -base_edge_width-2-card_width/2, -5]) 
                rotate([45,0,0]) cube([100,5,5], center=true);
        }
    }
}

module fhex(wid,height){
  hull(){
    cube([wid/1.7,wid,height],center=true);
    rotate([0,0,120]) cube([wid/1.7,wid,height], center=true);
    rotate([0,0,240]) cube([wid/1.7,wid,height], center=true);
  }
}