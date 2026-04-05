/*
    OpenERV Universal Window Mount
    Parametric Design Script
    Version: 1.1 (Optimized for Pioneer ECOasis 50)
*/

// --- USER PARAMETERS ---
pipe_diameter = 160;      // Pioneer ECOasis 50 uses 160mm
panel_height = 300;       // Increased for 5kg load stability
panel_thickness = 20;     // Increased for Pioneer's 11lb weight
clearance = 0.5;          // Fit tolerance
pioneer_mode = true;      // Adds reinforced mounting zone for Pioneer plate

// --- INTERNAL CALCULATIONS ---
collar_outer = pipe_diameter + 30;
core_width = pioneer_mode ? 260 : 220; // Extra width for Pioneer footprint
slider_width = 300;

// --- MODULES ---

module core_plate() {
    difference() {
        // Main Body
        cube([core_width, panel_height, panel_thickness], center=true);
        
        // Pipe Hole (172mm for 160mm pipe + 12mm clearance/seal)
        cylinder(h=panel_thickness+2, d=pipe_diameter + 12, center=true, $fn=100);
        
        // Pioneer Safe-Drill Zones (Thin slots to mark 100% infill areas)
        if(pioneer_mode) {
            for(x=[-100, 100]) for(y=[-120, 120]) {
                translate([x, y, 0]) cube([20, 20, panel_thickness+2], center=true);
            }
        }
        
        // Slider Tracks (Grooves)
        translate([core_width/2, 0, 0]) cube([12, panel_height+2, panel_thickness-8], center=true);
        translate([-core_width/2, 0, 0]) cube([12, panel_height+2, panel_thickness-8], center=true);
    }
}

module extension_slider() {
    difference() {
        cube([slider_width, panel_height, panel_thickness-2], center=true);
        
        // Adjustment Slots (M5)
        for(x=[-slider_width/3, 0, slider_width/3]) {
            translate([x, 0, 0])
                hull() {
                    translate([0, -20, 0]) cylinder(h=panel_thickness+10, d=5.5, center=true, $fn=20);
                    translate([0, 20, 0]) cylinder(h=panel_thickness+10, d=5.5, center=true, $fn=20);
                }
        }
    }
    // Tongue for the groove
    translate([-slider_width/2 - 4, 0, 0])
        cube([8, panel_height-2, panel_thickness-10], center=true);
}

module sill_support_pioneer() {
    // Heavy duty triangular brace
    difference() {
        union() {
            cube([40, 40, 200]); // Main vertical column
            translate([0,0,0]) rotate([0,45,0]) cube([40, 40, 250]); // Angle brace
        }
        // Bolt holes for M6 hardware
        translate([20, 20, 20]) rotate([0,90,0]) cylinder(h=50, d=6.5, center=true);
    }
}

// --- GENERATION ---
core_plate();
