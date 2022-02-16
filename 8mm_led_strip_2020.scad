
//projection(cut=true)
//    import("../printer/led_mount_1cm.stl");

//linear_extrude(1) import("10mm_led_strip_2020.dxf");
linear_extrude(50) cutup(move=1);

//%cutup(move=0);
//cutup(move=1);

module cutup(move=2){
 difference(){
   rotate([0,0,-45]) import("10mm_led_strip_2020.dxf");
   translate([-7.8+move,0,0]) rotate([0,0,45]) square([8,8]);
 }
 translate([move,0,0]) 
 intersection(){
   rotate([0,0,-45]) import("10mm_led_strip_2020.dxf");
   translate([-8,-1.75,0]) square([8,8]);
 }
}