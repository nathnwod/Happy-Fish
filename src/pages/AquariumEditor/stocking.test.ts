import { test, expect } from 'vitest'
import { neonWeight, estimateWasteScore, calculateFishWeight, calculateTotalWasteScore, calculateStockingPercentage } from './stocking'

test('a neon tetra scores exactly 1', () => {
  expect(estimateWasteScore(neonWeight, 20)).toBe(1)
})

test('weight formula multiplies a by length to the power of b', () => {
  expect(calculateFishWeight(1, 1, 5)).toBe(5)
})

test('10 neons + 6 salt and pepper corys in a 20 gallon reads 70%', () => {
  const neons = { quantity: 10, adult_size_inches: 1.5, weight_a: 0.01122, weight_b: 3.08, waste_multiplier: 1, scientific_name: 'Paracheirodon innesi' }
  const corys = { quantity: 6, adult_size_inches: 1.5, weight_a: 0.00741, weight_b: 3.14, waste_multiplier: 1, scientific_name: 'Corydoras habrosus' }
  const totalWaste = calculateTotalWasteScore([neons, corys], 20)
  expect(calculateStockingPercentage(totalWaste, 20)).toBeCloseTo(70)
})

// If this fails, the exponent or the goldfish waste_multiplier changed
test('1 common goldfish in a 20 gallon is heavily overstocked', () => {
    const goldfish = { quantity: 1, adult_size_inches: 12, weight_a: 0.01148, weight_b: 3.04, waste_multiplier: 1.5, scientific_name: 'Carassius auratus' }
  const totalWaste = calculateTotalWasteScore([goldfish], 20)
  expect(calculateStockingPercentage(totalWaste, 20)).toBeGreaterThan(150)
})

// Fish values copied from the database
const neon = { adult_size_inches: 1.5, weight_a: 0.01122, weight_b: 3.08, waste_multiplier: 1, min_group_size: 6, scientific_name: 'Paracheirodon innesi' }
const kuhli = { adult_size_inches: 3.5, weight_a: 0.00501, weight_b: 3.08, waste_multiplier: 1, min_group_size: 5, scientific_name: 'Pangio kuhlii' }
const zebraDanio = { adult_size_inches: 2, weight_a: 0.00977, weight_b: 3.04, waste_multiplier: 1.3, min_group_size: 6, scientific_name: 'Danio rerio' }
const saltAndPepper = { adult_size_inches: 1.5, weight_a: 0.00741, weight_b: 3.14, waste_multiplier: 1.4, min_group_size: 6, scientific_name: 'Hoplisoma habrosum' }
const betta = { adult_size_inches: 2.6, weight_a: 0.00977, weight_b: 2.97, waste_multiplier: 1, min_group_size: 0, scientific_name: 'Betta splendens' }
const pygmyCory = { adult_size_inches: 1.25, weight_a: 0.00741, weight_b: 3.14, waste_multiplier: 1.6, min_group_size: 8, scientific_name: 'Gastrodermus pygmaeus' }

function percent(fishList: Parameters<typeof calculateTotalWasteScore>[0], gallons: number) {
  return calculateStockingPercentage(calculateTotalWasteScore(fishList, gallons), gallons)
}

// Mixing species should never change how a single species scores on its own
test('a species-only tank scores the same as the plain total of its fish', () => {
  const alone = percent([{ ...saltAndPepper, quantity: 8 }], 20)
  const plain = calculateStockingPercentage(calculateTotalWasteScore([{ ...saltAndPepper, quantity: 4 }], 20) * 2, 20)
  expect(alone).toBeCloseTo(plain)
})

// Hobbyist community tanks (Aquarium Co-op tank ideas). These should land near full, not well over.
test('15 neons + 5 kuhli loaches in a 20 gallon reads about full', () => {
  const result = percent([{ ...neon, quantity: 15 }, { ...kuhli, quantity: 5 }], 20)
  expect(result).toBeGreaterThan(85)
  expect(result).toBeLessThan(105)
})

test('12 zebra danios + 6 salt and pepper corys in a 20 gallon reads about full', () => {
  const result = percent([{ ...zebraDanio, quantity: 12 }, { ...saltAndPepper, quantity: 6 }], 20)
  expect(result).toBeGreaterThan(95)
  expect(result).toBeLessThan(115)
})

test('1 betta + 8 neons + 8 pygmy corys in a 10 gallon reads about full', () => {
  const result = percent([{ ...betta, quantity: 1 }, { ...neon, quantity: 8 }, { ...pygmyCory, quantity: 8 }], 10)
  expect(result).toBeGreaterThan(95)
  expect(result).toBeLessThan(115)
})

// A small extra zone should only add a little on top of the busiest zone
test('adding a few corys to a danio tank adds only a little', () => {
  const danios = percent([{ ...zebraDanio, quantity: 12 }], 20)
  const withCorys = percent([{ ...zebraDanio, quantity: 12 }, { ...saltAndPepper, quantity: 6 }], 20)
  expect(withCorys - danios).toBeLessThan(10)
})