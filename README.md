[![Static Badge](https://img.shields.io/badge/Godot%20Engine-4.7.stable-blue?style=plastic&logo=godotengine)](https://godotengine.org/)
[![License](https://img.shields.io/github/license/dragonforge-dev/dragonforge-interact?logo=mit)](https://github.com/dragonforge-dev/dragonforge-interact/blob/main/LICENSE)
[![GitHub release badge](https://badgen.net/github/release/dragonforge-dev/dragonforge-interact/latest)](https://github.com/dragonforge-dev/dragonforge-interact/releases/latest)
[![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/dragonforge-dev/dragonforge-interact)](https://img.shields.io/github/languages/code-size/dragonforge-dev/dragonforge-interact)

# Dragonforge Interact <img src="/addons/dragonforge_interact/assets/textures/icons/interact.svg" width="32" alt="Interact Icon"/>
A Godot plugin that adds Interact and Highlight component nodes that can be used to make RigidBody3D, StaticBody3D and MeshInstance3D nodes interactive with the mouse. Also includes InteractionRayCast3D and InteractionShapeCast3D as well as a Corsshair control that can be used to interact in a 1st or 3rd person game that captures the mouse.

# Version 1.2
For use with **Godot 4.7.stable** and later.

## Optional Dependencies
The following dependencies are included in the addons folder, but are optional. (See below.)
- [Dragonforge Input Map Action v1.0.1](https://github.com/dragonforge-dev/dragonforge-input-map-action)

# Installation Instructions
1. Copy the `dragonforge_interact` folder from the `addons` folder into your project's `addons` folder.
2. Copy the `dragonforge_highlight` folder from the `addons` folder into your project's `addons` folder.
3. Copy the `dragonforge_interaction_ray_cast` folder from the `addons` folder into your project's `addons` folder.

## Creating an "interact" Action
If you already have an action in the **Input Map** called "interact", skip this part. This just sets up the action for you if you don't have it.
1. If it does not exist already in your project, copy the `dragonforge_input_map_actions` folder from the `addons` folder into your project's `addons` folder.
2. In your project go to **Project -> Project Settings...**
3. Select the **Plugins** tab.
4. Check the **On checkbox** under **Enabled** for **Dragonforge Interact**
5. Press the **Close** button.
6. Save your project.
7. In your project go to **Project -> Reload Current Project**.
8. Wait for the project to reload.

# Usage Instructions
Add an **Interact** node to an object if you want the player to be able to interact with it. Add a **Highlight** node if you want the player to see the node highlighted when they mouse over it.

You can use an **InteractionRayCast** or **InteractionShapeCast** ndoe (or both) to project in front of the player for interaction. (See the included example.) You should attach them directly to the **Camera3D** so they are always centered on the player's screen. The **Crosshair** component is intended to work with them to  tell the player when they have focused on an object. It will automatically center intself in the HUD.


# Class Descriptions
## Interact <img src="/addons/dragonforge_interactd/assets/textures/icons/interact.svg" width="32" alt="Interact Icon"/>
Add this to a [StaticBody3D], [RigidBody3D] or [MeshInstance3D] node and when  the player mouses over any of the [StaticBody3D] or [RigidBody3D] nodes, the [member hover_mouse_cursor] will be shown. When clicked, the [member click_mouse_cursor] will be shown and the [signal interact] will be emitted.

### Signals
- `signal left_click` Emitted when the player clicks on any of the [StaticBody3D] or [RigidBody3D] nodes in the Node this is attached to (including the parent node itself).

### Export Variables
- `hover_mouse_cursor: Texture2D` An image to change the mouse cursor to when the mouse cursor is hovering over the object.
- `hover_mouse_cursor_hotspot: Vector2` The offset for the [member hover_mouse_cursor] hotspot.
- `click_mouse_cursor: Texture2D` An image to change the mouse cursor to when the mouse cursor is hovering over the object, and the user clicks.
- `click_mouse_cursor_hotspot: Vector2` The offset for the [member click_mouse_cursor] hotspot.
- `default_mouse_cursor: Texture2D` The default image to change the mouse cursor to when the object is not being hovered over. Setting this to `null` resets it to the system default.
- `default_mouse_cursor_hotspot: Vector2` The offset for the [member default_mouse_cursor] hotspot.
- `click_time: float = 0.3` The amount of time the mouse curosr displays the [member click_mouse_cursor]  before reverting to the [member default_mouse_cursor].


## Highlight <img src="/addons/dragonforge_highlight/assets/textures/icons/highlight.svg" width="32" alt="Highlight Icon"/>
Add this [Interactable] component to a [StaticBody3D], [RigidBody3D] or [MeshInstance3D] node and when the player mouses over any of the [StaticBody3D] or [RigidBody3D] nodes, the [member highlight_material] will be applied as an overlay material to all attached [MeshInstance3D] nodes. If no [member highlight_material] is defined, the default highlight material will be used.

### Export Variables
- `highlight_material: Material` A custom highlight material to use when this object has focus. Leaving this blank will use the default highlight material.

# Examples
Running the project will run the test project.

# Credit
This plugin was inspired by this video. It describes how to make a carousel menu. Someone came to the Godot forum asking how to do this, and I decided to watch the video for fun. This plugin simplified the code and made it a single **Node**.
- [Gear Icon](https://www.svgrepo.com/svg/509956/gear) by Zest Interface Icons (MIT)
- [Highlight Icon](https://www.svgrepo.com/svg/310904/highlight) by Fluent UI Icons Filled (MIT)
