/*
    OpenERV Universal Window Mount
    Parametric Design Script
    Version: 1.2 (Industrial Parity Update)
*/

// --- USER PARAMETERS ---
pipe_diameter = 160;      // Standard diameters: 150 or 160
panel_height = 300;       
panel_thickness = 25;     // Increased for durability and insulation
clearance = 0.5;          
pioneer_mode = true;      
heat_set_inserts = true;   // Use M3 heat-set inserts instead of self-tapping

// --- INTERNAL CALCULATIONS ---
collar_outer = pipe_diameter + 40;
core_width = pioneer_mode ? 260 : 220; 
slider_width = 300;
screw_dia = heat_set_inserts ? 4.2 : 3.0; // 4.2mm for M3 inserts, 3.0mm for self-tapping

// --- MODULES ---

module core_plate() {
    difference() {
        cube([core_width, panel_height, panel_thickness], center=true);

        // Pipe Hole
        cylinder(h=panel_thickness+2, d=pipe_diameter + 12, center=true, $fn=100);

        // M3 Heat-Set Insert Holes for Mounting Plate
        if(pioneer_mode) {
            for(x=[-100, 100]) for(y=[-120, 120]) {
                translate([x, y, 0]) cylinder(h=panel_thickness+2, d=screw_dia, center=true, $fn=20);
            }
        }

        // Slider Tracks
        translate([core_width/2, 0, 0]) cube([12, panel_height+2, panel_thickness-8], center=true);
        translate([-core_width/2, 0, 0]) cube([12, panel_height+2, panel_thickness-8], center=true);
    }
}

module tpu_core_gasket() {
    // A flexible seal that sits between the ceramic core and the 3D-printed plate
    difference() {
        cylinder(h=15, d=pipe_diameter + 12, center=true, $fn=100);
        cylinder(h=20, d=pipe_diameter - 2, center=true, $fn=100); // Inner lip

        // Relief grooves for flexibility
        for(a=[0:30:359]) rotate([0,0,a]) 
            translate([pipe_diameter/2 + 3, 0, 0]) cube([5, 10, 20], center=true);
    }
}

module extension_slider() {
...

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

module filter_cassette_merv13() {
    /* 
       Industrial Filter Housing for MERV 13 (F7) Circular Media.
       Designed for 150mm/160mm industrial cores.
       Features a friction-fit outer ring and a pleated media retention grid.
    */
    h_total = 30;
    inner_d = pipe_diameter - 15;
    
    difference() {
        // Main Body
        union() {
            cylinder(h=h_total, d=pipe_diameter - 2, center=true, $fn=100);
            // External friction ribs
            for(a=[0:45:359]) rotate([0,0,a])
                translate([pipe_diameter/2 - 2, 0, 0]) cylinder(h=h_total, d=3, center=true, $fn=12);
        }
        
        // Internal Cavity for filter media
        cylinder(h=h_total - 6, d=pipe_diameter - 8, center=true, $fn=100);
        
        // Airflow path
        cylinder(h=h_total + 2, d=inner_d, center=true, $fn=100);
    }
    
    // Media Retention Grid (Honeycomb style for low pressure drop)
    intersection() {
        cylinder(h=2, d=pipe_diameter - 6, center=true, $fn=100);
        union() {
            for(x=[-100:15:100]) {
                for(y=[-100:15:100]) {
                    translate([x + (abs(y/15)%2 * 7.5), y, 0]) 
                        rotate([0,0,30]) cylinder(h=2, d=16, $fn=6, center=true);
                }
            }
        }
    }
    
    // Maintenance Handle
    translate([0, 0, h_total/2 + 2])
        difference() {
            cube([60, 12, 10], center=true);
            cube([50, 20, 6], center=true);
        }
}

// --- GENERATION ---
// Uncomment the part you wish to render
core_plate();
// tpu_core_gasket();
// extension_slider();
// sill_support_pioneer();
// filter_cassette_merv13();
