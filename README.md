OBS Scene Item Auto-Sorter (Lua)
A lightweight automation script for OBS Studio that keeps your sources organized. It automatically maintains a natural sort order (0-9, A-Z) for items within specific scenes, ensuring your production environment stays clean and predictable.

🚀 Features
Natural Alphanumeric Sorting: Handles numbers logically (e.g., "Item 2" correctly appears before "Item 10").

API Stability Fix: Uses individual item re-positioning (obs_sceneitem_set_order_position) to avoid the "Table expected, got table" error found in some OBS API versions.

Real-time Organization: Runs every second to snap newly added or renamed sources into their correct alphabetical place.

Targeted Sorting: Only affects specific scenes, leaving your other scenes untouched for manual layout.

🛠️ Installation
Download the sort_graphics.lua file (or copy the code into a new .lua file).

Open OBS Studio.

Go to Tools > Scripts.

Click the + button and select your .lua file.

Ensure your target scenes are named Graphics - 1, Graphics - 2, or Graphics - 3 (or see below to change them).

⚙️ Customization
Changing Target Scenes

By default, the script looks for scenes named Graphics - 1, Graphics - 2, and Graphics - 3. To change this, open the script in a text editor and modify the top line:

Lua
local target_scenes = {"Overlays", "Lower Thirds", "My Custom Scene"}
Adjusting Sort Frequency

The script checks the order every 1000ms (1 second). To make it check less often (to save CPU on very old machines), change the value in script_load:

Lua
function script_load(settings)
    -- Change 1000 to 5000 for every 5 seconds
    obs.timer_add(sort_graphics_scenes, 1000)
end
⚠️ Important Note
Because this script enforces a sort order every second, you will not be able to manually drag sources into a different order within the target scenes. The script will simply move them back to their alphabetical position within one second.

📄 License
MIT License. Free to use for personal or commercial broadcasts.
