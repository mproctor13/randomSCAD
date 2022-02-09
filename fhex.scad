

m2_5_hex_nut=5; //4.94
m2_5_nut_height=1.85;
m3_hex_nut=5.6;
m3_nut_height=2.25;
m4_hex_nut=7.2;
m4_nut_height=2.9;
m5_hex_nut=7.8;
m5_nut_height=3.9;

module fhex(wid,height){
  hull(){
    cube([wid/1.7,wid,height],center=true);
    rotate([0,0,120]) cube([wid/1.7,wid,height], center=true);
    rotate([0,0,240]) cube([wid/1.7,wid,height], center=true);
  }
}
