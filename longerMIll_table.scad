internal_width=1200;
internal_length=1200;
internal_height=600;

//2x4=38x89

base();
translate([0, -12*25.4, 600]) #cube([internal_width, internal_length, internal_height], center=true);
translate([0, -44.5-2, 44.5+914.4+38]) rotate([90,0,0])translate([0, -12*25.4, 0]) {
    platform();
    %translate([0, 0, 89+internal_height/2]) 
    cube([internal_width, internal_length, internal_height], center=true);
}
module base(){
    translate([0, 0, 38+914.4+19]) rotate([0,90,0]) 2by4(1219.2);
    translate([0, 0, 38]) for(X=[-2, -2/3, 2/3, 2]) 
        translate([(304.8-9.5)*X, 0, 457.2]) 2by4(914.4);
    translate([0, 0, 19]) rotate([0,90,0]) 2by4(1219.2);
}

module platform(){
    translate([0, 0, 44.5]) for(X=[-1, -1/3, 1/3, 1])
    translate([(609.6-19)*X, 0, 0]) rotate([90,0,0]) 2by4(1219.2);
    
    translate([0, 0, 44.5]) for(Y=[-1, 1])
    translate([0, (609.6-19)*Y, 0]) rotate([90,0,90]) 2by4(1219.2);
}

module 2by4(length=1000){
    cube([38, 89, length], center=true);
}
