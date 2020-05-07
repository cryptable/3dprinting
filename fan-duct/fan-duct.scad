/*
 * Title:   Fan duct for FLSun Cube
 * Author:  David Tillemans
 * Version: 0.1
 * Date:    06 May 2020
 * License: CC BY-SA 4.0
 *
 * Explanation:
 * This is the first prototype to add a Fan duct to the printer. It is designed with openscad as simple
 * as possible.
 * 
 */

module mounting_plate() {
    difference() {
        cube([39, 75, 3], center=true);
        translate([20,9,-0.5]) cube([24, 15.5, 7], center=true);    
        translate([20,-9,-0.5]) cube([24, 15.5, 7], center=true);    
    }

}

module fan_entry() {
    difference() {
        cube([24.0, 19.5, 5], center=true);
        translate([0,0,-0.5]) cube([20, 15.5, 7], center=true);    
    }
}

module fan_entry_tube() {
    difference() {
        hull() {
            translate([0, 0, -11]) cube([24.0, 19.5, 1], center=true);
            cylinder(r = 15, 1);;        
        }
        scale([0.8, 0.8, 1]) hull() {
            translate([0, 0, -11]) cube([24.0, 19.5, 2], center=true);
            cylinder(r = 15, 2);;        
        }
    }
}

module double_tube() {

    translate([42.5, 0, -42.5]) mounting_plate();
    translate([60, -9, -41.5]) fan_entry(); 
    translate([60, -9, -28]) fan_entry_tube(); 
    linear_extrude(height = 58, center = true, convexity = 10, twist = 120, scale=0.1) translate([60, -9, 0], $fn=100) {
        difference() {
            circle(r = 15);
            circle(r = 12);
        }
    }

    translate([60, 9, -41.5]) fan_entry(); 
    translate([60, 9, -28]) fan_entry_tube(); 
    linear_extrude(height = 58, center = true, convexity = 10, twist = -120, scale=0.1) translate([60, 9, 0], $fn=100) {
        difference() {
            circle(r = 15);
            circle(r = 12);
        }
    }
}

difference() {
    translate([0,0,44]) double_tube();
    #translate([0,0,89]) cube([50,15,80], center=true);
}

// translate([0,0,0]) color("blue") cube([100,100,1],center=true);
// translate([0,0,72]) color("green") cube([100,100,1],center=true);