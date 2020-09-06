
$fn=120;
fudge=0.2;

//%translate([0,0,20]) 
//    import("../printer/Bogies/files/CasterTInner.stl");
//translate([0,0,20]) 
//    import("../printer/Bogies/files/CasterInner.stl");
//%translate([0,0,20]) 
//    import("../printer/Bogies/files/CasterOuter.stl");

//inner_caster();
//outer_caster();

//inner_caster(od=57, rd=41);
outer_caster(od=57, rd=41);

module outer_caster(od=52, rd=36){
    translate([0,0,40]) rotate([180,0,0])
    difference(){
        inner_caster_lobe(od=od, rd=rd);
        translate([0,0,-0.1]) cylinder(d=30+fudge, h=40);
    }
}

module inner_caster(od=52, rd=36){
    difference(){
        union(){
            inner_caster_lobe(od=od, rd=rd);
            cylinder(d=30, h=40);
        }
        translate([0,0,-0.05]) bearing_cutout();
        translate([0,0,40.05]) rotate([180,0,0]) 
            bearing_cutout();
    }
}

module inner_caster_lobe(od=52, rd=36){
    cylinder(d=rd, h=20);
    hull(){
        cylinder(d=od, h=16);
        cylinder(d=rd-1, h=17.5);
    }
}

module bearing_cutout(){
    cylinder(d=4.5+fudge, h=45);
    hull(){
        cylinder(d=22+fudge, h=7);
        cylinder(d=4.5+fudge, h=15.7);
    }
}