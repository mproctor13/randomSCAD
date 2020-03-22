
ss=39.75;
os=46;
height=40;
round_dia=5;
bar_dia=26;

//%translate([0, 0, 20]) cube([40,40,45], center=true);
rack_puck();
//rack_tube();
//%for(Y=[-1,1]) translate([(-(height/2)-5),((height/2)-3.5)*Y,height/2]) rotate([90,0,90]) cylinder(d=3.5, h=height+100, $fn=60);
rack_template();

module rack_puck(type="back"){
    if(type == "front"){
        difference(){
            rack_puck_internal();
            translate([-50,0,-50]) cube([100,100,100]);
        }
    }
    else if(type == "back"){
        difference(){
            rack_puck_internal();
            translate([-50,0,-50]) cube([100,100,100]);
        }
    }
    else{
        rack_puck_internal();
    }
}

module rack_puck_internal(){
    difference(){
        union(){
            hull() for(X=[-1,1], Y=[-1,1]){
                translate([(ss/2-(round_dia/2))*X, (ss/2-(round_dia/2))*Y, 0]) cylinder(d=round_dia, h=height, $fn=60);
            }
            hull() for(X=[-1,1], Y=[-1,1]){
                translate([(os/2-(round_dia/2))*X, (os/2-(round_dia/2))*Y, 0]) cylinder(d=round_dia, h=5, $fn=60);
            }
        }
        hull() for(X=[-1,1], Y=[-1,1]){
            translate([(bar_dia/2-(round_dia/2))*X, (bar_dia/2-(round_dia/2))*Y, -5]) cylinder(d=round_dia, h=height+10, $fn=60);
        }
        for(Y=[-1,1]) translate([(-(height/2)-5),((height/2)-3.5)*Y,height/2]) rotate([90,0,90]) cylinder(d=5, h=height+10, $fn=60);
    }
}

module rack_tube(){
    outer_dia=46;
    inner_dia=40;
    translate([0,0,5.0]) 
    difference(){
        union(){
            hull() for(X=[-1,1], Y=[-1,1]){
                translate([(outer_dia/2-(round_dia/2))*X, (outer_dia/2-(round_dia/2))*Y, 0]) cylinder(d=round_dia, h=height, $fn=60);
            }
        }
            hull() for(X=[-1,1], Y=[-1,1]){
                translate([(inner_dia/2-(round_dia/2))*X, (inner_dia/2-(round_dia/2))*Y, -2]) cylinder(d=round_dia, h=height+5, $fn=60);
            }
    }
    translate([0,0,-50]) color("silver") cylinder(d=bar_dia-1, h=height+100, $fn=60, center=false);
}

module rack_template(dia=2){
    difference(){
        translate([17,0,18]) cube([15,50,30], center=true);
        translate([0,0,20+5]) cube([46,46,40], center=true);
        for(Y=[-1,1]) translate([(-(height/2)-5),((height/2)-3.5)*Y,height/2]) rotate([90,0,90]) cylinder(d=dia, h=height+100, $fn=60);
        hull(){
            translate([-2,0,20]) cube([46,20,40], center=true);
            translate([-14,0,20]) cube([46,46,40], center=true);
        }
        translate([5,0,30]) rotate([0,45,0]) cube([20,51,40], center=true);
    }
}
