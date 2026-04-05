# Optimization for Pioneer ECOasis 50 (ERV-50)

The Pioneer ECOasis 50 is a high-performance unit, but its weight and minimum "channel span" create unique challenges for window mounting.

## 1. Structural Reinforcement (Weight Management)
- **Problem**: The unit weighs **11 lbs (5kg)**. In a cantilevered window mount, this creates significant torque on the 3D-printed tracks.
- **Optimization**: 
    - The `core_plate` width has been increased to **260mm** to provide a larger footprint for the Pioneer metal mounting plate.
    - Mandating **ASA material** with **6 walls** for the core plate to prevent fracture at the pipe aperture.
    - The `sill_support` arm must be used and should be anchored to the `core_plate` using M6 hardware (increased from M5).

## 2. Depth Management (The "Short Wall" Problem)
- **Problem**: The ECOasis 50 is designed for walls **8.5" to 14"** thick. A window mount is only ~1" thick. This leaves ~7.5" of 160mm pipe exposed.
- **Optimization**: 
    - **External Bias**: Mount the unit so the excess pipe protrudes *outdoors*. This keeps the indoor unit flush with the window adapter.
    - **Pipe Shroud**: A 3D-printed "Aesthetic Shroud" is recommended to cover the exposed pipe and provide a secondary weather seal.

## 3. Mounting Plate Integration
- **Optimization**: The `core_plate` now features a **"Safe-Drill Zone"**—a 300mm x 300mm flat area reinforced with 100% infill regions. This allows the user to screw the Pioneer's metal mounting plate directly into the 3D print without hitting internal hollow cavities.

## 4. Airflow & Clearances
- **Optimization**: Ensure the `extension_sliders` are long enough to keep the unit at least **150mm** away from the window side-jambs to allow the Pioneer's side-mounted intake vents to breathe.
