
ss=39.75;
os=46;
height=40;
round_dia=5;

//%translate([0, 0, 20]) cube([40,40,45], center=true);
difference(){
    union(){
        hull() for(X=[-1,1], Y=[-1,1]){
            translate([(ss/2-(round_dia/2))*X, (ss/2-(round_dia/2))*Y, 0]) cylinder(d=round_dia, h=height, $fn=60);
        }
        hull() for(X=[-1,1], Y=[-1,1]){
            translate([(os/2-(round_dia/2))*X, (os/2-(round_dia/2))*Y, 0]) cylinder(d=round_dia, h=5, $fn=60);
        }
    }
    translate([0,0,-5]) cylinder(d=26, h=height+10, $fn=60, center=false);
}

