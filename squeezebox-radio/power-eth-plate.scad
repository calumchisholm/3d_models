include <Round-Anything/polyround.scad>

/* [General] */
// Render detail level
$fn = 40;
// Arbitrary small value. Used when forcing perfectly abutting planes to overlap
fudge = 0.01;

/* [Solids] */
// Outer-facing part - a rounded cuboid.
outer_width = 36.2; //35;
outer_depth = 20;
outer_height = 1.8;
outer_corner_radius = 6.5;

// Inner-facing part - also a rounded cuboid, but smaller than the above.
inner_width = 34.2;
inner_depth = 18.0;
inner_height_1 = 0.9;
inner_height_2 = 8.5;
inner_corner_radius = 6.5;

// Number of subdivisions to use when forming a curve
corner_detail_level = 40;

// Full height of the model, plus fudge factor to ensure holes do not align with faces
full_height = outer_height + inner_height_2 + (2 * fudge);

/* [Holes] */
// Slopes
slope_offset_x = 2;
slope_cutout_width = 3;

// Slope angle. 
slope_angle_y = 15;

// PCB slot
pcb_slot_offset_y = 0;
pcb_slot_depth = 5;

// Ethernet connector.
eth_hole_offset_x = 4.0;
eth_hole_offset_y = 3.0;
eth_hole_width = 16.5;
eth_hole_depth = 14.0;

// Power connector.
power_barrel_offset_x = 29;
power_barrel_offset_y = 6.0;
power_barrel_diam = 5.5;
power_body_offset_x = 25.50;
power_body_offset_y = 3.25;
power_body_width = 6.8;
power_body_depth = 6.0;


module rounded_cuboid(width, depth, height, corner_radius) {
    linear_extrude(height) {
        polygon(polyRound([[0,     0,     corner_radius],
                           [width, 0,     corner_radius],
                           [width, depth, corner_radius],
                           [0,     depth, corner_radius]], corner_detail_level));
    }
}

difference() {
    color("#88AA88") {
        union() {
            // Outer-facing part
            rounded_cuboid(outer_width, outer_depth, outer_height, outer_corner_radius);

            // Inner part
            translate([(outer_width - inner_width) / 2,
                       (outer_depth - inner_depth) / 2,
                       outer_height - fudge]) {
                rounded_cuboid(inner_width, inner_depth, inner_height_2, inner_corner_radius);
            }
        }
    }

    // Remove slices from the inner layer
    translate([0, 0, outer_height + inner_height_1]) {
        // Horizontal slot to accommodate PCB
        translate([((outer_width - inner_width) / 2) - fudge, pcb_slot_offset_y, 0]) {
            cube([inner_width + 2 * fudge, pcb_slot_depth, inner_height_2 + fudge]);
        }

        // Left slope
        translate([0 - slope_offset_x, 0, 0]) {
            rotate([0, slope_angle_y, 0]) {
                cube([slope_cutout_width, outer_depth, inner_height_2 * 2]);
            }
        }
        
        // Right slope
        translate([outer_width + slope_offset_x, 0, 0]) {
            mirror([1, 0, 0]) {
                rotate([0, slope_angle_y, 0]) {
                    cube([slope_cutout_width, outer_depth, inner_height_2 * 20)]);
                }
            }
        }
    }

    // Remove slices from the full height of the model
    translate([0, 0, 0 - fudge]) {
        // Ethernet
        translate([eth_hole_offset_x, eth_hole_offset_y, 0]) {
            cube([eth_hole_width, eth_hole_depth, full_height]);
        }

        // Barrel section of the power socket
        translate([power_barrel_offset_x, power_barrel_offset_y, 0]) {
            cylinder(full_height, d = power_barrel_diam);
        }
    }
    
    // Box section of the power socket
    translate([power_body_offset_x, power_body_offset_y, outer_height]) {
        cube([power_body_width, power_body_depth, full_height]);
    }
}