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

module poe_full() {
    cube([5.5, 5.5, 8.5]);    
}

module gpio_full() {
    cube([51.5, 5.5, 8.5]);    
}

module flat_connector_full() {
    cube([2.5, 22, 5.5]);    
}

module usbc_full() {
    cube([9.0, 7.3, 3.2]);    
}

module hdmi_full() {
    cube([7.3, 8, 3.0]);    
}

module av_full() {
    translate([3.4, 12.7, 3])
        rotate([90, 0, 0]) {
            union() {
                translate([-3.4, -3.0, 0]) 
                    cube([6.8, 6.0, 12.7]);
                cylinder(d = 6, 15);
            }        
        }
}

module usb_full() {
    cube([17, 13.3, 15.0]);
    translate([17, -0.8, 0])
        cube([0.5, 14.9, 16]);
}

module eth_full() {
    cube([21.3, 16, 13.5]);
}

module sdcard_full() {
    cube([11.5, 12, 1.8]); 
}

module sdcard_full_with_card() {
    cube([11.5, 12, 1.8]); 
    translate([-3.5, 0.5, 0])
        cube([15.5, 11, 1.8]); 
}

module cpu_full() {
    cube([15, 15, 2.4]); 
}

module memory_full() {
    cube([10, 14.5, 1.0]); 
}

module eth_chip_full() {
    cube([6, 6, 1.0]); 
}

module usb_chip_full() {
    cube([8, 8, 1.0]); 
}
module wifi_full() {
    cube([11, 13, 1.0]); 
}

// More detailed devices
module av_hollow() {
    translate([0, 3.4, 3])
        rotate([-90, 0, -90]) {
            difference()
            {
                union() {
                    translate([-3.4, -3.0, 0]) 
                        cube([6.8, 6.0, 12.7]);
                    cylinder(d = 6, 15);
                }
                translate([0,0,-1]) 
                    cylinder(d = 3.5, 17);
            }
        }
}

module pcb()
{
    difference() {
        translate([3, 3, 0]) {
            minkowski() {
                cube([85 - 6, 56 - 6, 0.8]);
                cylinder(r = 3, 0.8);        
            }
        }
        union() {
            translate([3.5, 3.5, -0.1])
                cylinder(d=2.7, 2);
            translate([3.5, 52.5, -0.1])
                cylinder(d=2.7, 2);
            translate([61.5, 3.5, -0.1])
                cylinder(d=2.7, 2);
            translate([61.5, 52.5, -0.1])
                cylinder(d=2.7, 2);
        }
    }
}

module raspberrypi4b(withpcb, withsdcard) {
    transpose_z = withpcb ? 1.6 : 0;

    if (withpcb) {
        pcb();
    }

    if (withsdcard) {
        translate([13-11.5, 22, -1.8])
//            sdcard_full();
            sdcard_full_with_card();
    }

    translate([58.75, 43.61, transpose_z])
        poe_full();
    translate([6.75, 49.75, transpose_z])
        gpio_full();
    translate([2.75, 17, transpose_z])
        flat_connector_full();
    translate([45.25, 0.5, transpose_z])
        flat_connector_full();
    translate([6.7, -1, transpose_z])
        usbc_full();
    translate([21.5, -1, transpose_z])
        hdmi_full();
    translate([35, -1, transpose_z])
        hdmi_full();
    translate([49.5, -1, transpose_z])
        av_full();
    translate([70, 2.35, transpose_z])
        usb_full();
    translate([70, 20.35, transpose_z])
        usb_full();
    translate([66.2, 37.75, transpose_z])
        eth_full();

    // Chips
    translate([21.75, 25, transpose_z])
        cpu_full();
    translate([40, 25.7, transpose_z])
        memory_full();
    translate([55.5, 35.5, transpose_z])
        eth_chip_full();
    translate([55, 20, transpose_z])
        usb_chip_full();
    translate([6.5, 36, transpose_z])
        wifi_full();
}

raspberrypi4b(1, 0);
