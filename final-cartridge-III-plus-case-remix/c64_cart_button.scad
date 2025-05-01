/*
Button plunger for or use with the `Final Cartridge III+ Case` project
https://www.thingiverse.com/thing:3680493

Suitable for when short tact switches have been used.
*/

// Smoothness
$fn = 40;

// Arbitrary small value. Used when forcing perfectly abutting planes to overlap
fudge = 0.01;

button_pad_height = 0.2;
button_pad_radius = 1.4;

button_base_height = 1.6;
button_base_radius_bottom = button_pad_radius;
button_base_radius_top = 3;

button_plunger_height = 4.7;
button_plunger_radius = 1.9;

cylinder(h = button_pad_height,    r = button_pad_radius);

translate([0, 0, button_pad_height - fudge]) {
    cylinder(h = button_base_height, r1 = button_base_radius_bottom, r2 = button_base_radius_top);
    translate([0, 0, button_base_height - fudge]) {
        cylinder(h = button_plunger_height, r = button_plunger_radius);
    }
}
