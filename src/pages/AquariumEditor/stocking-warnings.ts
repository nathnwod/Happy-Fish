export function getStockingWarnings(
    stockingPercentage: number,
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

    if (percent >= 500) {
    warnings.push({ text: 'This tank is dangerously stocked! Fish health at risk.', isWarning: true })
    } else if (percent > 150) {
    warnings.push({ text: 'Heavily overstocked. This tank is likely too full.', isWarning: true })
    } else if (percent > 100) {
    warnings.push({ text: 'Lightly overstocked. Consider fewer fish or a bigger tank.', isWarning: true })
    } else if (percent === 100) {
    warnings.push({ text: 'At capacity! Consider Stopping here.', isWarning: true })
    } else if (percent >= 90) {
    warnings.push({ text: 'Nearly full. Add fish slowly, if at all.', isWarning: true })
    }

    if (totalFishInches / 1.2 > tankGallons && percent < 100) {
        warnings.push({ text: "That's a lot of fish for this tank. Make sure there's enough swimming space!", isWarning: true })
    }

    for (const fish of selectedFishList){
        if(fish.min_tank_gallons > tankGallons){
            warnings.push({ text: `Hobbyists usually recommend at least ${fish.min_tank_gallons} gallons for ${fish.name}.` , isWarning: true })
        } 
        if (fish.quantity < fish.min_group_size){
            warnings.push({ text: `${fish.name} do best in groups of at least ${fish.min_group_size}.`, isWarning: true })
        }
    }

    let hasPeaceful = false
    for (const fish of selectedFishList) {
        if (fish.temperament === 'peaceful') {
            hasPeaceful = true
        }
    }

    for (const fish of selectedFishList) {
        if (fish.temperament !== 'peaceful' && hasPeaceful) {
            warnings.push({ text: `${fish.name} is ${fish.temperament} and may have conflicts with other fish in this tank.`, isWarning: true })
        }
    }

    for (const fish of selectedFishList) {
        if (fish.max_group_size && fish.quantity > fish.max_group_size) {
            warnings.push({ text: `Keep no more than ${fish.max_group_size} ${fish.name} in one tank.`, isWarning: true })
        }
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
    let narrowestTempRange = 1000
    for (const fish of selectedFishList) {
        if (fish.min_temp > highestMinTemp) {
            highestMinTemp = fish.min_temp
            warmestFish = fish.name
        }
        if (fish.max_temp < lowestMaxTemp) {
            lowestMaxTemp = fish.max_temp
            coolestFish = fish.name
        }
        const tempRange = fish.max_temp - fish.min_temp
        if (tempRange < narrowestTempRange) {
            narrowestTempRange = tempRange
        }
    }

    if (lowestMaxTemp - highestMinTemp < Math.min(4, narrowestTempRange)) {
        warnings.push({ text: `${warmestFish} and ${coolestFish} need different water temperatures.`, isWarning: true })
    }

    // pH
    let highestMinPH = 0
    let lowestMaxPH = 1000
    let highestPhFish = ''
    let lowestPhFish = ''
    let narrowestPhRange = 1000
    for (const fish of selectedFishList) {
        if (fish.min_ph > highestMinPH) {
            highestMinPH = fish.min_ph
            highestPhFish = fish.name
        }
        if (fish.max_ph < lowestMaxPH) {
            lowestMaxPH = fish.max_ph
            lowestPhFish = fish.name
        }
        const phRange = fish.max_ph - fish.min_ph
        if (phRange < narrowestPhRange) {
            narrowestPhRange = phRange
        }
    }

    if (lowestMaxPH - highestMinPH < Math.min(0.5, narrowestPhRange)) {
        warnings.push({ text: `${highestPhFish} and ${lowestPhFish} need different pH levels.`, isWarning: true })
    }
    
    if (warnings.length === 0) {
        warnings.push({ text: 'Great tank! Consider adding more fish!', isWarning: false })
    }

    for (const fish of selectedFishList) {
        if (fish.care_note != null){
            warnings.push({ text: `${fish.care_note}`, isWarning: false})
        }
    }


    return warnings
}