/*
  The Einstein hat is an aperiodic monotile, discovered by amateur mathematician David Smith in November 2022.
  https://en.wikipedia.org/wiki/Einstein_problem#The_hat_and_the_spectre

  It’s a 13-sided shape that:
    * Never forms a repeating pattern (aperiodic)
    * Uses only a single shape (monotile)
    * Requires no matching rules (no markings or colours)
    * Works without flipping (no reflections needed)
*/

// The length of the longest edge.
longest_edge = 15;   // 0.1
                     // The hat maps to an underlying hex grid. This is the length of the hexagon's edge.
                     // By definition, this is also half the length of the distance between opposite points of the hexagon.
half_ff_width = (longest_edge / 2) * tan(60);  // Half the face-to-face width of the hexagon.

// Height of the hat object. Set to 0 for 2D.
height = 2.0; // 0.5

module draw_hat() {
    polygon(
        points = [[0,                   longest_edge],
                  [0,                   longest_edge * 1.5],
                  [half_ff_width,       longest_edge * 1.5],
                  [half_ff_width * 1.5, longest_edge * 2.25],
                  [half_ff_width * 2,   longest_edge * 2],
                  [half_ff_width * 2.5, longest_edge * 2.25],
                  [half_ff_width * 3,   longest_edge * 1.5],
                  [half_ff_width * 2.5, longest_edge * 0.75],
                  [half_ff_width * 3,   longest_edge * 0.5],
                  [half_ff_width * 3,   0],
                  [half_ff_width * 2,   0],
                  [half_ff_width * 1.5, longest_edge * 0.75],
                  [half_ff_width,       longest_edge * 0.5],
                 ],
        paths = [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 0]]
    );
}

if (height == 0) {
  draw_hat();
} else {
    linear_extrude(height) {
        draw_hat();
    }
}