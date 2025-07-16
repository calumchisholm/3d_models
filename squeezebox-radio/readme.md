# Squeezebox Radio replacement parts

The [Logitech Squeezebox Radio](https://lyrion.org/players-and-controllers/squeezebox-radio/) was first released in 2009, and while it continues to enjoy active community support, the hardware is often beginning to show its age. In particular, some of the case plastics can become brittle, discoloured or gummy.

These models attempt to reproduce some of the original parts in a form suitable for 3d printing.


## Models

- `navigation-knob.scad` - A replacement for the main navigation jog/click wheel.
- `volume-knob.scad` - A replacement for the smaller volume/mute knob.
- `power-eth-plate.scad` - A replacement for the rear power/ethernet/headphone plate.

These models should work in both the *release* and *development-snapshot* versions of OpenSCAD. A recent snapshot is recommended however, as no formal release has been tagged since January 2021.


### Knob Parameters

Setting the following parameters allows for the addition of ridges of configurable size and depth. Alternatively, a `ridge_count` of `0` produces a smooth model similar to the originals.

- `ridge_count` - the number of ridges around the edge of the knob.
- `ridge_radius` - the radius of each individual ridge cutout.
- `overlap_factor` - how far the cutout should extend (effectively the ridge depth).

- `key_offset_x` - adjustment to ensure a positive engagement between the model's 'key' and the shaft of the rotary encoder.


## 3D Printing

- Set the parameters as described above.
- *Preview* the model then *render* and *export as `.stl`*.
- Use standard slicer settings. 100% infill is recommended. A brim should be avoided. No supports should be necessary.
- Knobs should be printed face-down

