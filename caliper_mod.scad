$fn=60;
difference(){
    import("../printer/Caliper_Plastic_Holder.stl");
    translate([75,30,0]) cube(20);
}
//translate([15,0,0]) intersection(){
//    import("../printer/Caliper_Plastic_Holder.stl");
//    translate([78.2,30,0]) cube(20);
//}
translate([96,39,0]) cylinder(d=6, h=15.25);
hull(){
translate([96,39,0]) cylinder(d=6, h=2);
translate([57,59.7,0]) cylinder(d=2, h=2);
translate([56,34,0]) cylinder(d=6, h=2);
}
