$fn=60;
width=30;
pad=5;
offset=3;
fudge=0.25;

//main_filler();
top_filler();

module top_filler(height=12){
intersection(){
    difference(){
        base_filler(height=height);
        for(Y=[-1,1]){
            translate([0,8*Y,-height/2-5]) 
                cylinder(d=8+fudge, h=10);
//            translate([0, ((width+pad)/2)*Y,0])
//            %cube([10, pad, height], center=true);
        }
    }
    cube([25, width, height], center=true);
}
}

module bottom_filler(height=40, inside=20, slot=15){
    difference(){
        base_filler(height=height);
        translate([0,0,(height/2)-inside+slot-3.5])
        hull(){
            for(X=[25, 5.9], Z=[0, -height])
            translate([X,offset/2,Z]) rotate([90,0,0]) 
            cylinder(d=7, h=offset*2+width+pad*2, center=true);
        }
    }
    for(Y=[-1,1]) translate([0,8*Y,height/2-5]) 
        cylinder(d=8, h=10);
}

module main_filler(height=100){
    difference(){
        base_filler(height=height);
        for(Y=[-1,1]) translate([0,8*Y,-height/2-5]) 
            cylinder(d=8+fudge, h=10);
    }
    for(Y=[-1,1]) translate([0,8*Y,height/2-5]) 
        cylinder(d=8, h=10);
}

module base_filler(height=100){
    difference(){
        union(){
            cube([20,width,height],center=true);
            translate([10,0,0]) 
                cube([10+pad,width+pad*2,height],center=true);
            translate([10,offset/2,0]) 
                cube([10+pad,offset+width+pad*2,height],center=true);
        }
        for(Y=[-1,1]) translate([-11,16*Y,0]) rotate([0,0,45*Y]) 
            cube([5,5,height+2], center=true);
        for(Y=[-1,1]) translate([2,(21+offset/2)*Y+(offset/2),0])
            rotate([0,0,45*Y]) 
            cube([5,5,height+2], center=true);
        for(Y=[-1,1]) translate([19,(21+offset/2)*Y+(offset/2),0])
            rotate([0,0,45*Y]) 
            cube([5,5,height+2], center=true);
        for(Y=[-1,1]) translate([19,(14+offset/2)*Y+(offset/2),0]) 
            rotate([0,0,45*Y]) 
            cube([5,5,height+2], center=true);
        translate([20,offset/2,0])
            cube([20,width+offset,height+2],center=true);
    }
}
