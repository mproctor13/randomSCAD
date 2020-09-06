
$fn=60;
fudge=0.2;

difference(){
    union(){
        rotate([0,0,15]) translate([-75+7,-5-3,-9]) 
            import("../printer/top_z_bowden_holder_6_mm.stl");
        rotate([0,90,0]) cylinder(d=10, h=11, $fn=6);
    }
    translate([-1,0,0]) rotate([0,90,0]) cylinder(d=4.8, h=16);
    translate([6,0,0]) rotate([0,90,0]) cylinder(d1=4.8, d2=12, h=6);
}