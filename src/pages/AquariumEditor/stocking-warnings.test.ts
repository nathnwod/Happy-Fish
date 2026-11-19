import { test, expect } from 'vitest'
import { getStockingWarnings, getCompatibilityScore } from './stocking-warnings'

// Only the fields the temperature and pH checks care about. Values copied from the database.
function fish(name: string, minTemp: number, maxTemp: number, minPh: number, maxPh: number) {
  return {
    name, scientific_name: name, quantity: 8, adult_size_inches: 1.5, min_tank_gallons: 10, min_group_size: 6,
    max_group_size: 0, avoid_pair: false, temperament: 'peaceful', care_note: null as unknown as string,
    min_temp: minTemp, max_temp: maxTemp, min_ph: minPh, max_ph: maxPh, eats_fish_under_inches: 0, waste_multiplier: 1,
  }
}
const neon = fish('Neon Tetra', 72, 78, 5.0, 7.5)
const whiteCloud = fish('White Cloud Mountain Minnow', 60, 72, 6.0, 8.0)
const discus = fish('Discus', 82, 86, 6.0, 7.0)
const panda = fish('Panda Cory', 72, 77, 6.0, 7.5)
const sterbas = fish('Sterbas Cory', 75, 82, 6, 7.5)
const molly = fish('Shortfin Molly', 75, 80, 7.0, 8.0)
const cardinal = fish('Cardinal Tetra', 74, 82, 4, 7)
const guppy = fish('Guppy', 72, 82, 6.8, 7.8)

const texts = (list: ReturnType<typeof fish>[]) => getStockingWarnings(50, list, true, 29).map((w) => w.text)

test('fish with no shared temperature get a warning', () => {
  expect(texts([discus, whiteCloud]).some((t) => t.includes('No temperature suits both'))).toBe(true)
})

test('fish that only share one degree get a warning', () => {
  // White clouds top out at 72°F and neons start at 72°F
  expect(texts([neon, whiteCloud]).some((t) => t.includes('almost no temperature that suits both'))).toBe(true)
  expect(getCompatibilityScore([neon, whiteCloud], 29)).toBeLessThanOrEqual(60)
})

test('fish sharing 2-3°F get a reminder, not a warning', () => {
  // Pandas top out at 77°F and sterbas start at 75°F
  const warnings = getStockingWarnings(50, [panda, sterbas], true, 29)
  const note = warnings.find((w) => w.text.includes('keep the temperature steady between 75°F and 77°F'))
  expect(note?.isWarning).toBe(false)
  expect(warnings.some((w) => w.text.startsWith('Great tank'))).toBe(true)
  expect(getCompatibilityScore([panda, sterbas], 29)).toBe(100)
})

test('mollies with cardinals get a pH warning even though they touch at 7.0', () => {
  expect(texts([molly, cardinal]).some((t) => t.includes('harder water and the other softer water'))).toBe(true)
})

test('a pH overlap of 0.2 is too small', () => {
  // Guppies start at 6.8 and cardinals top out at 7.0
  expect(texts([guppy, cardinal]).some((t) => t.includes('pH'))).toBe(true)
})

test('a normal community tank gets no temperature or pH warnings', () => {
  const warnings = texts([neon, panda])
  expect(warnings.some((t) => t.includes('°F') || t.includes('pH'))).toBe(false)
  expect(getCompatibilityScore([neon, panda], 29)).toBe(100)
})

test('one species on its own never conflicts with itself', () => {
  const warnings = texts([sterbas])
  expect(warnings.some((t) => t.includes('°F') || t.includes('pH'))).toBe(false)
})
