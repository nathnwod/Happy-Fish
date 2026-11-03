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
// Research suggests 0.75; tuned down to 0.6 so big fish match hobby stocking advice.
export function estimateWasteScore(fishWeight: number) {
  return (fishWeight / neonWeight) ** 0.6
}

// Adds up the waste score of every fish in the tank, times how many of each.
// Result is roughly "how many neons' worth of waste" the tank makes.
export function calculateTotalWasteScore(
  fishList: { quantity: number; adult_size_inches: number; weight_a: number; weight_b: number }[]
) {
  let total = 0
  for (const fish of fishList) {
    const weight = calculateFishWeight(fish.weight_a, fish.weight_b, fish.adult_size_inches * 2.54)
    total += estimateWasteScore(weight) * fish.quantity
  }
  return total
}

// How much waste one gallon can handle before the tank counts as 100% full.
// Calibrated so 10 neons + 6 salt and pepper corys in a 20 gallon reads 90%.
export const pointsPerGallon = 13.288279671646954 / 0.9 / 20

export function calculateStockingPercentage(totalWaste: number, gallons: number) {
  return totalWaste / (gallons * pointsPerGallon) * 100
}