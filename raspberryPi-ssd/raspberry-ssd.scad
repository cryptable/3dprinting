/*
 * Title:   Raspberry Pi 4B
 * Author:  David Tillemans
 * Version: 0.1
 * Date:    06 May 2020
 * License: CC BY-SA 4.0
 *
 * Explanation
 * Dimensions of raspberry pi is:
 * Total Width = 88 (USB and ethernet stick out)
 * Total Breath = 58.3 (USB-C, HDMIs and AV stick out)
 * Details found on: https://www.raspberrypi.org/documentation/hardware/raspberrypi/mechanical/rpi_MECH_4b_4p0.pdf
 * 
 * raspberrypi4b(withpcb, withsdcard) : draws a raspberry Pi 4B 
 *     with withpcb = 0 : no pcb is drawn on the location of the components
 *     with withpcb = 1 : pcb is drawn with the components
 *     with withsdcard = 0 : no sdcard is drawn
 *     with withsdcard = 1 : the sdcard is drawn
 *            
 */

module bottom_plate() {
    difference() {
        translate([3, 3, 0]) {
            minkowski() {
                cube([100 - 6, 76 - 6, 2.2]); // Thickness 3
                cylinder(r = 3, 0.8);        
            }
            translate([12,0,-4]) cube([3, 76 - 6, 4]);
            translate([74.5,0,-4]) cube([3, 76 - 6, 4]);
        }
        union() {
            translate([19.3,0,-1]) cube([56.8,3.2,5]);
            translate([19.3,72.8,-1]) cube([56.8,3.2,5]);
            
            translate([9.4,7.15,-1]) cylinder(d=3.2, 5);
            translate([9.4,68.86,-1]) cylinder(d=3.2, 5);
            translate([86,7.15,-1]) cylinder(d=3.2, 5);
            translate([86,68.86,-1]) cylinder(d=3.2, 5);
        }
    }
}

module side_supports() {
    translate([3, 0, 0]) {
        side_support();
    }
    
    translate([3, 73, 0]) {
        side_support();
    }
}

module side_support() {
    difference() {
        cube([94, 3, 15]);
        union() {
            translate([6.4,-1,6]) rotate([-90,0,0]) cylinder(d=3.2, 5);
            translate([83,-1,6]) rotate([-90,0,0]) cylinder(d=3.2, 5);
            translate([-1,-1,-1]) cube([17.4, 5, 4]);
            translate([73,-1,-1]) cube([22, 5, 4]);
        }
    }    
}

module pi_support_left() {   
    difference() {
        difference() {
            union() {
                cube([90, 16, 4]);
                translate([2.5,0,4]) cube([6,16,2.2]);
                translate([61.5,0,4]) cube([5,16,2.2]);
            } 
            union() {
                translate([6,13.5,2]) cylinder(d=2.7, 8);
                translate([64,13.5,2]) cylinder(d=2.7, 8);
            }
        }
        translate([6,13.5,-1]) cylinder(d=5, 3);
        translate([64,13.5,-1]) cylinder(d=5, 3);
    }
}

module support_left() {
    side_support();
    translate([0,0,15]) pi_support_left();
}

module support_right() {
    mirror([0,1,0]) support_left();
}

module complete_case() {
    translate([3,76,0]) support_right();
    translate([3,0,0]) support_left();
    bottom_plate();
}

module build_topology() {
    translate([10,-10,3]) rotate([180,0,0]) bottom_plate();
    translate([10,25,0])  rotate([90,0,0]) support_left();
    translate([-10,-60,0])  rotate([-90,0,90]) support_right();
    
}

// side_support();
// bottom_plate();
// side_supports();
// translate([9.4,7.15,-1]) cylinder(d=3.2, 5);

// translate([3,76,0]) support_right();
// translate([3,0,0]) support_left();
// complete_case();
// build_topology();
pi_support_left();