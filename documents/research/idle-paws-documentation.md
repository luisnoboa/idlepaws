# Idle Paws - Game Design Documentation

## Table of Contents
1. [Game Overview](#game-overview)
2. [Core Gameplay Systems](#core-gameplay-systems)
3. [Resource System](#resource-system)
4. [Cat Population System](#cat-population-system)
5. [Progression System](#progression-system)
6. [Exploration System](#exploration-system)
7. [Automation System](#automation-system)
8. [Tool & Equipment System](#tool--equipment-system)
9. [UI Screens & Flow](#ui-screens--flow)
10. [Economy Balance](#economy-balance)

---

## Game Overview

**Idle Paws** is a colony-building idle game where players start as a lone homeless cat and build a thriving cat civilization called Catropolis. Players gather resources, recruit other cats, explore new areas, and build structures to grow their colony. The game features a mix of active gameplay (manual resource gathering) and idle mechanics (automated resource generation).

### Core Concept
- Start as a lone homeless cat
- Gather resources to build shelter
- Expand to a thriving colony of specialized cats
- Manage resources, exploration, and construction
- Automate processes for idle progression

### Target Audience
- Casual gamers who enjoy incremental/idle games
- Cat lovers and animal simulation fans
- Players who enjoy resource management and base building

---

## Core Gameplay Systems

### Core Loop
1. Gather resources (manual/automated)
2. Spend resources on buildings and upgrades
3. Recruit more cats with different specializations
4. Explore new areas to find more resources
5. Build automation systems to increase resource generation
6. Upgrade Catropolis to unlock new features

### Main Game Features
- Resource gathering and management
- Cat recruitment and specialization
- Building construction and upgrades
- Location-based exploration
- Tools and equipment crafting
- Skill progression and training
- Automation buildings and systems

---

## Resource System

### Currency
- **Catnip**: Primary currency used for most basic purchases and upgrades

### Tier 1 Resources (Starting Phase)
1. **Catnip**
   - Gathering Method: Manual foraging in grassy areas
   - Energy Cost: 5 per gathering attempt
   - Yield: 1-3 catnip per action
   - Automation: Tiny Catnip Patch (produces 1 catnip every 3 minutes)
   - Upgrades: Better foraging tools increase yield by 25%

2. **Twigs**
   - Gathering Method: Collecting from bushes and small trees
   - Energy Cost: 8 per gathering attempt
   - Yield: 1-2 twigs per action
   - Automation: Twig Collector (requires 75 catnip, produces 1 twig every 5 minutes)
   - Upgrades: Climbing skill increases yield by 20%

3. **Leaves**
   - Gathering Method: Shaking small trees or collecting from ground
   - Energy Cost: 6 per gathering attempt
   - Yield: 2-4 leaves per action
   - Automation: Leaf Net (requires 100 twigs, catches falling leaves passively)
   - Upgrades: Wind charm increases passive collection during breezy weather

4. **Moss**
   - Gathering Method: Scraping from rocks and tree trunks
   - Energy Cost: 7 per gathering attempt
   - Yield: 0-1 moss per action (50% success rate)
   - Automation: Moss Garden (requires damp environment creation)
   - Upgrades: Moisture-sensing whiskers increase success rate to 75%

### Tier 2 Resources (Early Settlement Phase)
1. **Stones**
   - Gathering Method: Collecting from riverbeds or rocky areas
   - Energy Cost: 10 per gathering attempt
   - Yield: 1-2 stones per action
   - Prerequisite: Simple Claw Extensions tool
   - Automation: Stone Tumbler (rolls stones down a created ramp)
   - Upgrades: Stone Senses skill increases chance of finding larger stones

2. **Spider Silk**
   - Gathering Method: Careful collection from abandoned spider webs
   - Energy Cost: 12 per gathering attempt
   - Yield: 0-1 silk per action (40% success rate)
   - Special: Chance to find rare colored silk (5%)
   - Automation: Friendly Spider Den (requires advanced diplomacy)
   - Upgrades: Stealth skill reduces energy cost by 30%

3. **Small Fish**
   - Gathering Method: Paw-fishing in shallow water
   - Energy Cost: 15 per gathering attempt
   - Yield: 0-2 fish per action
   - Prerequisite: Access to water source
   - Automation: Simple Fishing Net (requires silk, checks every 15 minutes)
   - Upgrades: Fishing skill increases catch rate and size

4. **Clay**
   - Gathering Method: Digging near water sources
   - Energy Cost: 14 per gathering attempt
   - Yield: 2-4 clay per action
   - Prerequisite: Access to water source
   - Automation: Clay Pit (requires significant initial construction)
   - Upgrades: Moisture-sensing increases quality of clay found

### Tier 3 Resources (Established Settlement)
1. **Water Source**
   - Gathering Method: Carrying small shells of water from river/pond
   - Energy Cost: 16 per gathering attempt
   - Yield: 3-5 water units per action
   - Automation: Basic Aqueduct (major construction project)
   - Upgrades: Water storage containers increase carrying capacity

2. **Metal Scraps**
   - Gathering Method: Searching abandoned human areas
   - Energy Cost: 18 per gathering attempt
   - Yield: 0-1 metal scraps per action (30% success rate)
   - Special: Chance to find rare intact tools (2%)
   - Automation: Requires first expedition team
   - Upgrades: Metal Detection whiskers increase success rate

3. **Seed Pods**
   - Gathering Method: Collecting from specific plants
   - Energy Cost: 12 per gathering attempt
   - Yield: 1-3 seed pods per action
   - Special: Different plants provide different seed types
   - Automation: Seed Harvester (requires basic technology research)
   - Upgrades: Botany skill identifies more valuable seeds

4. **Herbs**
   - Gathering Method: Careful foraging in special locations
   - Energy Cost: 14 per gathering attempt
   - Yield: 0-2 herbs per action
   - Special: Various herb types with different properties
   - Automation: Herb Garden (requires significant botanical knowledge)
   - Upgrades: Scent Detection increases rare herb finding chance

### Resource Storage System
- Each resource has a maximum storage capacity
- Storage capacity increases with:
  - Catropolis level upgrades
  - Specialized storage buildings
  - Research upgrades
  - Special cat abilities

---

## Cat Population System

### Starting Cat Selection
Players begin by selecting from three cat breeds, each with different starting specializations:
1. **Tabby** - Explorer specialization, bonus to discovering new areas
2. **Siamese** - Crafter specialization, bonus to building and item creation
3. **Calico** - Gatherer specialization, bonus to resource collection

### Cat Attributes
Each cat has six primary attributes:
1. **Strength** - Affects carrying capacity and certain resource gathering
2. **Agility** - Affects movement speed and certain resource gathering
3. **Intelligence** - Affects learning speed and crafting ability
4. **Charisma** - Affects recruitment and trading
5. **Luck** - Affects rare find chances and success rates
6. **Resilience** - Affects energy recovery and expedition duration

### Cat Specializations
Cats can be trained in different roles:
1. **Workers** - Gather resources automatically (slower than manual)
2. **Explorers** - Required for higher-tier exploration areas
3. **Crafters** - Create tools and building materials
4. **Scouts** - Discover new exploration areas
5. **Builders** - Speed up construction of buildings

### Cat Training
- Cats gain experience through assigned activities
- Experience leads to level-ups, improving attributes
- Training facilities enable specialization training
- Tools and equipment enhance cat abilities

### Cat Management
- Each cat can be equipped with up to 2 tools
- Cats can be assigned to buildings, resource spots, or expeditions
- Available cats provide manual resource gathering bonuses
- Maximum population increases with Catropolis level

---

## Progression System

### City Level Progression
1. **Level 1 - Makeshift Shelter**
   - Population: 1 cat (just you)
   - Storage: Basic pile (50 capacity per resource)
   - Buildings: None yet

2. **Level 2 - Small Camp**
   - Population: +2 cats (recruit strays)
   - Storage: Small cache (100 capacity)
   - Unlocks: Garden Area fully accessible
   - Buildings: Basic shelter, tiny catnip patch

3. **Level 3 - Cat Outpost**
   - Population: +3 cats
   - Storage: Organized stockpile (250 capacity)
   - Unlocks: Forest Edge exploration
   - Buildings: Small den, cat training area (unlock basic skills)
   - Cat Specialization: First worker cat can be trained

4. **Level 4 - Fledgling Colony**
   - Population: +4 cats
   - Storage: Proper storage area (500 capacity)
   - Unlocks: Riverside exploration
   - Buildings: Workshop, communal den
   - Cat Specialization: Explorer and Crafter roles unlock

5. **Level 5 - Established Settlement**
   - Population: +5 cats
   - Storage: Storage buildings (1000 capacity)
   - Unlocks: Abandoned Lot exploration
   - Buildings: Training grounds, meeting area
   - Cat Specialization: Scouts and Builders unlock

### Upgrade Requirements
For each Catropolis level upgrade:
- Specific resource quantities required
- Certain building prerequisites
- Minimum population requirements
- Specific exploration achievements may be needed

### Skill Progression
Five main skills that can be trained and improved:
1. **Gathering** - Improves resource collection efficiency
2. **Crafting** - Improves tool creation and building speed
3. **Exploration** - Improves discovery rate and expedition success
4. **Social** - Improves recruitment and trading
5. **Leadership** - Improves cat assignment efficiency and bonuses

---

## Exploration System

### Location-Based Gathering
The world is divided into distinct locations that unlock progressively:

1. **Garden Area** (Starting Location)
   - Gathering Spots: Grassy Patch, Small Bushes, Damp Corners
   - Primary Resources: Catnip, Twigs, Leaves, Moss
   - Requirements: None (starting area)

2. **Forest Edge**
   - Gathering Spots: Tall Trees, Hollow Log, Spider Corner, Rock Pile
   - Primary Resources: Twigs, Leaves, Spider Silk, Stones
   - Requirements: Catropolis Level 3, 1 Explorer cat

3. **Riverside**
   - Gathering Spots: Shallow Waters, Rocky Bank, Reeds Patch
   - Primary Resources: Small Fish, Clay, Water, Reeds
   - Requirements: Catropolis Level 4, 2 Explorer cats, Explorer Training Level 2

4. **Abandoned Lot**
   - Gathering Spots: Old Boxes, Rusty Fence, Forgotten Garden
   - Primary Resources: Metal Scraps, Seed Pods, Cloth Scraps
   - Requirements: Catropolis Level 5, 3 Explorer cats, Explorer Training Level 3

5. **Ancient Ruins**
   - Gathering Spots: Collapsed Walls, Hidden Cache, Strange Markings
   - Primary Resources: Ancient Artifacts, Lost Technology
   - Requirements: Catropolis Level 7, 5 Explorer cats, Scout Level 3

### Gathering Spots
Each location contains multiple gathering spots:
- Each spot focuses on specific resources
- Spots have different energy costs and yields
- Some spots have special requirements (tools, skills)
- Spots can be automated with the right buildings and cats

### Exploration Risks
Higher-tier locations include:
- Chance of "incidents" requiring skill checks
- Weather effects that impact gathering success
- Limited exploration energy (separate from gathering energy)
- Potential encounters with other animals

### Tool Requirements
Different locations and gathering spots may require specific tools:
- Simple Climbing Hook for tall trees
- Paw Protectors for rocky or rough terrain
- Moisture Whiskers for water-related gathering
- Light Source for dark areas

---

## Automation System

### Building Automation
Buildings that automatically generate resources:
- Tiny Catnip Patch (basic catnip generation)
- Twig Collector (automated twig gathering)
- Leaf Net (passive leaf collection)
- More advanced buildings for higher-tier resources

### Cat Assignment System
- Cats can be assigned to automate manual processes
- Each cat provides specific bonuses based on their specialization
- Multiple cats can be assigned to the same task for increased efficiency
- Cat fatigue system requires rotation for optimal production

### Production Enhancement
Various ways to improve automation:
- Building upgrades increase production rates
- Specialized cats improve efficiency
- Tools enhance production capabilities
- Research unlocks production multipliers

### Production Management UI
- Control panel for viewing all automated systems
- Production rate adjustments
- Worker assignment optimization
- Resource allocation priorities

---

## Tool & Equipment System

### Tool Types
1. **Gathering Tools**
   - Simple Climbing Hook (+15% climbing efficiency)
   - Paw Protectors (+10% defense, allows gathering from rough terrain)
   - Moisture Whiskers (+25% success in damp environments)
   - Small Basket (+20% carrying capacity)

2. **Crafting Tools**
   - Sharp Stone (+15% crafting speed)
   - Spider Silk Wrapper (+10% material efficiency)
   - Clay Mold (+25% success rate for complex items)

3. **Exploration Tools**
   - Scout Map (+20% discovery rate)
   - Light Source (unlocks dark areas)
   - Weather Protection (reduces weather penalties)

### Tool Crafting
- Tools require specific resources to craft
- Workshop building required for advanced tools
- Crafter cats improve tool quality
- Tool durability system (some tools wear out)

### Tool Enhancement
Tools can be upgraded through:
- Adding better materials
- Enchantments from rare resources
- Combination with other tools
- Special cat abilities

### Equipment Slots
- Each cat has 2 equipment slots
- Some specialized cats can use 3 slots
- Equipment can be swapped between cats
- Some equipment is cat-specific

---

## UI Screens & Flow

### Main Screens

1. **Home Screen**
   - Welcome message with current objective
   - Colony status overview
   - Resource production summary
   - Quick tasks buttons
   - Recent activity feed

2. **Catropolis Screen**
   - City level and upgrade progress
   - Building management
   - Population capacity
   - Storage management
   - Upgrade requirements

3. **Inventory Screen**
   - Resource inventory
   - Tool crafting interface
   - Item management
   - Equipment organization

4. **Resources Screen**
   - Resources overview and statistics
   - Production facilities management
   - Resource flow visualization

5. **Exploration Screen**
   - Map of unlocked and locked locations
   - Gathering spot details
   - Expedition management
   - Discovery progress

6. **Population Screen**
   - Cat roster and stats
   - Assignment management
   - Specialization training
   - Equipment assignment

7. **Skills Screen**
   - Skill trees and progression
   - Training options
   - Skill bonuses overview

8. **Research Screen** (unlocks at higher levels)
   - Technology tree
   - Research projects
   - Discovery-based unlocks

9. **Collections Screen**
   - Achievements
   - Discovered items catalog
   - Special finds showcase

### Special UI Elements

1. **Cat Breed Selection Screen** (Game Start)
   - Three starting cat options with different specializations
   - Cat naming interface
   - Starting bonus selection

2. **Resource Gathering Interface**
   - Energy cost display
   - Expected yield information
   - Success probability
   - Skill/tool bonuses

3. **Building Construction Interface**
   - Resource requirements
   - Construction time
   - Cat assignment slots
   - Upgrade options

4. **Cat Assignment Panel**
   - Available locations/buildings
   - Expected efficiency
   - Duration controls
   - Tool requirements

---

## Economy Balance

### Early Game Balance (Days 1-3)
- Focus on manual catnip gathering
- Catnip is the primary resource
- Small automation begins (Tiny Catnip Patch)
- First cat recruitment costs 100 catnip
- Basic shelter costs 50 catnip, 20 twigs

### Mid Game Balance (Days 4-10)
- Multiple resources in play
- First specialized cats
- Basic automation of Tier 1 resources
- Exploration becomes important
- Tool crafting becomes essential

### Late Game Balance (Days 11+)
- Complex resource chains
- Full automation possible
- Focus shifts to optimization
- Rare resource hunting
- Advanced building projects

### Resource Conversion Rates (Example)
- 1 Small Fish = 5 Catnip equivalent value
- 1 Stone = 3 Catnip equivalent value
- 1 Clay = 7 Catnip equivalent value
- 1 Metal Scrap = 15 Catnip equivalent value

---

This documentation provides an overview of the core systems designed for Idle Paws. During implementation, each system can be expanded with more detailed specifications as needed.
