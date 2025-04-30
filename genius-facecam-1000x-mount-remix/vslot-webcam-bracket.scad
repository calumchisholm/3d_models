/* 
Updated Webcam Mount for T-Slot/V-Slot Frames
This redesigned model replaces the original webcam_mount.stl found in the Genius FaceCam 1000X mount for 40x40 aluminum extrusion:
https://www.printables.com/model/772273-genius-facecam-1000x-mount-for-40x40-profile/files

The new design supports T-slot and V-slot frames, making it compatible with a wider range of 3D printers - especially those where the ends of the extrusions are not accessible, such as the Elegoo Neptune series.
*/


// Smoothness
$fn = 40;

// Arbitrary small value. Used when forcing perfectly abutting planes to overlap
fudge = 0.01;

// Bracket width
bracket_width = 26;
// Bracket depth
bracket_depth = 35;
// Bracket height
bracket_height = 6;

// Distance between the two bracket screwholes
screwhole_separation = 20;

// Radius of the bracket screwholes (M4 = 2mm). Allow some padding.
bracket_screw_radius = 2.2;
// Height of the countersunk screwhead (M4 = 4mm)
bracket_screwhead_height = 4;
// Radius of the screwhead (M4 = 3.5mm). Allow some padding.
bracket_screwhead_radius = 3.7;

// Post width
post_width = 14;
// Post depth
post_depth = screwhole_separation - (2 * (bracket_screwhead_radius));
// Post height
post_height = 35;


// Radius of the connector screwhole (M5 = 2.5mm)
connector_hole_radius = 2.5;

// Depth of the slot 
connector_slot_depth = 8;
// Slot height
connector_slot_height = post_width;
// Slot height clearance
connector_slot_clearance = 2;


module screwhole_countersunk(screwhead_radius, screwhead_height, screw_radius, screw_height) {
    // Countersink for screw head
    translate([0, 0, -screwhead_height]) {
        cylinder(h = screwhead_height + fudge, r = screwhead_radius, center = false);
    }

    // Screwhole
    translate([0, 0, -(screw_height + fudge)]) {
        cylinder(h = screw_height + fudge, r = screw_radius, center = false);
    }
}


difference() {
    // Plate
    cube([bracket_width, bracket_depth, bracket_height], false);

    // Screwholes
    translate([bracket_width / 2, 0, bracket_height]) {
        // Upper
        translate([0, (bracket_depth + screwhole_separation) / 2, 0]) {
            screwhole_countersunk(bracket_screwhead_radius,
                                  bracket_screwhead_height,
                                  bracket_screw_radius,
                                  bracket_height);
        }

        // Lower
        translate([0, (bracket_depth - screwhole_separation) / 2, 0]) {
            screwhole_countersunk(bracket_screwhead_radius,
                                  bracket_screwhead_height,
                                  bracket_screw_radius,
                                  bracket_height);
        }        
    }
}

difference() {
    union() {
        translate([(bracket_width - post_width) / 2, (bracket_depth - post_depth) / 2, bracket_height - fudge]) {
            // Post
            cube([post_width, min(post_depth, (screwhole_separation - (2 * bracket_screwhead_radius))), post_height], false);

            // Elbow joint
            translate([post_width / 2, post_depth, post_height]) {
                rotate([90, 0, 0]) {
                    cylinder(h = post_depth, r = post_width / 2, center = false);
                }
            }
        }
    }

    // Connector screwhole
    translate([bracket_width / 2, (bracket_depth - post_depth) / 2 - fudge, bracket_height + post_height]) {
        rotate([-90, 0, 0]) {
            cylinder(h = post_depth + (2 * fudge), r = connector_hole_radius, center = false);
        }
    }
    
    // Connector slot
    translate([(bracket_width - post_width) / 2 - fudge,
               (bracket_depth - connector_slot_depth) / 2,
               bracket_height + post_height + post_width / 2 - (connector_slot_height + connector_slot_clearance)]) {
        cube([post_width + (2 * fudge), connector_slot_depth, connector_slot_height + connector_slot_clearance + fudge]);
    }
}