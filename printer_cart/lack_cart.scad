
$fn=60;
use <lack_table.scad>;
fudge=0.2;

//translate([20,25,0]) rotate([90,0,0]) %front_alignment();
//translate([-119-107,25,0]) rotate([90,0,180]) %middle_alignment();
//drawer_slide();

//intersection(){
//    drawer_slide();
//    translate([-125,0,0]) cube([250,0.5,10], center=true);
//}
//intersection(){
//    drawer_slide();
//    translate([-248,0,0]) cube([20,0.5,50], center=true);
//}

//intersection(){
//    drawer_slide();
//    translate([125,0,0]) cube([250,0.5,10], center=true);
//}
//intersection(){
//    drawer_slide();
//    translate([248,0,0]) cube([20,0.5,50], center=true);
//}

//drawer_support2();
//drawer_support_link();
//intersection(){
//    drawer_support();
//    translate([-125,25,0]) cube([250,2,10], center=true);
//}
//intersection(){
//    drawer_support();
//    translate([-1,25-2.5,0]) cube([2,5,50], center=true);
//}

//drawer_slide();

//translate([0,0,0]) cylinder(d=4, h=3);
//translate([16,0,0]) cylinder(d=6, h=3);
//translate([8,0,-0.9]) cube([25,10,2],center=true);

//lack_spacer_back();
//lack_back();
//    rotate([0,0,-90]) drawer_support();
//    rotate([0,0,90]) drawer_support();

%cube([100,180,100], center=true);
lack_back();


//lack_spacer();
//lack_cart();
//lack_back();
//lack_spacer_back();

//translate([0,250,300]) %cube([450,50,50], center=true);
//translate([250,0,500]) %cube([50,440,50], center=true);

module front_alignment(){
    difference(){
        translate([-75,0,0]) cube([150,10,0.5],center=true);
        translate([-6,0,-1]) cylinder(d=4, h=3);
        translate([-35,0,-1]) cylinder(d=6, h=3);
        translate([-51,0,-1]) cylinder(d=4, h=3);
        translate([-99,0,-1]) cylinder(d=6, h=3);
        translate([-115,0,-1]) cylinder(d=4, h=3);
        translate([-139,0,-1]) cylinder(d=4, h=3);
    }
}

module middle_alignment(){
    difference(){
        translate([-65,0,0]) cube([130,10,0.5],center=true);
        translate([-7,0,-1]) cylinder(d=6, h=3);
        translate([-23,0,-1]) cylinder(d=4, h=3);
        translate([-103,0,-1]) cylinder(d=6, h=3);
        translate([-119,0,-1]) cylinder(d=4, h=3);
    }
}

module drawer_support2(length=222.5){
    difference(){
        drawer_support(length=length);
        translate([-5-length/2,-12.51+5,0]) 
            cube([length,55,25], center=true);
    }
}

module drawer_support(length=222.5){
    difference(){
        union(){
            translate([-length/2,0,0]) 
                cube([length,50,50], center=true);
            translate([-2.5,0,0]) 
                cube([5,50,150], center=true);
            hull(){
                translate([-2.5,22.5,0]) 
                    cube([5,5,150], center=true);
                translate([-50,22.5,0]) 
                    cube([50,5,50], center=true);
            }
        }
        translate([-5-length/2,-12.51,0]) 
            cube([length,25,25], center=true);
        translate([-length+25,-12.51,0]) 
            cube([10,25,40], center=true);
        for(X=[-15, -31, -79, -95, -119]) translate([X,0,0]) 
            rotate([90,0,0]) {
                cylinder(d=4.5, h=100, center=true);
                translate([0,0,-4]) fhex(m4_hex_nut+fudge,10);
            }
//        for(X=[-107, -123, -203, -219]) translate([X,0,0]) 
        for(X=[-110, -190, -206]) translate([X,0,0]) 
            rotate([90,0,0]) {
                cylinder(d=4.5, h=100, center=true);
                translate([0,0,-4]) fhex(m4_hex_nut+fudge,10);
            }
        for(Z=[-40,-65,40,65])
            translate([0,-4,Z]) rotate([0,90,0]) 
            cylinder(d=4.5, h=20, center=true);
    }
}

module lack_cart(height=100){
//    translate([0,0,50]) %cube([100,100,230]);

    translate([0,0,550]){
        translate([0,0,0]) color("blue") lack_table();
//        translate([0,0,-250]) %cube([100,100,650]);
    }
    translate([0,0,400]){
        translate([247.5, 0, 100]) lack_back();
        
        translate([247.5, 245, 50]) 
            lack_spacer_back(height=height);
        translate([247.5, -245, 150]) 
            rotate([180,0,0]) lack_spacer_back(height=height);
        translate([-247.5, -247.5, 50]) 
            rotate([0,0,180]) lack_spacer(height=height);
        translate([-247.5, 247.5, 50]) 
            rotate([0,0,90]) lack_spacer(height=height);
    }
//    for(X=[-1,1], Y=[-1,1]) translate([247.5*X, 247.5*Y, 50]) 
//        rotate([0,0,90*-X*-Y]) lack_spacer(height=100);
//
    translate([0,0,450+70]) color("green") 
        rotate([0,180,0]) lack_table();
//    translate([5,-250,195]) %cube([220,5,220]);
    translate([222.5,-250,300]) drawer_support();
    translate([-222.5,-250,300]) rotate([180,0,180]) drawer_support();
//    translate([0,-265,300]) drawer_support_link();
//    translate([0,-250,300]) rotate([0,180,0]) drawer_support();
    for(Y=[-1]) 
        %translate([-7.5,222.5*Y,301]) drawer_slide();
    for(X=[-1,1], Y=[-1,1]) translate([230*X, 230*Y, 0]) red_caster();
}

module drawer_support_link(){
    cube([50,25-fudge,25-fudge*2], center=true);
    for(X=[-1,1]) translate([25*X+fudge, 0, 0]) 
        cube([10-fudge*2, 25-fudge, 40-fudge*2], center=true);
}

module drawer_slide(){
    difference(){
        cube([500, 13, 45.5], center=true);
        translate([250,7.5,-1]) rotate([90,0,0]){
            translate([-6,0,-1]) cylinder(d=4, h=20);
            translate([-35,0,-1]) cylinder(d=6, h=20);
//            translate([-51,0,-1]) cylinder(d=4, h=20);
            translate([-51,0,-1]) hull()
            for(x=[-1,1]) translate([3*x, 0,0]) 
                cylinder(d=4.5, h=20);
            translate([-99,0,-1]) cylinder(d=6, h=20);
//            translate([-115,0,-1]) cylinder(d=4, h=20);
            translate([-115,0,-1]) hull()
            for(x=[-1,1]) translate([3*x, 0,0]) 
                cylinder(d=4.5, h=20);
//            translate([-139,0,-1]) cylinder(d=4, h=20);
            translate([-139,0,-1]) hull()
            for(x=[-1,1]) translate([3*x, 0,0]) 
                cylinder(d=4.5, h=20);
        }
        translate([0,7.5,-1]) rotate([90,0,0]){
            translate([-9,0,-1]) cylinder(d=6, h=20);
            translate([-25,0,-1]) cylinder(d=4, h=20);
            translate([-105,0,-1]) cylinder(d=6, h=20);
            translate([-121,0,-1]) cylinder(d=4, h=20);
        }
        for(Z=[-1,1]) translate([-250+6,0,7.5*Z]) 
            rotate([90,0,0]) cylinder(d=4.5, h=20, center=true);
    }
}

module lack_spacer_back(height=100, width=127.5){
    difference(){
        union(){
            lack_spacer(height=height);
            translate([0,-width/2-27.5,height/2]) 
                cube([55,width,50], center=true);
        }
        translate([7,-width-15,height/2])
            cube([41+fudge,30+fudge,25+fudge], center=true);
        translate([7,-width+5-fudge,height/2])
            cube([41+fudge,10+fudge*2,40+fudge], center=true);
    }
}

module lack_back(width=180){
    cube([55,width,50], center=true);
    for(X=[-1,1]){
        translate([7,((width/2)+14)*X,0])
            cube([41,30,25], center=true);
        translate([7,((width/2)+32.5-fudge)*X,0])
            cube([41,10,40], center=true);
    }
}

module lack_spacer(height=100){
    translate([2.5,2.5,height]) %cube([50,50,50], center=true);
    for(Z=[-20,height+20]) translate([0,0,Z])
    difference(){
        cube([55,55,40], center=true);
        translate([2.5,2.5,0]) cube([50,50,42], center=true);
        for(R=[-1,1]) translate([-24*R,24*R,0]) 
            rotate([0,0,45]) cube([40,5,42], center=true);
        translate([-25,25,0]) 
            cube([40,5,42], center=true);
        translate([25,-25,0]) 
            cube([5,40,42], center=true);
        for(R=[0,90]) rotate([0,90,R]) 
            cylinder(d=4.5, h=100, center=true);
    }
    translate([0,0,height/2]) cube([55,55,height], center=true);
}

module red_caster(){
    translate([0,0,70]) rotate([0,180,0]) union(){
        difference(){
            cube([50,50,1.40], center=true);
            
        }
        translate([20,0,45]) rotate([90,0,0])
            cylinder(d=49, h=20, center=true);
//    for(R=[0:10:660]) rotate([0,0,R])
//    translate([20,0,45]) rotate([90,0,0]) 
//        cylinder(d=49, h=20, center=true);
        translate([0,0,34.75]) 
            %cube([90,90,70], center=true);
    }
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
