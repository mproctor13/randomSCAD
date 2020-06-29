
$fn=60;


//stress_support();
//stress_support(side=1);
//inner();
hose_support();


module hose_support(side=2){
    difference(){
        union(){
            translate([0,0,0]) cylinder(d=20, h=10);
            translate([0,0,10]) cylinder(d1=20, d2=10, h=20);
            
            for(Y=[-1,1])
            translate([0,10*Y,5]) rotate([0,90,0]) 
                cylinder(d=8, h=10, center=true);
        }
        translate([0,0,7.5]) fhex(wid=13.2,height=15);
        translate([0,0,0]) cylinder(d=6.5, h=50);
        
        for(Y=[-1,1]){
            translate([0,10*Y,5]) rotate([0,90,0]) 
                cylinder(d=3.4, h=20, center=true);
            for(X=[-1,1])
            translate([10*X,10*Y,5]) rotate([0,90,0]) 
                cylinder(d=8, h=10, center=true);
            
            translate([3.5,10*Y,5]) rotate([0,90,0]) 
                fhex(wid=m3_hex_nut+0.2,height=m3_nut_height+1);
        }
        if( side == 1 ){
            translate([0,-15,-50]) cube([20,30,100]);
        }
        else if( side == 2 ){
            translate([-20,-15,-50]) cube([20,30,100]);
        }
    }
}

module inner(){
    translate([0,0,5]) cylinder(d=10.85, h=20);
    fhex(wid=13,height=10.6);
    translate([0,0,-25]) cylinder(d=6.5, h=20);
}

module stress_support(side=2){
    difference(){
        union(){
            translate([0,0,-25]) cylinder(d1=10, d2=25, h=20);
            translate([0,0,-5]) cylinder(d=25, h=30);
            translate([0,0,25]) cylinder(d1=25, d2=15, h=10);
            for(Y=[-1,1]) translate([0,10*Y,0]) rotate([0,90,0])
                cylinder(d=7, h=15, center=true);
            for(Y=[-1,1], Z=[10,20]) translate([0,9*Y,Z])
                rotate([0,90,0]) 
                cylinder(d=7, h=15, center=true);
            for(Y=[-1,1]) translate([0,6*Y,-10]){
                translate([5,0,0]) rotate([0,90,0]) 
                    cylinder(d=8, h=8, center=true);
                rotate([0,90,0]) 
                    cylinder(d=7, h=15, center=true);
            }
        }
        translate([0,0,-5]) cylinder(d=10.95, h=50);
        fhex(wid=13.2,height=10.6);
        translate([0,0,-60]) cylinder(d=6.5, h=75);
        if( side == 1 ){
            translate([0,-15,-50]) cube([20,30,100]);
        }
        else if( side == 2 ){
            translate([-20,-15,-50]) cube([20,30,100]);
        }
        for(Y=[-1,1]) translate([0,10*Y,0]){
            rotate([0,90,0]) cylinder(d=3.4, h=100, center=true);
            translate([8,0,0]) rotate([0,90,0]) 
                fhex(wid=m3_hex_nut+0.2,height=m3_nut_height*3);
        }
        for(Y=[-1,1], Z=[10,20]) translate([0,9*Y,Z]){
            rotate([0,90,0]) cylinder(d=3.4, h=100, center=true);
            translate([8,0,0]) rotate([0,90,0]) 
                fhex(wid=m3_hex_nut+0.2,height=m3_nut_height*3);
        }
        for(Y=[-1,1]) translate([0,6*Y,-10]){
            rotate([0,90,0]) cylinder(d=3.4, h=100, center=true);
            translate([-10,0,0]) rotate([0,90,0]) 
                cylinder(d=7, h=5, center=true);
            translate([10,0,0]) rotate([0,90,0]) 
                fhex(wid=m3_hex_nut+0.2,height=m3_nut_height*3);
            translate([11.5,0,0]) rotate([0,90,0]) 
                cylinder(d=8, h=5, center=true);
        }
        for(Y=[-1,1], X=[-1,1]) translate([10*X,10*Y,0]) rotate([0,90,0])
            cylinder(d=7, h=5, center=true);
        for(Y=[-1,1], X=[-1,1], Z=[10,20]) translate([10*X,9*Y,Z])
            rotate([0,90,0]) 
            cylinder(d=7, h=5, center=true);
    }
}

m3_hex_nut=5.6;
m3_nut_height=2.25;

module fhex(wid,height){
  hull(){
    cube([wid/1.7,wid,height],center=true);
    rotate([0,0,120]) cube([wid/1.7,wid,height], center=true);
    rotate([0,0,240]) cube([wid/1.7,wid,height], center=true);
  }
}