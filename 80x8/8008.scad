



module ldp8008(){
    color("white") cube([320, 31.8, 7.15], center=true);
    difference(){
        translate([0,0,-4.5]) color("black") cube([320, 54, 1.65], center=true);
        for(X=[-120, 0, 120], Y=[-22.5,22.5]) translate([X, Y, -5]) cylinder(d=5, h=3, center=true, $fn=30);
    }
    translate([0, 0, -13.5]) color("black") cube([14, 18, 16.4], center=true);
    for(X=[-154,154]) translate([X, 0, -13.5]) color("grey") cube([6, 25, 18], center=true);
}






ldp8008();


length=325;
fudge=0.2;
//translate([0,0,-17.5]) rotate([0, 90, 0]) rotate([0, 0, 120]) cylinder(d=85, h=3, center=true, $fn=3);
difference(){
    union(){
    hull(){
        for(Y=[-29.8, 29.8]) translate([0, Y, -0.4]) rotate([0, 90, 0])  cylinder(d=6, h=length, center=true, $fn=120);
    }
    difference(){
        hull(){
            for(Y=[-29.8, 29.8]) translate([0, Y, -0.4]) rotate([0, 90, 0])  cylinder(d=8, h=length, center=true, $fn=120);
            translate([0, 0, -52]) rotate([0, 90, 0])  cylinder(d=8, h=length, center=true, $fn=120);
        }
        translate([0,0,-17.5]) rotate([0, 90, 0]) rotate([0, 0, 120]) cylinder(d=70, h=322+5, center=true, $fn=3);
        
    }
    }
    translate([0,0,2]) cube([320+fudge, 31.8+fudge, 15], center=true);
}

