# Idle Paws: Cat Traits System (Initial Implementation)

## Overview
This document outlines the simplified cat traits system for initial development of Idle Paws. This system provides the foundation for cat differentiation, progression, and customization while being straightforward to implement.

## Core Attributes (Fixed by Breed)

Each cat breed has predetermined core attribute values that cannot be changed. These represent the cat's innate abilities:

1. **Strength**
   - Affects carrying capacity
   - Improves resource yield from physical gathering
   - Increases building construction speed

2. **Agility**
   - Improves gathering speed
   - Increases success rate for difficult collection spots
   - Enhances climbing ability for elevated resources

3. **Intelligence**
   - Enhances crafting efficiency
   - Improves tool creation quality
   - Increases research speed

4. **Charisma**
   - Improves recruitment success rate
   - Enhances trading efficiency
   - Increases loyalty gain rate for other cats

5. **Luck**
   - Increases chance of rare resource finds
   - Improves quality of gathered resources
   - Enhances success rate of risky activities

### Starting Breeds

Each breed has different attribute distributions (values 1-10):

| Breed | Strength | Agility | Intelligence | Charisma | Luck |
|-------|----------|---------|--------------|----------|------|
| Tabby | 6 | 8 | 5 | 6 | 5 |
| Siamese | 4 | 6 | 9 | 7 | 4 |
| Calico | 7 | 5 | 6 | 5 | 7 |

## Equipment Slots

Each cat has four equipment slots that provide attribute bonuses and special abilities:

1. **Hat**
   - Primary effects: Intelligence, Luck
   - Example: Scholar's Cap (+2 Intelligence)

2. **Collar**
   - Primary effects: Charisma, Luck
   - Example: Bell Collar (+2 Charisma)

3. **Charm**
   - Primary effects: Special abilities, Unique effects
   - Example: Lucky Clover (+1 Luck, +5% rare find chance)

4. **Paw Gear**
   - Primary effects: Strength, Agility
   - Example: Padded Paws (+2 Agility)

### Basic Equipment

Initial implementation includes 2-3 items per slot with simple numerical bonuses.

## Specialization Levels

Cats can gain experience and level up in four specialization areas:

1. **Worker**
   - Improves resource gathering efficiency
   - Levels up by: Gathering resources
   - Each level: +5% gathering efficiency

2. **Explorer**
   - Improves exploration range and discovery rate
   - Levels up by: Exploring new areas
   - Each level: +5% exploration range

3. **Crafter**
   - Improves building and crafting
   - Levels up by: Crafting items and constructing buildings
   - Each level: +5% crafting speed

4. **Scout**
   - Improves discovery of special areas
   - Levels up by: Scouting expeditions
   - Each level: +5% discovery chance

### Experience System
- Simple XP-based progression
- Higher levels require more XP
- Maximum level: 10 (initially)

## Suspicion & Loyalty System

Unlocked after the tutorial betrayal:

### Suspicion (Player Attribute)
- Initial value: 0
- Maximum value: 10
- Increases by: Successfully identifying disloyal cats
- Each point: +5% chance to detect disloyalty

### Loyalty (Cat Attribute)
- Hidden value for each cat
- Range: 0-100
- Initial value: Random (40-80)
- Increases by: Successful assignments, gifts, time in colony
- Decreases by: Bad conditions, competing offers
- Effects: Chance of betrayal or leaving

## Implementation Notes

### Phase 1 (MVP)
- Implement core attributes for the three starter breeds
- Add basic equipment system with 1-2 items per slot
- Implement simplified specialization XP gain
- Add loyalty as a hidden value that affects text/events

### Phase 2
- Implement suspicion system after tutorial
- Add more equipment variety
- Implement specialization bonuses that affect gameplay
- Add loyalty indicators (subtle visual cues)

### Phase 3
- Add cat mood system based on conditions
- Implement more complex loyalty events
- Add special equipment with unique effects
- Implement trait synergies between cats

## UI Considerations
- Core attributes shown as simple stat bars
- Equipment shown in designated slots with tooltips
- Specialization levels shown as progress bars
- Loyalty hints shown through cat expressions/dialogue
- Suspicion shown as a player stat after tutorial
