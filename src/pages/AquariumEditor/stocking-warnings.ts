export function getStockingWarnings(
    stockingPercentage: number,
    selectedFishList: { quantity: number }[],
    tankSelected: boolean
    ) {
    const warnings: { text: string; isWarning: boolean }[] = []

    let totalFish = 0
    for (const fish of selectedFishList) {
    totalFish += fish.quantity
    }

    if (totalFish === 0) {
    return [{ text: 'Add some fish to see how full your tank is.', isWarning: false }]
    }

    if (!tankSelected) {
    return [{ text: 'Pick a tank size to see how full it is.', isWarning: false }]
    }

    if (stockingPercentage > 150) {
    warnings.push({ text: 'Heavily overstocked. This tank is likely too full.', isWarning: true })
    } else if (stockingPercentage > 100) {
    warnings.push({ text: 'Lightly overstocked. Consider fewer fish or a bigger tank.', isWarning: true })
    } else if (stockingPercentage >= 90) {
    warnings.push({ text: 'Nearly full. Add fish slowly, if at all.', isWarning: true })
    }

    if (totalFish > 30 && stockingPercentage < 100) {
    warnings.push({ text: "That's a big group. Waste may look fine, but make sure your tank has enough swimming space!", isWarning: true })
    } else if (totalFish > 30) {
    warnings.push({ text: "That's a big group. Make sure your tank has enough swimming space!", isWarning: true })
    }

    if (warnings.length === 0) {
    warnings.push({ text: 'Great tank! Consider adding more fish!', isWarning: false })
    }

    return warnings
}