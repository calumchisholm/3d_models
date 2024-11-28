$fn = 40;   // Render detail level

/**********************************************************************
 * Replacement paddle for morse key (model unknown)
 **********************************************************************/

include <Round-Anything/polyround.scad>

// All measurements in mm

// Body dimensions
body_depth = 49;
body_height = 4;
body_corner_radius = 3;
body_corner_detail = 30;

// Lug dimensions
lug_width = 3;
lug_depth = 8.25;
lug_height = 4;
lug_corner_radius = 1.5;
lug_corner_detail = 30;

// Lug positions
lug1_x = 7;
lug2_x = 18.5;
lug_y = body_depth - lug_depth;

// Hole
hole_x = 14.5;
hole_y = body_depth - (lug_depth / 2);
hole_r = 1.75;


module lug(x, y, z, width, depth, height, radius) {
    translate([x, y, z]) {
        linear_extrude(height) {
            polygon(polyRound([[0,     0,     radius],
                               [width, 0,     radius],
                               [width, depth, radius],
                               [0,     depth, radius]], lug_corner_detail));
        }
    }
}

color("#88AA88") {
    difference() {
        union() {
            // Main body
            linear_extrude(body_height) {
                polygon(polyRound([[0,  0,          body_corner_radius],
                                   [32, 0,          body_corner_radius],
                                   [32, body_depth, body_corner_radius],
                                   [7,  body_depth, lug_corner_radius],  // match the radius of the lug directly above
                                   [7,  25,         body_corner_radius],
                                   [0,  19,         body_corner_radius]], body_corner_detail));
            };

            // Lugs
            lug(lug1_x, lug_y, 0, lug_width, lug_depth, body_height + lug_height, lug_corner_radius);
            lug(lug2_x, lug_y, 0, lug_width, lug_depth, body_height + lug_height, lug_corner_radius);
        }
        
        // Hole
        translate([hole_x, hole_y, -1]) {
            cylinder(h = body_height + 2, r = hole_r);
        }

        // Chamfer
        translate([0, body_depth, -2.5]) {
            rotate([45, 0, 0]) {
                cube([lug2_x + lug_width, 3, 3]);
            }
        }
    }
}