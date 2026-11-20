// Fish need some room between their temperature limits, since tank temperature moves a degree or two.
// Sharing less than 2°F is a warning. Sharing 2-3°F gets a reminder to keep the temperature steady.
export const minSafeTempOverlap = 2
export const tightTempOverlap = 3
// pH drifts a few tenths during the day, so fish need to share at least 0.5
export const minSafePhOverlap = 0.5

// How much of a pH range two fish share. Rounded, since 7.2 - 6.8 isn't exactly 0.4 in JavaScript.
function phOverlap(highestMin: number, lowestMax: number) {
    return Math.round((lowestMax - highestMin) * 10) / 10
}

// How many of this fish's species are in the tank. Color forms like "Betta splendens (Halfmoon)" count together.
function countSameSpecies(selectedFishList: { quantity: number; scientific_name: string }[], scientificName: string) {
    const species = scientificName.split(' (')[0]
    let count = 0
    for (const other of selectedFishList) {
        if (other.scientific_name.split(' (')[0] === species) {
            count += other.quantity
        }
    }
    return count
}

export function getStockingWarnings(
    stockingPercentage: number,

    selectedFishList: {
        quantity: number,
        name: string,
        scientific_name: string,  
        adult_size_inches: number,
        min_tank_gallons: number,
        min_group_size: number,
        max_group_size: number,
        avoid_pair: boolean,
        temperament: string,
        care_note: string,
        min_temp: number,
        max_temp: number,
        min_ph: number,
        max_ph: number,
        eats_fish_under_inches: number,
        waste_multiplier: number,
    }[],
    tankSelected: boolean,
    tankGallons: number
) {
    const warnings: { text: string; isWarning: boolean }[] = []

    let totalFish = 0
    let totalFishInches = 0
    for (const fish of selectedFishList) {
        totalFish += fish.quantity
        totalFishInches += fish.quantity * fish.adult_size_inches
    }

    if (totalFish === 0) {
        return [{ text: 'Add some fish to see how full your tank is!', isWarning: false }]
    }

    if (!tankSelected) {
        return [{ text: 'Pick a tank size to see how full it is!', isWarning: false }]
    }

    const percent = Math.round(stockingPercentage)

    if (percent >= 275) {
    warnings.push({ text: 'This tank is dangerously stocked! Fish health at risk.', isWarning: true })
    } else if (percent > 150) {
    warnings.push({ text: 'Heavily overstocked. Needs very frequent water changes, fewer fish, or a bigger tank.', isWarning: true })
    } else if (percent > 125) {
    warnings.push({ text: 'Overstocked. Needs extra water changes, fewer fish, or a bigger tank.', isWarning: true })
    } else if (percent > 100) {
    warnings.push({ text: 'Lightly overstocked. Consider fewer fish or a bigger tank. Not recommended for beginners.', isWarning: true })
    } else if (percent === 100) {
    warnings.push({ text: 'At capacity! Consider Stopping here.', isWarning: true })
    } else if (percent >= 90) {
    warnings.push({ text: 'Nearly full. Add fish slowly, if at all.', isWarning: false })
    }

    // Big tanks can handle a few more inches of fish per gallon
    let inchesPerGallon = 1.5
    if (tankGallons > 75) {
        inchesPerGallon = 1.8
    }

    if (totalFishInches / inchesPerGallon > tankGallons && percent < 100) {
        warnings.push({ text: "You're under the waste limit, but that's a lot of fish for this tank. Your tank is likely overcrowded!", isWarning: true })
    } else if (totalFishInches / inchesPerGallon > tankGallons && percent >= 100) {
        warnings.push({ text: "Your tank is likely overcrowded. Make sure there's enough swimming space.", isWarning: true })
    }


    for (const fish of selectedFishList){
        if(fish.min_tank_gallons > tankGallons){
            warnings.push({ text: `Hobbyists usually recommend at least ${fish.min_tank_gallons} gallons for ${fish.name}.` , isWarning: true })
        } 
        if (fish.quantity < fish.min_group_size){
            warnings.push({ text: `${fish.name} do best in groups of at least ${fish.min_group_size}.`, isWarning: true })
        }
    }

        let smallestFish = 1000
    for (const fish of selectedFishList) {
        if (fish.adult_size_inches < smallestFish) {
            smallestFish = fish.adult_size_inches
        }
    }

    let aggressiveEater = false
    for (const fish of selectedFishList) {
        if (fish.eats_fish_under_inches && smallestFish < fish.eats_fish_under_inches) {
            warnings.push({ text: `${fish.name} may eat smaller fish in this tank.`, isWarning: true })
            if (fish.temperament !== 'peaceful') {
                aggressiveEater = true
            }
        }
    }

    const aggressiveFish = selectedFishList.filter((fish) => fish.temperament !== 'peaceful')
    const hasPeaceful = selectedFishList.some((fish) => fish.temperament === 'peaceful')

    if (aggressiveFish.length > 1) {
        warnings.push({ text: 'Mixing aggressive or semi-aggressive fish can lead to fights.', isWarning: true })
    } else if (aggressiveFish.length === 1 && hasPeaceful && !aggressiveEater) {
        warnings.push({ text: `${aggressiveFish[0].name} is ${aggressiveFish[0].temperament} and may bother peaceful fish in this tank.`, isWarning: true })
    }

    // Species that already got a max group warning, so color forms don't repeat it
    const warnedSpecies: string[] = []
    for (const fish of selectedFishList) {
        const species = fish.scientific_name.split(' (')[0]
        if (fish.max_group_size && countSameSpecies(selectedFishList, fish.scientific_name) > fish.max_group_size && !warnedSpecies.includes(species)) {
            warnedSpecies.push(species)
            if (fish.max_group_size === 1) {
                warnings.push({ text: `Keep only 1 ${fish.name} per tank. They get territorial with their own kind, so a second one usually means fighting. Color forms count as the same fish.`, isWarning: true })
            } else {
                warnings.push({ text: `Keep no more than ${fish.max_group_size} ${fish.name} in one tank. Males fight over territory, so more than ${fish.max_group_size} usually means constant fighting. Color forms count as the same fish.`, isWarning: true })
            }
        }
    }

    // Gouramis, bettas and paradise fish all claim the surface, so different species fight each other
    const labyrinthGenera = ['Trichogaster', 'Trichopodus', 'Trichopsis', 'Sphaerichthys', 'Helostoma', 'Osphronemus', 'Betta', 'Macropodus', 'Anabas']
    // Color forms like "Trichogaster chuna (Sunset)" count as the same species
    const labyrinthSpecies: string[] = []
    for (const fish of selectedFishList) {
        const species = fish.scientific_name.split(' (')[0]
        if (labyrinthGenera.includes(species.split(' ')[0]) && !labyrinthSpecies.includes(species)) {
            labyrinthSpecies.push(species)
        }
    }
    if (labyrinthSpecies.length >= 2) {
        warnings.push({ text: "You have more than one kind of gourami, betta or paradise fish. They all claim the water's surface, so different kinds often chase and fight. It can work in a big, heavily planted tank, but watch them closely.", isWarning: true })
    }

    
    // Dwarf cichlids all claim a patch of the bottom, so different species fight over caves
    const dwarfCichlidGenera = [
        'Mikrogeophagus', 'Apistogramma', 'Pelvicachromis', 
        'Dicrossus', 'Nannacara', 'Cleithracara', 
        'Neolamprologus', 'Laetacara', 'Anomalochromis'
    ]
    // Color forms count as the same species
    const dwarfCichlidSpecies: string[] = []
    for (const fish of selectedFishList) {
        const species = fish.scientific_name.split(' (')[0]
        if (dwarfCichlidGenera.includes(species.split(' ')[0]) && !dwarfCichlidSpecies.includes(species)) {
            dwarfCichlidSpecies.push(species)
        }
    }
    if (dwarfCichlidSpecies.length >= 2) {
        warnings.push({ text: "You have more than one kind of dwarf cichlid. They all claim a patch of the bottom, so different kinds often fight over caves, especially when breeding. It can work in a big tank with lots of caves and plants, but watch them closely.", isWarning: true })
    }

    for (const fish of selectedFishList) {
        if (fish.avoid_pair && fish.quantity === 2) {
            warnings.push({ text: `Two ${fish.name} often fight. Keep one, or three or more.`, isWarning: true })
        }
    }

    // Temperature
    let highestMinTemp = 0
    let lowestMaxTemp = 1000
    let warmestFish = ''
    let coolestFish = ''
    for (const fish of selectedFishList) {
        if (fish.min_temp > highestMinTemp) {
            highestMinTemp = fish.min_temp
            warmestFish = fish.name
        }
        if (fish.max_temp < lowestMaxTemp) {
            lowestMaxTemp = fish.max_temp
            coolestFish = fish.name
        }
    }

    // Only compare when two different fish set the limits. One fish's own range is never a conflict.
    const tempConflict = warmestFish !== coolestFish
    const tempOverlap = lowestMaxTemp - highestMinTemp
    let tightTempNote = ''

    if (tempConflict && tempOverlap < 0) {
        warnings.push({ text: `${warmestFish} need at least ${highestMinTemp}°F, but ${coolestFish} do best at ${lowestMaxTemp}°F or cooler. No temperature suits both.`, isWarning: true })
    } else if (tempConflict && tempOverlap < minSafeTempOverlap) {
        warnings.push({ text: `${warmestFish} need at least ${highestMinTemp}°F, but ${coolestFish} do best at ${lowestMaxTemp}°F or cooler. That leaves almost no temperature that suits both.`, isWarning: true })
    } else if (tempConflict && tempOverlap <= tightTempOverlap) {
        // Not a problem, just a reminder. Added after the "Great tank" check so it doesn't hide it.
        tightTempNote = `These fish only share a narrow temperature range, so keep the temperature steady between ${highestMinTemp}°F and ${lowestMaxTemp}°F.`
    }

    // pH
    let highestMinPH = 0
    let lowestMaxPH = 1000
    let highestPhFish = ''
    let lowestPhFish = ''
    for (const fish of selectedFishList) {
        if (fish.min_ph > highestMinPH) {
            highestMinPH = fish.min_ph
            highestPhFish = fish.name
        }
        if (fish.max_ph < lowestMaxPH) {
            lowestMaxPH = fish.max_ph
            lowestPhFish = fish.name
        }
    }

    // pH drifts a few tenths during the day, so a shared range under 0.5 can't really be held
    if (highestPhFish !== lowestPhFish && phOverlap(highestMinPH, lowestMaxPH) < minSafePhOverlap) {
        warnings.push({ text: `${highestPhFish} need a pH of at least ${highestMinPH.toFixed(1)}, but ${lowestPhFish} do best at ${lowestMaxPH.toFixed(1)} or lower. One usually needs harder water and the other softer water, so it's hard to keep both healthy.`, isWarning: true })
    }

    if (warnings.length === 0 && percent < 70) {
    warnings.push({ text: 'Great tank! You have room for more fish.', isWarning: false })
    } else if (warnings.length === 0) {
        warnings.push({ text: "Great tank! You're getting close to full.", isWarning: false })
    }

    if (tightTempNote) {
        warnings.push({ text: tightTempNote, isWarning: false })
    }

    for (const fish of selectedFishList) {
        if (fish.care_note != null){
            warnings.push({ text: `${fish.care_note}`, isWarning: false})
        }
    }

    return warnings
}

export function getTempRange(selectedFishList: { min_temp: number, max_temp: number }[]) {
    let highestMinTemp = 0
    let lowestMaxTemp = 1000

    for (const fish of selectedFishList) {
        if (fish.min_temp > highestMinTemp) {
            highestMinTemp = fish.min_temp
        }
        if (fish.max_temp < lowestMaxTemp) {
            lowestMaxTemp = fish.max_temp
        }
    }

    return { low: highestMinTemp, high: lowestMaxTemp }
}

export function getPhRange(selectedFishList: { min_ph: number, max_ph: number }[]) {
    let highestMinPH = 0
    let lowestMaxPH = 1000

    for (const fish of selectedFishList) {
        if (fish.min_ph > highestMinPH) {
            highestMinPH = fish.min_ph
        }
        if (fish.max_ph < lowestMaxPH) {
            lowestMaxPH = fish.max_ph
        }
    }
    return { low: highestMinPH, high: lowestMaxPH }
}

export function suggestWaterChangeSchedule(stockingPercentage: number, tankGallons: number) {
    if (tankGallons === 0) {
        return 'Pick a tank size!'
    } else if (stockingPercentage < 25) {
        return '20% or more every 2 weeks'
    } else if (stockingPercentage < 50) {
        return '25% or more each week'
    } else if (stockingPercentage < 75) {
        return '30% or more each week'
    } else if (stockingPercentage < 90) {
        return '40% or more each week'
    } else if (stockingPercentage < 105) {
        return '50% or more each week'
    } else if (stockingPercentage < 120) {
        return '60% or more each week'
    } else if (stockingPercentage < 135) {
        return '75% or more each week, split into 2 changes'
    } else {
        return 'At least 50%, 2-3 times a week'
    }
}

export function getSuggestedFlowRate(
    stockingPercentage: number,
    selectedFishList: {waste_multiplier: number, adult_size_inches: number}[], 
    tankGallons: number)
    {
    // Messy = high waste AND at least 4 inches, so tiny fish like pygmy corys don't count
    const hasMessyFish = selectedFishList.some((fish) => fish.waste_multiplier >= 1.45 && fish.adult_size_inches >= 4)

    // Start at 4x, add 1x for every 50% stocked, max 10x
    let turnover = 4 + stockingPercentage / 50
    if (turnover > 10) {
        turnover = 10
    }

   // messyfish need strong filtration, so never go below 8x
    if (hasMessyFish && turnover < 8) {
        turnover = 8
    }

    return Math.round(tankGallons * turnover)
}
    


export function getCompatibilityScore(
    selectedFishList: {
        quantity: number,
        name: string,
        adult_size_inches: number,
        min_tank_gallons: number,
        min_group_size: number,
        max_group_size: number,
        avoid_pair: boolean,
        temperament: string,
        care_note: string,
        min_temp: number,
        max_temp: number,
        min_ph: number,
        max_ph: number,
        eats_fish_under_inches: number,
        waste_multiplier: number,
    }[],
    tankGallons: number
) {
    let compatibilityScore = 100

    // Same limits as the warnings. With one species the range is its own, so it never counts against it.
    const tempRange = getTempRange(selectedFishList)
    if (selectedFishList.length > 1 && tempRange.high - tempRange.low < minSafeTempOverlap) {
        compatibilityScore -= 40
    }

    const phRange = getPhRange(selectedFishList)
    if (selectedFishList.length > 1 && phOverlap(phRange.low, phRange.high) < minSafePhOverlap) {
        compatibilityScore -= 30
    }

    let smallestFish = 1000
    for (const fish of selectedFishList) {
        if (fish.adult_size_inches < smallestFish) {
            smallestFish = fish.adult_size_inches
        }
    }

    const aggressiveFish = selectedFishList.filter((fish) => fish.temperament !== 'peaceful')
    const hasPeaceful = selectedFishList.some((fish) => fish.temperament === 'peaceful')
    // If the aggressive fish also eats fish here, it already loses 20 below, so don't double count
    const aggressiveEater = aggressiveFish.some((fish) => fish.eats_fish_under_inches > smallestFish)
    
    if(aggressiveFish.length > 1){
        compatibilityScore -= 30
    } 
    if (aggressiveFish.length === 1 && hasPeaceful && !aggressiveEater){
        compatibilityScore -= 15
    } 
    if (aggressiveFish.length > 1 && hasPeaceful){
        compatibilityScore -= 15
    }

    for (const fish of selectedFishList) {
        if (fish.quantity < fish.min_group_size){
            compatibilityScore -= 10
        }
        if(fish.max_group_size && fish.quantity > fish.max_group_size){
            compatibilityScore -= 40
        }
        if(fish.avoid_pair && fish.quantity === 2){
            compatibilityScore -= 20
        }
        if(fish.min_tank_gallons > tankGallons){
            compatibilityScore -= 10
        }
        if (fish.eats_fish_under_inches && smallestFish < fish.eats_fish_under_inches) {
            compatibilityScore -= 20
        }
    }

    if (compatibilityScore < 0){
        compatibilityScore = 0
    }

    return compatibilityScore
}


// Sponge filters are sold by tank size.
// About one sponge per 40 gallons. Overstocked tanks get one extra sponge,
// and heavily overstocked tanks also get bigger sponges.
export function getSpongeSuggestion(stockingPercentage: number, tankGallons: number) {
    // About one sponge per 40 gallons
    let spongeCount = Math.ceil(tankGallons / 40)

    // Each sponge covers its share of the tank
    let eachRating = tankGallons / spongeCount

    // Overstocked: add one extra sponge (max one extra)
    if (stockingPercentage > 100) {
        spongeCount += 1
    }

    // Heavily overstocked: also size the sponges up
    if (stockingPercentage > 150) {
        eachRating *= 2
    }

    // Round up to the nearest 5 gallons
    eachRating = Math.ceil(eachRating / 5) * 5

    if (spongeCount === 1) {
        return `1 sponge rated for ${eachRating}+ gallons`
    }
    return `${spongeCount} sponges, each rated for ${eachRating}+ gallons`
}