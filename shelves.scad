

module tube(length=30, width=1, depth=1){
    difference(){
        cube([width*25.4,length*25.4,depth*25.4], center=true);
        cube([(width*25.4)-1.651,(length*25.4)+2,(depth*25.4)-1.651], center=true);
    }
}

module main_tube(){
    difference(){
        tube(36);
        for(Y=[-1,1]) translate([0,((18*25.4)+8.5)*Y,0]) rotate([45*Y,0,0]) 
            cube([30,30,90], center=true);
    }
}

module upright_frame(){
    for(Y=[-1,1]) translate([0,(17.5*25.4)*Y,(18*25.4)]) rotate([90*Y,0,0]) main_tube();
    translate([0,0,(0.5*25.4)]) rotate([0,R,0]) main_tube();
    translate([0,0,(35.5*25.4)]) rotate([0,180,0]) main_tube();
}

module shelf(width=36, depth=15.5, height=0.75){
    color("grey") 
    difference(){
        cube([depth*25.4,width*25.4,height*25.4], center=true);
        translate([0,0,-0.8]) cube([(depth*25.4)-0.8,(width*25.4)-0.8,height*25.4], center=true);
    }
}

module plate(length=2.5, width=4){
    translate([0,0,(3.175/2)]) color("silver") cube([width*25.4,length*25.4,3.175], center=true);
}

for(X=[-1,1], Y=[-1,1], Z=[0,36]) translate([(5.5*25.4)*X,(15.75*25.4)*Y,Z*25.4]) plate();
for(Y=[-17.5, -14, 14, 17.5]) translate([0,Y*25.4,(35.5*25.4)]) rotate([0,0,90]) tube(length=16);


for(Y=[-17.5, -14, 14, 17.5]) translate([0,Y*25.4,(0.5*25.4)]) rotate([0,0,90]) tube(length=16);
//shelf();
for(X=[-1,1]) translate([(8*25.4)*X,0,0]) upright_frame();
