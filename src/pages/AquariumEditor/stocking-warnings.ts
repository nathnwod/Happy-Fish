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
        eats_fish_under_inches: number
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
    warnings.push({ text: 'Lightly overstocked. Consider fewer fish or a bigger tank.', isWarning: true })
    } else if (percent === 100) {
    warnings.push({ text: 'At capacity! Consider Stopping here.', isWarning: true })
    } else if (percent >= 90) {
    warnings.push({ text: 'Nearly full. Add fish slowly, if at all.', isWarning: true })
    }

    if (totalFishInches / 1.2 > tankGallons && percent < 100) {
        warnings.push({ text: "You're under the waste limit, but that's a lot of fish for this tank. Make sure there's enough swimming space!", isWarning: true })
    } else if (totalFishInches / 1.2 > tankGallons && percent >= 100) {
        warnings.push({ text: "That's a lot of fish for this tank. They'll be crowded with little room to swim.", isWarning: true })
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

    if (lowestMaxTemp < highestMinTemp) {
        warnings.push({ text: `${warmestFish} and ${coolestFish} don't share a comfortable temperature range.`, isWarning: true })
        
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

    if (lowestMaxPH < highestMinPH) {
        warnings.push({ text: `${highestPhFish} and ${lowestPhFish} don't share a comfortable pH range.`, isWarning: true })
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
        return '20% every 2 weeks'
    } else if (stockingPercentage < 50) {
        return '25% every week'
    } else if (stockingPercentage < 75) {
        return '30% every week'
    } else if (stockingPercentage < 100) {
        return '40% every week'
    } else if (stockingPercentage < 125) {
        return '50% every week'
    } else {
        return 'At least 50%, 2-3 times a week'
    }
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
    }[],
    tankGallons: number
) {
    let compatibilityScore = 100

    const tempRange = getTempRange(selectedFishList)
    if (tempRange.low > tempRange.high) {
        compatibilityScore -= 40 
    }

    const phRange = getPhRange(selectedFishList)
    if (phRange.low > phRange.high){
        compatibilityScore -= 30 
    }

    const aggressiveFish = selectedFishList.filter((fish) => fish.temperament !== 'peaceful')
    const hasPeaceful = selectedFishList.some((fish) => fish.temperament === 'peaceful')
    if(aggressiveFish.length > 1){
        compatibilityScore -= 30
    } 
    if (aggressiveFish.length === 1 && hasPeaceful){
        compatibilityScore -= 15
    } 
    if (aggressiveFish.length > 1 && hasPeaceful){
        compatibilityScore -= 15
    }

    let smallestFish = 1000
    for (const fish of selectedFishList) {
        if (fish.adult_size_inches < smallestFish) {
            smallestFish = fish.adult_size_inches
        }
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