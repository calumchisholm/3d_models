$fn = 80;   // Render detail level

/**********************************************************************
 * Replacement temperature knob for an Adax VP11 electric panel heater
 **********************************************************************/

/* [Knob body] */
// Body height
body_height = 5.5;
// Body radius
body_radius = 15.5;

// Cavity height
cavity_height = 3.0;
// Cavity radius
cavity_radius = 13.5;
cavity_base = (body_height - cavity_height);


/* [Grips and indicator] */
// Height of the disk cut-outs used to form the grip
grip_cutout_height = 4.0;
// Y-offset of the disk cut-outs used to form the grip
grip_cutout_offset_y = 2.25;
// Z-offset of the disk cut-outs used to form the grip
grip_cutout_offset_z = -8.5;
// Radius of the disk cut-outs used to form the grip
grip_cutout_radius = 50.0;
// Angle to tilt the disk cut-outs used to form the grip
grip_cutout_angle = 7.0;

// Indicator dot height
indicator_height = 0.5;
// Indicator dot radius
indicator_radius = 1.0;
// Indicator dot x-offset from center
indicator_offset_x = 12;


/* [Connector and endstop] */
// Connector height
connector_height = 6.0;
// Connector outer radius
connector_radius_outer = 4.5;
// Connector inner radius
connector_radius_inner = 3.125;

// Key offset (x) from connector center
key_offset_x = 1.5;

// Depth (y) of the endstop
endstop_depth = 2.5;


/* [Hidden] */
fudge = 0.01; // Fudge factor used to ensure planes overlap

color("#99BB99") {
    difference() {
        // Main body
        cylinder(h = body_height, r = body_radius, center = false);

        // Back cavity
        translate([0, 0, cavity_base]) {
            cylinder(h = cavity_height + fudge, r = cavity_radius, center = false);
        }

        // Front grip - bottom
        translate([0, -grip_cutout_radius - grip_cutout_offset_y, grip_cutout_offset_z]) {
            rotate([grip_cutout_angle, 0, 0]) {
                cylinder(h = grip_cutout_height, r = grip_cutout_radius, center = false);
            }
        }

        // Front grip - top
        translate([0, grip_cutout_radius + grip_cutout_offset_y, grip_cutout_offset_z]) {
            rotate([-grip_cutout_angle, 0, 0]) {
                cylinder(h = grip_cutout_height, r = grip_cutout_radius, center = false);
            }
        }
    }
    
    translate([0, 0, cavity_base - fudge]) {
        // Shaft key
        intersection() {
            translate([key_offset_x, -connector_radius_outer, 0]) {
                cube([connector_radius_outer * 2, connector_radius_outer * 2, connector_height]);
            }
            cylinder(h = connector_height, r = connector_radius_outer, center = false);
        }

        // Coupling connector
        difference() {
            cylinder(h = connector_height,         r = connector_radius_outer, center = false);
            cylinder(h = connector_height + fudge, r = connector_radius_inner, center = false);
        }
    }

    // Endstop
    translate([connector_radius_inner, -(endstop_depth / 2), cavity_base - fudge]) {
        cube([cavity_radius - connector_radius_inner, endstop_depth, cavity_height], center = false);
    }

    // Indicator dot
    translate([indicator_offset_x, 0, -indicator_height + fudge]) {
        cylinder(h = indicator_height, r = indicator_radius, center = false);
    }
}