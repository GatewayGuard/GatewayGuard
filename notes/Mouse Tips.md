**Mouse Tips**



● Three separate double-click .bat files — no combined one exists yet. Run them in this order on

&#x20; SANDY:



&#x20; 1. Run-MouseSetup.bat — the general mouse settings for using Checkup comfortably (wheel

&#x20;    scrolling under the pointer instead of needing a click first, a slower double-click, a larger

&#x20;    cursor). This is the fix for the freeze/selection problem from the field runs.

&#x20; 2. Run-SetDragThreshold.bat — sets the drag distance to 200 pixels (its current default), the

&#x20;    value confirmed twice now to stop a folder or file from being grabbed and moved by accident.

&#x20; 3. Run-SetTouchpadDrag.bat — turns off the touchpad's "tap twice and hold" gesture, which is the

&#x20;    touchpad's own way of starting a drag and the reason the setting above doesn't help it.

&#x20;    SANDY has a touchpad, so this one matters there in a way it didn't on CGDELL's external

&#x20;    mouse.



&#x20; All three: per-user only, no administrator needed, never self-elevate, and each writes its own

&#x20; undo file before changing anything — Run-\*-Revert.bat for the last two, and Run-MouseSetup.bat

&#x20; has its own undo record too. Nothing has been applied to SANDY yet (checked — its undo file is

&#x20; empty), so this will be a clean first run there.



&#x20; One thing to know going in: SANDY's touchpad key may report differently than CGDELL's, or may

&#x20; not exist at all if it's a different make — Run-SetTouchpadDrag.bat checks for that itself and

&#x20; says plainly "This PC has no Precision Touchpad" rather than guessing.

