$fn=30;
tool_size=10;
//double_wrench=true;
//double_point=true;
name_text="MPROCTOR13";
double_point=false;
fudge=0.2;
thickness=5;
length=100;

wrench();

module wrench(){
    difference(){
        union(){
            translate([0,length/2,0]) open_end();
            difference(){
                hull() for(X=[-1,1]) 
                    translate([tool_size/4*X, 0, 0])
                        rotate([90,0,0]) 
                        cylinder(d=thickness, h=length, 
                                    center=true);
                for(Y=[-1,1]) translate([0,length/2*Y,0]) 
                cylinder(d=tool_size+(tool_size/3), 
                         center=true, h=thickness);
        }
            translate([0,-length/2,0]) closed_end();
        }
        translate([0,(length/2)-tool_size+(tool_size/2),-thickness/2]) 
            rotate([0,0,90]) mirror([1,0,0]) version_text();
        translate([0,0,(thickness/2)-2]) name();
    }
}

module name(){
    difference(){
    hull() for(Y=[-1,1]) 
        translate([0,(length-(tool_size/2))/4*Y,0]) 
        cylinder(d=tool_size/2, h=2);
    translate([0,0,-0.1])
    rotate([0,0,-90]) linear_extrude(height = 1)
    text(name_text,font = "helvetica:style=Bold", size=4, 
            halign="center", valign="center");
    }
}

module open_end(){
    difference(){
        rotate([0,0,30]) closed_end(dual_point=false);
        translate([0,7.5+tool_size/2.5,0]) for(R=[-1,1])
            rotate([0,0,10*R])
            cube([tool_size*2,15,thickness+2], 
                    center=true);
    }
}

module closed_end(dual_point=double_point){
    difference(){
        intersection(){
            sphere(d=tool_size+(tool_size/2));
            cylinder(d=tool_size+(tool_size/2), 
                        center=true, h=thickness);
        }
        fhex(tool_size+fudge,thickness+2);
        if(dual_point){
            rotate([0,0,30]) fhex(tool_size+fudge,thickness+2);
        }
    }
}

module version_text(){
    linear_extrude(height = 0.8) 
    text(str(tool_size),font = "helvetica:style=Bold", size=6, halign="left", valign="center");
}

module fhex(wid,height){
  hull(){
    cube([wid/1.7,wid,height],center=true);
    rotate([0,0,120]) cube([wid/1.7,wid,height], center=true);
    rotate([0,0,240]) cube([wid/1.7,wid,height], center=true);
  }
}
