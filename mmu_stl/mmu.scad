
$fn=60;
sq_nutX=5.5;
sq_nutY=2;
offset=-31;
//assembly(offset);
//mmu();
pinda_mount(offset);

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

module pinda_mount(offset=-10, use_round=false){
    rotate([90,0,0])
    difference(){
        hull(){
            for(X=[-1,1]) translate([15*X,0,0]) 
                cylinder(d=6, h=2);
            for(X=[-1,1]) translate([9*X,offset,0]) 
                cylinder(d=6, h=2);
        }
        for(X=[-1,1]) translate([15*X,0,0]) 
            cylinder(d=3.3, h=10);
    }
    difference(){
        union(){
            hull(){
                translate([0,10,offset]) 
                    cube([18,1,6], center=true);
                translate([0,-0.5,(offset/2)]) 
                    cube([18,1,6+abs(offset)], center=true);
            }
            translate([0,10,offset]) 
                cylinder(d=18, h=6, center=true);
        }
        if( use_round ){
            translate([0,10,offset+abs(offset/2)+3]) 
                cylinder(d=16, h=abs(offset), center=true);
            translate([0,10,offset-abs(offset/2)-3]) 
                cylinder(d=16, h=abs(offset), center=true);
        }
        else{
            translate([0,10,offset+abs(offset/2)+1]) 
                fhex(12, abs(offset));
            translate([0,10,offset-abs(offset/2)-3]) 
                fhex(12, abs(offset));
        }
        translate([0,10,offset-4]) cylinder(d=8, h=8);
    }
}

module pinda(){
    color("black") cylinder(d=6.4, h=5);
    color("silver") translate([0,0,5]) cylinder(d=7.8, h=30);
    color("red") translate([0,0,35]) cylinder(d1=8.1, d2=4.77, h=25);
    color("black") translate([0,0,60]) cylinder(d=2.8, h=25);
    translate([0,0,10]) pinda_nut();
    translate([0,0,18]) pinda_nut();
}

module pinda_nut(){
    color("silver") rotate([0,0,0]) fhex(11.8,3.9);
}

module assembly(offset=-10){
  translate([0,-2,-12]) rotate([90,0,0])
    import("MPMU_D6_Helix_e3D_Body_v1.stl");
  translate([0,-2,-12]) rotate([90,0,0]) mmu();
  pinda_mount(offset);
  translate([0,10,-15+offset]) pinda();
}

m3_hex_nut=5.6;
m3_nut_height=2.25;
m4_hex_nut=7.2;
m4_nut_height=2.9;
m5_hex_nut=7.8;
m5_nut_height=3.9;

module fhex(wid,height){
  hull(){
    cube([wid/1.7,wid,height],center=true);
    rotate([0,0,120]) cube([wid/1.7,wid,height], center=true);
    rotate([0,0,240]) cube([wid/1.7,wid,height], center=true);
  }
}
