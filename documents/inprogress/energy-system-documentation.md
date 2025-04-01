# Idle Paws: Energy System Documentation

## Table of Contents
1. [Overview](#overview)
2. [Energy System Components](#energy-system-components)
3. [Player Energy](#player-energy)
4. [Cat Energy](#cat-energy)
5. [Energy Regeneration](#energy-regeneration)
6. [Energy Usage](#energy-usage)
7. [UI Components](#ui-components)
8. [Modifying the Energy System](#modifying-the-energy-system)
9. [Future Enhancements](#future-enhancements)
10. [Reference Tables](#reference-tables)

---

## Overview

The energy system in Idle Paws is a core mechanic that limits player actions and adds strategic resource management to gameplay. Energy is consumed when performing actions like gathering resources, exploring new areas, and assigning cats to tasks. Both the player and individual cats have separate energy systems that operate in parallel.

### Design Goals
- Create meaningful choices about resource gathering and exploration
- Encourage strategic planning through energy management
- Support idle gameplay with automatic energy regeneration
- Balance active play with idle progression

---

## Energy System Components

The energy system is implemented across several classes:

| Component | Primary Class | File | Role |
|-----------|---------------|------|------|
| Player Energy | `ResourceManager` | `ResourceManager.gd` | Manages the player's energy pool |
| Cat Energy | `CatManager.Cat` | `CatManager.gd` | Manages individual cat energy pools |
| Energy Regeneration | Both classes | Both files | Handles automatic energy recovery over time |
| Energy UI | `home_scene.gd` | `home_scene.gd` | Displays energy levels and regeneration rates |
| Game State Integration | `game_state.gd` | `game_state.gd` | Coordinates energy updates with game tick |

---

## Player Energy

### Core Implementation

Player energy is managed in the `ResourceManager` class, which is instantiated and managed by the `GameState` singleton.

```gdscript
# In ResourceManager.gd
var player_energy = 100
var max_player_energy = 100
var player_energy_regen_rate = 1  # Per minute
```

### Available Methods

| Method | Parameters | Return | Description |
|--------|------------|--------|-------------|
| `use_player_energy(amount)` | `amount`: float | boolean | Attempts to consume player energy; returns true if successful |
| `regenerate_player_energy(delta)` | `delta`: float | void | Regenerates player energy based on time passed and regen rate |

### Signals

| Signal | Parameters | Description |
|--------|------------|-------------|
| `player_energy_changed` | `current, maximum` | Emitted whenever player energy values change |

### Example Usage

```gdscript
# To consume energy for an action
if GameState.resources.use_player_energy(10):
    # Action succeeds
    perform_gathering_action()
else:
    # Not enough energy
    show_insufficient_energy_message()
    
# To listen for energy changes
func _ready():
    GameState.resources.connect("player_energy_changed", _on_player_energy_changed)
    
func _on_player_energy_changed(current, maximum):
    update_energy_display()
```

---

## Cat Energy

### Core Implementation

Each cat has its own energy system, implemented in the `Cat` class within `CatManager`.

```gdscript
# In CatManager.gd - Cat class
var energy: float = 50.0
var max_energy: float = 50.0
var energy_regen_rate: float = 0.5  # Per minute
```

### Available Methods

| Method | Parameters | Return | Description |
|--------|------------|--------|-------------|
| `use_energy(amount)` | `amount`: float | boolean | Attempts to consume cat energy; returns true if successful |
| `regenerate_energy(delta)` | `delta`: float | void | Regenerates cat energy based on time passed and regen rate |
| `get_energy_percent()` | None | float | Returns the cat's energy as a percentage of maximum |

### Example Usage

```gdscript
# Get a reference to a cat
var cat = GameState.cats.get_player_cat()

# Use cat energy for an action
if cat.use_energy(15):
    # Cat can perform action
    assign_cat_to_task()
else:
    # Cat is too tired
    show_cat_tired_message()
```

---

## Energy Regeneration

Energy regeneration happens automatically via the game tick system. Both player energy and cat energy regenerate over time at their specified rates.

### Regeneration Formula

```
energy_gained = (regen_rate / 60.0) * delta_time
```

Where:
- `regen_rate` is in units per minute
- `delta_time` is the time passed in seconds
- Energy gained is capped by the maximum energy value

### Implementation

```gdscript
# In ResourceManager.gd
func regenerate_player_energy(delta):
    var regen_amount = (player_energy_regen_rate / 60.0) * delta
    player_energy = min(player_energy + regen_amount, max_player_energy)
    emit_signal("player_energy_changed", player_energy, max_player_energy)

# In CatManager.gd - Cat class
func regenerate_energy(delta: float) -> void:
    var regen_amount = (energy_regen_rate / 60.0) * delta
    energy = min(energy + regen_amount, max_energy)
```

### Update Cycle

The regeneration is triggered in the game state update cycle:

```gdscript
# In game_state.gd
func _update_game_systems() -> void:
    resources.update(0.1)  # Triggers player energy regen
    cats.update(0.1)       # Triggers cat energy regen for all cats
```

---

## Energy Usage

Energy is consumed when performing various actions in the game.

### Common Energy Costs

Based on the game design documentation, here are standard energy costs:

| Action | Energy Cost | Class Where Implemented |
|--------|-------------|-------------------------|
| Gathering Catnip | 5 | To be implemented in resource gathering |
| Gathering Twigs | 8 | To be implemented in resource gathering |
| Gathering Leaves | 6 | To be implemented in resource gathering |
| Gathering Moss | 7 | To be implemented in resource gathering |
| Gathering Stones | 10 | To be implemented in resource gathering |
| Gathering Spider Silk | 12 | To be implemented in resource gathering |
| Fishing | 15 | To be implemented in resource gathering |
| Gathering Clay | 14 | To be implemented in resource gathering |
| Carrying Water | 16 | To be implemented in resource gathering |
| Finding Metal Scraps | 18 | To be implemented in resource gathering |
| Collecting Seed Pods | 12 | To be implemented in resource gathering |
| Finding Herbs | 14 | To be implemented in resource gathering |

### Implementation Pattern

When implementing new actions that consume energy, follow this pattern:

```gdscript
func perform_action():
    var energy_cost = 10  # Define cost
    
    # Check if player has enough energy
    if GameState.resources.use_player_energy(energy_cost):
        # Perform the action
        var success = action_logic()
        
        # If action failed, potentially refund some energy
        if not success:
            GameState.resources.add_energy(energy_cost * 0.5)  # Refund half
    else:
        # Show insufficient energy message
        UI.show_message("Not enough energy!")
```

---

## UI Components

The energy system is represented in the UI primarily through the home scene.

### Energy Bar

Located in `home_scene.tscn`, the main energy display consists of:
- A progress bar showing current/maximum energy
- A label showing the regeneration rate

```gdscript
# In home_scene.gd
func update_energy_display():
    if energy_bar:
        energy_bar.value = GameState.resources.player_energy
        energy_bar.max_value = GameState.resources.max_player_energy
    
    if energy_label:
        energy_label.text = "Recharging: +" + str(GameState.resources.player_energy_regen_rate) + "/min"
```

### Implementation Notes

- The energy bar updates whenever the `player_energy_changed` signal is emitted
- Individual cat energy displays are planned but not yet implemented

---

## Modifying the Energy System

### Changing Maximum Energy

```gdscript
# To increase player maximum energy
func upgrade_player_energy_capacity(amount):
    GameState.resources.max_player_energy += amount
    # Optionally also increase current energy
    GameState.resources.player_energy += amount
    # Signal emission happens automatically in regenerate method
    GameState.resources.regenerate_player_energy(0)

# To increase a cat's maximum energy
func upgrade_cat_energy_capacity(cat_id, amount):
    var cat = GameState.cats.cats[cat_id]
    cat.max_energy += amount
    # Optionally also increase current energy
    cat.energy += amount
```

### Changing Regeneration Rate

```gdscript
# To increase player energy regeneration
func upgrade_player_energy_regen(amount):
    GameState.resources.player_energy_regen_rate += amount

# To increase a cat's energy regeneration
func upgrade_cat_energy_regen(cat_id, amount):
    var cat = GameState.cats.cats[cat_id]
    cat.energy_regen_rate += amount
```

### Full Energy Restoration

```gdscript
# To fully restore player energy
func restore_player_energy():
    GameState.resources.player_energy = GameState.resources.max_player_energy
    GameState.resources.emit_signal("player_energy_changed", 
                                   GameState.resources.player_energy, 
                                   GameState.resources.max_player_energy)

# To fully restore a cat's energy
func restore_cat_energy(cat_id):
    var cat = GameState.cats.cats[cat_id]
    cat.energy = cat.max_energy
    # If you add a signal for cat energy changes, emit it here
```

---

## Future Enhancements

Based on the game design document, the following energy system enhancements are planned:

### Energy Items

These items will provide energy bonuses when used or equipped:
- **Catnip Treats**: Instant energy restore
- **Comfy Bed**: Increased energy regeneration when resting
- **Energy Drink**: Temporary boost to maximum energy
- **Energy Crystal**: Permanent small increase to maximum energy

### Energy Modifiers

Game elements that will affect energy systems:
- **Weather Effects**: Reduce or increase energy costs for certain activities
- **Time of Day**: Night activities may cost more energy
- **Cat Fatigue System**: Continuous work increases energy costs
- **Building Bonuses**: Special buildings that increase energy regeneration

### Planned Code Structure

```gdscript
# Example of future enhancement
class EnergyItem:
    var name: String
    var immediate_energy: float  # Instant energy restore
    var regen_bonus: float       # Regeneration rate bonus
    var max_bonus: float         # Maximum energy bonus
    var duration: float          # How long the effect lasts (seconds)
    
    func apply_to_player():
        # Implementation
    
    func apply_to_cat(cat_id):
        # Implementation
```

---

## Reference Tables

### Player Energy Default Values

| Property | Value | Description |
|----------|-------|-------------|
| Initial Energy | 100 | Starting player energy |
| Maximum Energy | 100 | Cap on player energy |
| Regeneration Rate | 1.0 | Energy points per minute |

### Cat Energy Default Values

| Property | Base Value | Notes |
|----------|------------|-------|
| Initial Energy | 50 | Starting energy for new cats |
| Maximum Energy | 50 | Base cap on cat energy |
| Regeneration Rate | 0.5 | Energy points per minute |

### Breed-Specific Energy Modifiers

These values are not yet implemented but planned according to the design document:

| Cat Breed | Max Energy Modifier | Regen Rate Modifier | Special Ability |
|-----------|---------------------|---------------------|----------------|
| Tabby | +0 | +0.1 | Explorer specialization |
| Siamese | -5 | +0.2 | Crafter specialization |
| Calico | +10 | +0 | Gatherer specialization |

### Specialization Energy Effects

| Specialization | Effect on Energy System |
|----------------|-------------------------|
| Worker | Reduced energy cost for resource gathering |
| Explorer | Increased max energy |
| Crafter | Faster energy regeneration when idle |
| Scout | Reduced energy cost for exploration |
| Builder | Reduced energy cost for construction |

---

## Additional Notes

- The energy system is tightly integrated with the game's time system, which operates at approximately 24 minutes per game day
- Energy values for both player and cats persist through saves
- Currently, there's no way to transfer energy between cats or from player to cats
- Energy UI updates need to be manually connected in each scene where energy is displayed

---

*This documentation is a living document that should be updated as the energy system evolves and new features are implemented.*
