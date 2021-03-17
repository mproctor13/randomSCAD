

%translate([0,-50,0]) cube([445,250,10]);

number("6524");
//translate([110,0,0]) number("5");
//translate([220,0,0]) number("2");
//translate([330,0,0]) number("4");
//text("6524", size=200);
use <StardosStencil-Regular.ttf>
module number(number=6){
    
    font="StardosStencil-Regular";
    fsize=150;
    difference(){
        linear_extrude(25)
            text(number, size=fsize, font=font,$fn=60);
//        difference(){
//            translate([0,0,-2])
//                linear_extrude(25) offset(r=-2)
//                    text(number, size=fsize, $fn=60);
//            difference(){
//                translate([0,0,-2])
//                    linear_extrude(25) offset(r=-4)
//                        text(number, size=fsize, $fn=60);
//                difference(){
//                    translate([0,0,-2])
//                        linear_extrude(25) offset(r=-6)
//                            text(number, size=fsize, $fn=60);
//                    difference(){
//                    translate([0,0,-2])
//                        linear_extrude(25) offset(r=-8)
//                            text(number, size=fsize, $fn=60);
//                    translate([0,0,-2])
//                        linear_extrude(25) offset(r=-10)
//                            text(number, size=fsize, $fn=60);
//                    }
//                }
//            }
//        }
//            translate([0,0,-4])
//                linear_extrude(25) offset(r=-2)
//                    text(number, size=200, $fn=60);
    }
}