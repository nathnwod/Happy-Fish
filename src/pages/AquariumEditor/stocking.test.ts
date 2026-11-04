import { test, expect } from 'vitest'
import { neonWeight, estimateWasteScore, calculateFishWeight, calculateTotalWasteScore, calculateStockingPercentage } from './stocking'
test('a neon tetra scores exactly 1', () => {
  expect(estimateWasteScore(neonWeight)).toBe(1)
})

test('weight formula multiplies a by length to the power of b', () => {
  expect(calculateFishWeight(1, 1, 5)).toBe(5)
})

// If this fails, the math changed (the 0.6, the neon baseline, the inch conversion, or pointsPerGallon),
test('10 neons + 6 salt and pepper corys in a 20 gallon reads 90%', () => {
  const neons = { quantity: 10, adult_size_inches: 1.5, weight_a: 0.01122, weight_b: 3.08 }
  const corys = { quantity: 6, adult_size_inches: 1.2, weight_a: 0.00741, weight_b: 3.14 }
  const totalWaste = calculateTotalWasteScore([neons, corys])
  expect(calculateStockingPercentage(totalWaste, 20)).toBeCloseTo(90)
})

