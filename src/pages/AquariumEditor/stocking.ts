// Estimates a fish's weight in grams from its length in centimeters.
// Uses the length-weight formula: weight = a * length^b
// a and b come from each fish's FishBase page (Bayesian length-weight)
export function calculateFishWeight(a: number, b: number, length: number) {
  return a * length ** b
}

// Baseline fish: every other fish is compared to a neon tetra, which scores exactly 1.
// 3.8 cm is the neon's length in centimeters (1.5 inches, tail included)
export const neonWeight = calculateFishWeight(0.01122, 3.08, 3.8)

// Waste score compared to a neon tetra (neon = 1).
// The power gives big fish a discount, since they make less waste per gram.
// Research suggests 0.75; tuned down to 0.525 so big fish match hobby stocking advice.
export function estimateWasteScore(fishWeight: number, tankGallons: number) {
  let score = (fishWeight / neonWeight) ** 0.525

  // Tiny fish count as at least 0.55 of a neon, so they never count as almost nothing
  if (score < 0.55) {
    score = 0.55
  }

  // Very big tanks: every fish adds a small extra amount, no matter its size.
  // That barely changes big fish, but adds up fast with hundreds of small fish.
    // Starts above 75 gallons, grows 0.1 every 25 gallons, max 0.25.
  if (tankGallons > 75) {
    let bigTankExtra = (tankGallons - 75) / 250
    if (bigTankExtra > 0.25) {
      bigTankExtra = 0.25
    }
    score += bigTankExtra
  }

  return score
}

// Waste score for one fish, using the multiplier you give it
function oneFishScore(fish: { adult_size_inches: number; weight_a: number; weight_b: number }, tankGallons: number, multiplier: number) {
  const weight = calculateFishWeight(fish.weight_a, fish.weight_b, fish.adult_size_inches * 2.54)
  let fishScore = estimateWasteScore(weight, tankGallons) * multiplier

  // Check the 0.55 minimum again, since a low multiplier (like 0.65) can push tiny fish below it
  if (fishScore < 0.55) {
    fishScore = 0.55
  }
  return fishScore
}

// Small fish with a multiplier that don't school (like honey and dwarf gouramis).
// Their multiplier is about fighting their own kind, not about making extra waste.
function isTerritorial(fish: { adult_size_inches: number; waste_multiplier: number; min_group_size: number; scientific_name: string }) {
  const isTopFish = topGenera.includes(fish.scientific_name.split(' ')[0])
  return isTopFish && fish.adult_size_inches < 4 && fish.waste_multiplier > 1 && (!fish.min_group_size || fish.min_group_size <= 2)
}


// Where each fish spends its time, by the first word of its scientific name (the genus).
// Fish in different zones share a tank better than fish in the same zone.
const bottomGenera = [
  'Hoplisoma', 'Osteogaster', 'Brochis', 'Scleromystax', 
  'Gastrodermus', 'Ancistrus', 'Hypancistrus', 'Panaqolus', 
  'Peckoltia', 'Dekeyseria', 'Chaetostoma', 'Hemiancistrus', 
  'Baryancistrus', 'Leporacanthicus', 'Scobinancistrus', 'Pterygoplichthys', 
  'Panaque', 'Parotocinclus', 'Otocinclus', 'Pangio', 
  'Mikrogeophagus', 'Apistogramma', 'Pelvicachromis', 'Dicrossus',
  'Nannacara', 'Neolamprologus', 'Anomalochromis', 'Geophagus', 
  'Satanoperca', 'Gymnogeophagus', 'Biotodoma'
]
const topGenera = [
  'Trichogaster', 'Trichopodus', 'Trichopsis', 'Sphaerichthys', 
  'Helostoma', 'Osphronemus', 'Betta', 'Macropodus', 
  'Anabas', 'Dermogenys', 'Nomorhamphus'
]


// Dwarf cichlids claim floor territory, and a tank's floor grows slower than its gallons
// (a 75 has 3.75x the water of a 20 but only about 2.4x the floor).
// Above 20 gallons, each one counts a bit more so big tanks don't fit too many.
// Bigger cichlids (4" and up, like angelfish, severums, blue acaras and Central Americans) share the cichlid zone
// but roam the whole tank, so they skip this.
// Discus, oscars, port acaras, chocolates, keyholes and pike cichlids stay in the middle zone,
// since their community tanks matched hobbyist stocking there.
const floorTerritoryGenera = ['Mikrogeophagus', 'Apistogramma', 'Pelvicachromis', 'Dicrossus', 'Nannacara', 'Laetacara', 'Andinoacara', 'Pterophyllum', 'Mesonauta', 'Acarichthys', 'Heros', 'Uaru', 'Amatitlania', 'Thorichthys', 'Rocio', 'Trichromis', 'Herotilapia', 'Herichthys', 'Amphilophus', 'Parachromis', 'Hypsophrys', 'Cryptoheros', 'Vieja']
function floorTerritoryFactor(genus: string, tankGallons: number, sizeInches: number) {
  if (!floorTerritoryGenera.includes(genus) || tankGallons <= 20 || sizeInches >= 4) {
    return 1
  }
  return (tankGallons / 20) ** 0.5
}

// Adds up the waste score of every fish in the tank, times how many of each.
// Result is roughly "how many neons' worth of waste" the tank makes.
export function calculateTotalWasteScore(
  fishList: { quantity: number; adult_size_inches: number; weight_a: number; weight_b: number; waste_multiplier: number; min_group_size: number; scientific_name: string }[],
  tankGallons: number
) {
  let bottom = 0
  let middle = 0
  let top = 0
  // Cichlids get their own zone, since corys and plecos don't fight them for caves
  let cichlid = 0
  // The biggest discount any one territorial fish could get
  let biggestDiscount = 0

  
  for (const fish of fishList) {
    const genus = fish.scientific_name.split(' ')[0]
    const fishScore = oneFishScore(fish, tankGallons, fish.waste_multiplier) * floorTerritoryFactor(genus, tankGallons, fish.adult_size_inches)
    if (floorTerritoryGenera.includes(genus)) {
      cichlid += fishScore * fish.quantity
    } else if (bottomGenera.includes(genus)) {
      bottom += fishScore * fish.quantity
    } else if (topGenera.includes(genus)) {
      top += fishScore * fish.quantity
    } else {
      middle += fishScore * fish.quantity
    }



    if (isTerritorial(fish)) {
      const discount = fishScore - oneFishScore(fish, tankGallons, 1)
      if (discount > biggestDiscount) {
        biggestDiscount = discount
      }
    }
  }

  // Only one territorial fish in the whole tank has no rivals, so it counts as a normal fish.
  // Territorial fish are all gouramis, so the discount comes off the top zone.
  top -= biggestDiscount

  // Zones only partly add up, since those fish mostly use a different part of the tank.
  // Squaring each zone, adding them and taking the square root means:
  // - one zone alone counts exactly as itself (species-only tanks don't change)
  // - a small extra zone adds very little (12 danios + 6 corys is barely more than the danios)
  // - two busy zones add up more (two equal zones count about 1.4x one zone)
  // Tested against hobbyist community tanks from 10 to 125 gallons.
  return Math.sqrt(zoneSquared(bottom) + zoneSquared(middle) + zoneSquared(top) + zoneSquared(cichlid))
}

// A zone's score squared. Never below 0, in case the territorial discount pushed it under.
function zoneSquared(zoneScore: number) {
  return Math.max(zoneScore, 0) ** 2
}
// The calibration tank: 10 neons + 6 salt and pepper corys, added up the plain way (no zones),
// so the ruler stays the same as before.
const calibrationWaste = oneFishScore({ adult_size_inches: 1.5, weight_a: 0.01122, weight_b: 3.08 }, 20, 1) * 10
  + oneFishScore({ adult_size_inches: 1.5, weight_a: 0.00741, weight_b: 3.14 }, 20, 1) * 6

// How much waste one gallon can handle before the tank counts as 100% full.
// Calibrated so 10 neons + 6 salt and pepper sized corys (multiplier 1) in a 20 gallon reads 70%.
// This is the base ruler. Changing it changes every fish, so don't match it to the database.
export const pointsPerGallon = calibrationWaste / 0.70 / 20

export function calculateStockingPercentage(totalWaste: number, gallons: number) {
  return totalWaste / (gallons * pointsPerGallon) * 100
}