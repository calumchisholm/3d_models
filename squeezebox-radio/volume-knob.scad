/**********************************************************************
 * 
 **********************************************************************/
/* [General] */
// Render detail level
$fn = 80;

/* [Hidden] */
fudge = 0.01; // Fudge factor used to ensure planes overlap

/* [Knob body] */
// Knob height
body_height = 13.0;     // .1
// Knob radius (major)
body_radius_min = 5.5;
// Knob radius (minor)
body_radius_maj = 6.4;  // Marginally smaller than the original part to avoid fouling on the (slightly misaligned) fascia.
// Wall thickness
body_wall_thickness = 1.2;

// Cavity height
cavity_height = 11.5;
// Cavity radius
cavity_radius_min = body_radius_min - body_wall_thickness;
cavity_radius_maj = body_radius_maj - body_wall_thickness;
cavity_base = (body_height - cavity_height);


/* [Connector] */
// Connector height
connector_height = 6.0; // .1
// Connector outer radius
connector_radius_outer = body_radius_min - body_wall_thickness + fudge;
// Connector inner radius
connector_radius_inner = 3.1;

// Key offset (x) from connector center
key_offset_x = 1.50;


/* [Ridges] */
// Ridge count (0 for smooth)
ridge_count = 20;       // 1
// Ridge cutout radius
ridge_radius = 0.7;
// Overlap between the knob's outer edges and the cutout's center
ridge_overlap = 1.0;    // .1

color("#99BB99") {
    difference() {
        // Main body
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
                        translate([body_radius_min + ridge_overlap - ridge_radius, 0, 0]) {
                            sphere(r = ridge_radius);
                        }
                        translate([body_radius_maj + ridge_overlap - ridge_radius, 0, body_height]) {
                            sphere(r = ridge_radius);
                        }
                    }
                }
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
 }