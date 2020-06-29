$fn=60;


//spacer(); // juice holder
spacer(inside_lip=50, outside_lip=59); 



module spacer(inside_lip=58, outside_lip=68){
    translate([0,0,20]) 
    difference(){
        cylinder(d1=80, d2=outside_lip+6, h=20);
        translate([0,0,-0.1]) 
            cylinder(d1=71, d2=inside_lip-6, h=21-5);
        translate([0,0,1]) cylinder(d=inside_lip-6, h=20);
        translate([0,0,15.1]) 
        difference(){
            cylinder(d=outside_lip, h=5);
            translate([0,0,-0.1]) cylinder(d=inside_lip, h=21);
        }
    }
    difference(){
        cylinder(d1=105, d2=80, h=20);
        translate([0,0,-0.1]) cylinder(d1=75, d2=70, h=25);
        for(R=[0,90,180,270]) rotate([0,0,R])
        translate([0,0,29]) rotate([0, 120, 0]) hull(){
            cylinder(d=20, h=100);
            translate([10,0,50]) cube([1, 20, 100], center=true);
        }
    }
}