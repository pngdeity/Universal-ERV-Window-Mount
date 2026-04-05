# Optimization for VENTS-US TwinFresh Comfo (RA1-50-2)

The TwinFresh Comfo is a heavy-duty professional unit with a substantial ceramic energy core and stainless steel exterior.

## 1. High-Mass Structural Support
- **Problem**: The unit weighs **19 lbs (8.6 kg)**. This is too heavy for standard 3D-printed telescoping tracks without specific reinforcement.
- **Optimization**: 
    - **Dual Sill-Supports**: This model REQUIRES two `sill_support` braces (one on each side of the pipe) to prevent the window mount from twisting.
    - **Steel Reinforcement**: It is recommended to bolt a 1" wide aluminum bar across the interior face of the `core_plate` to distribute the mounting plate load.
    - **100% Infill Mounting**: The `core_plate` must be printed with 100% infill in the upper half where the unit hangs.

## 2. Duct Sizing (150mm vs 160mm)
- **Problem**: The unit uses a **150mm (6")** duct, but many standard commercial accessories (and our previous Pioneer optimization) assume **160mm**.
- **Optimization**: 
    - **Adaptation**: Use the `window_mount_parametric.scad` with `pipe_diameter = 150`.
    - **Compression Gasket**: A 5mm thick EPDM gasket is required between the Vents-US telescopic duct and the core plate to ensure an airtight seal.

## 3. Depth Management
- **Problem**: Like the Pioneer, this is designed for walls up to 18".
- **Optimization**: 
    - The Vents-US unit allows the ceramic core to be positioned deeper in the pipe. For window mounting, the core should be pulled as far "Indoor" as possible to keep the center of gravity closer to the window track.

## 4. Vibration Damping
- **Problem**: With 19 lbs of mass and a high-efficiency fan, resonance can be an issue.
- **Optimization**: Use Shore 40A cast silicone pads between the Vents-US backplate and the 3D-printed core plate.
