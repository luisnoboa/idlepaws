# Idle Paws - Resource Gathering System

## Locations and Gathering Spots Overview

| Location | Gathering Spot | Unlocked By Default | Energy Cost | Gathering Time | Resource Yields | Unlock Requirements |
|----------|---------------|---------------------|-------------|----------------|-----------------|---------------------|
| **Garden Area** | Grassy Patch | ✅ | 5 | 3s | Catnip (1-3) | - |
| **Garden Area** | Small Bushes | ✅ | 8 | 4s | Twigs (1-2), Leaves (0-1, 50%) | - |
| **Garden Area** | Damp Corners | ❌ | 7 | 5s | Moss (0-1, 50%) | 20 Twigs, 10 Leaves |
| **Forest Edge** | Tall Trees | ✅ | 8 | 5s | Twigs (1-2), Leaves (2-4), Spider Silk (0-1, 10%) | - |
| **Forest Edge** | Hollow Log | ✅ | 10 | 6s | Moss (0-1, 50%), Twigs (1-2) | - |
| **Forest Edge** | Spider Corner | ❌ | 12 | 8s | Spider Silk (0-1, 40%) | 50 Twigs |
| **Riverside** | Shallow Waters | ✅ | 15 | 7s | Small Fish (0-2), Water (3-5) | - |
| **Riverside** | Rocky Bank | ✅ | 10 | 5s | Stones (1-2), Clay (2-4) | - |

## Location Details

| Location | Required Level | Default Unlock Status | Travel Time | Proximity Bonuses |
|----------|---------------|----------------------|-------------|-------------------|
| **Garden Area** | 1 | ✅ | 0 min | None |
| **Forest Edge** | 3 | ❌ | 10 min | Twigs +25%, Leaves +20% |
| **Riverside** | 4 | ❌ | 25 min | Small Fish +30%, Clay +25% |

## Resource Properties

| Resource | Tier | Base Storage Limit | Base Production Rate | Category | Tags |
|----------|------|-------------------|--------------------|----------|------|
| Catnip | 1 | 50 | 0.1 | Currency, Food | edible, currency |
| Twigs | 1 | 30 | 0.05 | Crafting Material | construction, gatherable |
| Leaves | 1 | 40 | 0.07 | Natural Material | organic, gatherable |
| Moss | 1 | 20 | 0.02 | Natural Material | organic, rare |
| Stones | 2 | 25 | 0.01 | Crafting Material | construction, heavy |
| Spider Silk | 2 | 15 | 0.005 | Rare Material | crafting, valuable |
| Small Fish | 2 | 10 | 0.02 | Food | edible, perishable |
| Clay | 2 | 35 | 0.03 | Crafting Material | moldable, construction |

## Recommended Tools for Gathering Spots

| Gathering Spot | Recommended Tool | Tool Bonus |
|----------------|-----------------|------------|
| Tall Trees | Simple Climbing Hook | +15% yield |
| Hollow Log | Small Claws | +10% yield |
| Spider Corner | Spider Silk Collector | +25% yield, +20% chance |
| Shallow Waters | Fishing Paws | +20% Small Fish yield |
| Rocky Bank | Stone Carrying Pouch | +30% carrying capacity |

## Automation Buildings

| Building | Unlocked At | Resource Produced | Production Rate | Build Cost |
|----------|-------------|-------------------|-----------------|------------|
| Tiny Catnip Patch | Catropolis Lvl 2 | Catnip | 1 per 3 min | 100 Catnip |
| Twig Collector | Catropolis Lvl 2 | Twigs | 1 per 5 min | 75 Catnip, 25 Twigs |
| Leaf Net | Catropolis Lvl 3 | Leaves | 1 per 6 min | 100 Twigs, 50 Leaves |
| Moss Garden | Catropolis Lvl 3 | Moss | 1 per 10 min | 200 Catnip, 50 Moss, 100 Leaves |
| Stone Tumbler | Catropolis Lvl 4 | Stones | 1 per 8 min | 150 Twigs, 50 Stones |
| Spider Farm | Catropolis Lvl 5 | Spider Silk | 1 per 15 min | 100 Spider Silk, 200 Twigs |

## Home Location Bonuses

| Location | Proximity Bonus | Affected Resources |
|----------|----------------|-------------------|
| Garden Area | None | - |
| Forest Edge | +25% | Twigs, Leaves |
| Forest Edge | +20% | Spider Silk |
| Riverside | +30% | Small Fish |
| Riverside | +25% | Clay, Water |

## Resource Requirements for Unlocking Locations

| Location to Unlock | Level Required | Resource Requirements | Cat Requirements |
|--------------------|--------------------|----------------------|-----------------|
| Forest Edge | 3 | 200 Catnip, 100 Twigs | 1 Explorer Cat |
| Riverside | 4 | 300 Catnip, 150 Twigs, 50 Stones | 2 Explorer Cats |
| Abandoned Lot | 5 | 500 Catnip, 200 Twigs, 100 Stones, 50 Spider Silk | 3 Explorer Cats |

---

## Future Expansion Notes

**Planned Resources for Next Update:**
- Water Source - Tier 3, requires Riverside access
- Metal Scraps - Tier 3, found in Abandoned Lot
- Seed Pods - Tier 2, rare find in Garden Area and Forest Edge
- Herbs - Tier 2, specialized gathering in special spots

**Planned Locations:**
- Ancient Ruins - Level 7 requirement, yields rare ancient artifacts
- City Outskirts - Level 6 requirement, access to human-made materials
