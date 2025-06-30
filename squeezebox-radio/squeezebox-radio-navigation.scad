// === Parameters ===
/* [General] */
// Render detail level
$fn = 80;

/* [Hidden] */
fudge = 0.01; // Fudge factor used to ensure planes overlap

/* [Knob body] */
body_height = 16.0;
body_radius_min = 17.5;
body_radius_maj  = 18.5;
body_wall_thickness = 2.3;
cavity_height = 14.0;
cavity_radius_min = body_radius_min - body_wall_thickness;
cavity_radius_maj = body_radius_maj - body_wall_thickness;

/* [Ridges] */
ridge_count = 40;
ridge_radius = 0.7;
overlap_factor = 1.0;

/* [Connector] */
connector_height = 6.2;
connector_radius_inner = 3.2;
connector_thickness = 2.5;
connector_radius_outer = connector_radius_inner + connector_thickness;
key_offset_x = 1.35;

// === Cross-braces (cuboids) crossing inner cavity wall but not outer cone wall ===
brace_count = 5;
brace_width = 2.5;
brace_height = connector_height;

// Start just outside connector inner radius
brace_start = connector_radius_inner + 0.5;

// Extend up to just inside outer cone wall
brace_end = (cavity_radius_min + cavity_radius_maj) / 2;  // Average cavity radius
brace_length = brace_end - brace_start;

module cross_brace(angle) {
    rotate([0, 0, angle]) {
        translate([brace_start, -brace_width / 2, 0]) {
            cube([brace_length, brace_width, brace_height]);
        }
    }
}

color("#99BB99") {
    cavity_base = body_height - cavity_height;

    difference() {
        // Body
        cylinder(h = body_height, r1 = body_radius_min, r2 = body_radius_maj, center = false);

        // Cavity
        translate([0, 0, cavity_base]) {
            cylinder(h = cavity_height + fudge, r1 = cavity_radius_min, r2 = cavity_radius_maj, center = false);
        }

        // Inset ridges
        if (ridge_count > 0) {
            for (i = [0 : ridge_count - 1]) {
                angle = i * 360 / ridge_count;
                rotate([0, 0, angle]) {
                    hull() {
                        translate([body_radius_min + overlap_factor - ridge_radius, 0, 0]) {
                            sphere(r = ridge_radius);
                        }
                        translate([body_radius_maj + overlap_factor - ridge_radius, 0, body_height]) {
                            sphere(r = ridge_radius);
                        }
                    }
                }
            }
        }

    }

    // D-shaft connector
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
            cylinder(h = connector_height, r = connector_radius_outer, center = false);
            cylinder(h = connector_height + fudge, r = connector_radius_inner, center = false);
        }

        for (b = [0 : brace_count]) {
            cross_brace((360 / brace_count) * b);
        }
    }
}