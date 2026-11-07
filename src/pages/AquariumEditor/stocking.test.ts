import { test, expect } from 'vitest'
import { neonWeight, estimateWasteScore, calculateFishWeight, calculateTotalWasteScore, calculateStockingPercentage } from './stocking'

test('a neon tetra scores exactly 1', () => {
  expect(estimateWasteScore(neonWeight)).toBe(1)
})

test('weight formula multiplies a by length to the power of b', () => {
  expect(calculateFishWeight(1, 1, 5)).toBe(5)
})

test('10 neons + 6 salt and pepper corys in a 20 gallon reads 55%', () => {
  const neons = { quantity: 10, adult_size_inches: 1.5, weight_a: 0.01122, weight_b: 3.08, waste_multiplier: 1 }
  const corys = { quantity: 6, adult_size_inches: 1.5, weight_a: 0.00741, weight_b: 3.14, waste_multiplier: 1 }
  const totalWaste = calculateTotalWasteScore([neons, corys])
  expect(calculateStockingPercentage(totalWaste, 20)).toBeCloseTo(55)
})

// If this fails, the exponent or the goldfish waste_multiplier changed
test('1 common goldfish in a 20 gallon is heavily overstocked', () => {
  const goldfish = { quantity: 1, adult_size_inches: 12, weight_a: 0.01148, weight_b: 3.04, waste_multiplier: 1.5 }
  const totalWaste = calculateTotalWasteScore([goldfish])
  expect(calculateStockingPercentage(totalWaste, 20)).toBeGreaterThan(150)
})