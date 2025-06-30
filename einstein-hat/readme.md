# Einstein Hat Monotile

This project defines a parametric [OpenSCAD](https://openscad.org/) model of the [Einstein hat](https://en.wikipedia.org/wiki/Einstein_problem#The_hat_and_the_spectre) - a 13-sided aperiodic monotile discovered by David Smith in November 2022. This tile is notable for being the first known unmarked shape that tiles the plane aperiodically without requiring reflections, colors, or matching rules.

## Usage

This model should work in both the *release* and *development-snapshot* versions of OpenSCAD. A recent snapshot is recommended however, as no formal release has been tagged since January 2021.

- The `longest_edge` parameter sets the length of the tile's longest edge, controlling its overall size.
- The `height` parameter sets the tile's height. Set to `0` if exporting as 2D (SVG, PDF etc.).

The default values produce a nicely-sized tile for 3d-printing, around 4.5cm across at its widest point.

## 3D Printing

- Set appropriate values for the `height` and `longest_edge` parameters on the *Customizer* tab. `height` must be non-zero.
- *Preview* the model then *render* and *export as `.stl`*.
- Use standard slicer settings. 100% infill is recommended unless you've chosen a particularly large `height` value.
- A brim is not recommended in order to ensure clean edges to your print.

