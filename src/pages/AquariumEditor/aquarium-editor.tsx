import './aquarium-editor.css'
import React, { useState, useEffect } from 'react'
import { calculateFishWeight, calculateTotalWasteScore, pointsPerGallon } from './stocking'
import { getStockingWarnings, getTempRange, getPhRange, suggestWaterChangeSchedule } from './stocking-warnings'


// ============================================
// TYPES + OPTIONS
// ============================================

const vegetationOptions = [
    { id: 'none', label: 'No Plants' },
    { id: 'light', label: 'Lightly Planted' },
    { id: 'moderate', label: 'Moderately Planted' },
    { id: 'heavy', label: 'Heavily Planted' },
]

// A species as it comes from the database
type Fish = {
    id: number
    name: string
    scientific_name: string
    skill_level: string
    adult_size_inches: number
    weight_a: number
    weight_b: number
    min_tank_gallons: number
    min_group_size: number
    max_group_size: number
    avoid_pair: boolean
    temperament: string
    care_note: string
    min_temp: number
    max_temp: number
    min_ph: number
    max_ph: number
}

// A fish the user added to their tank
type SelectedFish = {
    id: string
    name: string
    quantity: number
    skill_level: string
    adult_size_inches: number
    weight_a: number
    weight_b: number
    min_tank_gallons: number
    min_group_size: number
    max_group_size: number
    avoid_pair: boolean
    temperament: string
    care_note: string
    min_temp: number
    max_temp: number
    min_ph: number
    max_ph: number
}

type Tank = {
    id: number
    label: string
    gallons: number
}


export default function AquariumEditor() {

    // ============================================
    // STATE
    // ============================================

    const [tankSize, setTankSize] = useState('')
    const [fishName, setFishName] = useState('')
    const [quantity, setQuantity] = useState(1)
    const [vegetationLevel, setVegetationLevel] = useState('')
    const [fishList, setFishList] = useState<Fish[]>([])
    const [tankSizesList, setTankSizesList] = useState<Tank[]>([])
    const [selectedFishList, setSelectedFishList] = useState<SelectedFish[]>([])


    // ============================================
    // LOAD DATA (species + tank sizes)
    // ============================================

    useEffect(() => {
        fetch('http://127.0.0.1:8000/species')
            .then((res) => res.json())
            .then((data) => setFishList(data))
        fetch('http://127.0.0.1:8000/tank_sizes')
            .then((res) => res.json())
            .then((data) => setTankSizesList(data))
    }, [])


    // ============================================
    // ADD FISH FORM (left panel)
    // ============================================

    function addOne() {
        setQuantity((prev) => prev + 1)
    }

    function subtractOne() {
        if (quantity > 1) {
            setQuantity((prev) => prev - 1)
        }
    }

    function addFish() {
        const alreadyAdded = selectedFishList.some((fish) => fish.name === fishName)
        const matchedFish = fishList.find((fish) => fishName === `${fish.name} (${fish.scientific_name})`)

        if (matchedFish && !alreadyAdded) {
            setSelectedFishList((prev) => [...prev, {
                id: crypto.randomUUID(),
                name: fishName,
                quantity: quantity,
                skill_level: matchedFish.skill_level,
                adult_size_inches: matchedFish.adult_size_inches,
                weight_a: matchedFish.weight_a,
                weight_b: matchedFish.weight_b,
                min_tank_gallons: matchedFish.min_tank_gallons,
                min_group_size: matchedFish.min_group_size,
                max_group_size: matchedFish.max_group_size,
                avoid_pair: matchedFish.avoid_pair,
                temperament: matchedFish.temperament,
                care_note: matchedFish.care_note,
                min_temp: matchedFish.min_temp,
                max_temp: matchedFish.max_temp,
                min_ph: matchedFish.min_ph,
                max_ph: matchedFish.max_ph,
            }])
        }

        if (alreadyAdded) {
            setSelectedFishList((prev) => prev.map((fish) => {
                if (fish.name === fishName) {
                    return { ...fish, quantity: fish.quantity + quantity }
                }
                return fish
            }))
        }

        setFishName('')
        setQuantity(1)
    }


    // ============================================
    // FISH CARDS (quantity changes + remove)
    // ============================================

    function addOneToFish(id: string) {
        setSelectedFishList((prev) => prev.map((fish) => {
            if (fish.id === id) {
                return { ...fish, quantity: Math.min(999, fish.quantity + 1) }
            }
            return fish
        }))
    }

    function subtractOneFromFish(id: string) {
        setSelectedFishList((prev) => prev.map((fish) => {
            if (fish.id === id && fish.quantity > 1) {
                return { ...fish, quantity: fish.quantity - 1 }
            }
            return fish
        }))
    }

    function setFishQuantity(id: string, newQuantity: number) {
        setSelectedFishList((prev) => prev.map((fish) => {
            if (fish.id === id) {
                return { ...fish, quantity: newQuantity }
            }
            return fish
        }))
    }

    function removeFish(id: string) {
        setSelectedFishList((prev) => prev.filter((fish) => fish.id !== id))
    }


    // ============================================
    // STOCKING CALCULATIONS
    // ============================================

    const totalWaste = calculateTotalWasteScore(selectedFishList)
    const selectedTank = tankSizesList.find((tank) => tank.label === tankSize)
    const tankGallons = selectedTank ? selectedTank.gallons : 0

    // Plants absorb some waste, so they raise the tank's capacity
    let capacity = selectedTank ? selectedTank.gallons * pointsPerGallon : 0
    if (vegetationLevel === 'none') {
        capacity *= 1
    } else if (vegetationLevel === 'light') {
        capacity *= 1.1
    } else if (vegetationLevel === 'moderate') {
        capacity *= 1.2
    } else if (vegetationLevel === 'heavy') {
        capacity *= 1.3
    }

    const stockingPercentage = capacity > 0 ? totalWaste / capacity * 100 : 0
    const warnings = getStockingWarnings(stockingPercentage, selectedFishList, Boolean(selectedTank), tankGallons)
    const tempRange = getTempRange(selectedFishList)
    const phRange = getPhRange(selectedFishList)
    const waterChange = suggestWaterChangeSchedule(stockingPercentage, tankGallons)

    let totalFish = 0
    for (const fish of selectedFishList) {
        totalFish += fish.quantity
    }


    // ============================================
    // PAGE
    // ============================================

    return (
        <div className="editor-page">

            {/* Debug output: remove before shipping */}
            <p className="test">{totalWaste}</p>
            <p className="test">{calculateFishWeight(0.02692, 3.03, 15.24)}</p>

            <div className="editor-column">

                {/* Top bar: cancel / tank name / save */}
                <div className="editor-actions">
                    <button className="cancel-btn">Cancel <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#e3e3e3"><path d="m336-280 144-144 144 144 56-56-144-144 144-144-56-56-144 144-144-144-56 56 144 144-144 144 56 56ZM480-80q-83 0-156-31.5T197-197q-54-54-85.5-127T80-480q0-83 31.5-156T197-763q54-54 127-85.5T480-880q83 0 156 31.5T763-763q54 54 85.5 127T880-480q0 83-31.5 156T763-197q-54 54-127 85.5T480-80Zm0-80q134 0 227-93t93-227q0-134-93-227t-227-93q-134 0-227 93t-93 227q0 134 93 227t227 93Zm0-320Z"/></svg></button>
                    <button className="tank-name-btn">New Aquarium <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#e3e3e3"><path d="M200-200h57l391-391-57-57-391 391v57Zm-80 80v-170l528-527q12-11 26.5-17t30.5-6q16 0 31 6t26 18l55 56q12 11 17.5 26t5.5 30q0 16-5.5 30.5T817-647L290-120H120Zm640-584-56-56 56 56Zm-141 85-28-29 57 57-29-28Z"/></svg></button>
                    <button className="save-btn">Save <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#e3e3e3"><path d="M840-680v480q0 33-23.5 56.5T760-120H200q-33 0-56.5-23.5T120-200v-560q0-33 23.5-56.5T200-840h480l160 160Zm-80 34L646-760H200v560h560v-446ZM565-275q35-35 35-85t-35-85q-35-35-85-35t-85 35q-35 35-35 85t35 85q35 35 85 35t85-35ZM240-560h360v-160H240v160Zm-40-86v446-560 114Z"/></svg></button>
                </div>

                {/* Tank preview */}
                <div className="tank-preview"></div>

            </div>

            <div className="editor-panels">

                {/* ============ LEFT PANEL: your tank ============ */}
                <div className="inputs-panel">

                    {/* Tank size */}
                    <div className="tank-size-section">
                        <h3 className="tank-size-section-title">Select Aquarium Size</h3>
                        <input
                            id="tank-size-input"
                            list="tank-size-list"
                            value={tankSize}
                            onChange={(e) => setTankSize(e.target.value)}
                            placeholder="Search Sizes"
                        />
                        <datalist id="tank-size-list">
                            {tankSizesList.map((tank) => (
                                <option key={tank.id} value={tank.label} />
                            ))}
                        </datalist>
                    </div>

                    {/* Vegetation */}
                    <div className="vegetation-section">
                        <h3 className="vegetation-section-title">Select Vegetation Level</h3>
                        <div className="vegetation-level-options">
                            {vegetationOptions.map((option) => (
                                <button
                                    key={option.id}
                                    className={vegetationLevel === option.id ? 'vegetation-btn selected' : 'vegetation-btn'}
                                    onClick={() => setVegetationLevel(option.id)}
                                >
                                    <span className="shimmer-wave shimmer-wave-text">{option.label}</span>
                                </button>
                            ))}
                        </div>
                    </div>

                    {/* Add fish */}
                    <div className="add-fish-main-section">
                        <div className="fish-species-section">
                            <h3 className="fish-species-section-title">Select Fish</h3>
                            <input
                                id="fish-input"
                                list="fish-list"
                                value={fishName}
                                onChange={(e) => setFishName(e.target.value)}
                                placeholder="Search Fish"
                            />
                            <datalist id="fish-list">
                                {fishList.map((fish) => (
                                    <option key={fish.id} value={`${fish.name} (${fish.scientific_name})`} />
                                ))}
                            </datalist>
                        </div>

                        <div className="fish-quantity-section">
                            <h3 className="fish-quantity-section-title">Choose Quantity</h3>
                            <div className="quantity-field">
                                <div className="quantity-row">
                                    <input
                                        id="quantity"
                                        value={quantity}
                                        onChange={(e) => setQuantity(Math.min(999, Number(e.target.value)))}
                                    />
                                    <svg className="quantity-subtract-icon" onClick={subtractOne} xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" height="24px" width="24px" fill="#e3e3e3"><path d="M7,13H17V11H7v2Zm5,9q-2.07,0-3.9-0.79q-1.82-0.79-3.17-2.14Q3.58,17.73 2.79,15.9T2,12Q2,9.92 2.79,8.1Q3.58,6.27 4.93,4.93Q6.28,3.57 8.1,2.79Q9.93,2 12,2t3.9,0.79t3.17,2.14q1.35,1.35 2.14,3.17Q22,9.92 22,12t-0.79,3.9t-2.14,3.17q-1.35,1.35-3.17,2.14T12,22Zm0-2q3.35,0 5.68-2.32T20,12T17.68,6.32T12,4T6.33,6.32T4,12t2.33,5.68T12,20Zm0-8Z"/></svg>
                                    <svg className="quantity-add-icon" onClick={addOne} xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#e3e3e3"><path d="M440-280h80v-160h160v-80H520v-160h-80v160H280v80h160v160Zm40 200q-83 0-156-31.5T197-197q-54-54-85.5-127T80-480q0-83 31.5-156T197-763q54-54 127-85.5T480-880q83 0 156 31.5T763-763q54 54 85.5 127T880-480q0 83-31.5 156T763-197q-54 54-127 85.5T480-80Zm0-80q134 0 227-93t93-227q0-134-93-227t-227-93q-134 0-227 93t-93 227q0 134 93 227t227 93Zm0-320Z"/></svg>
                                </div>
                            </div>
                        </div>

                        <button className="add-fish-btn" onClick={addFish}>Add Fish</button>
                    </div>

                    {/* Your fish */}
                    <div className="current-fish-selection-section">
                        <div className="fish-list-header">
                            <h3 className="current-fish-selection-section-title">Your Fish:</h3>
                            <span className="fish-count">{totalFish} fish</span>
                        </div>

                       {selectedFishList.length === 0 && (
                            <div className="fish-list-empty">
                                <h4 className="fish-list-empty-text">No fish yet</h4>
                                <p className="fish-list-empty-hint">Search for a fish above and click Add Fish.</p>
                            </div>
                        )}

                        <div className="fish-list">
                            {selectedFishList.map((fish) => (
                                <div className="fish-item" key={fish.id}>
                                    <div className="fish-info-stats-wrapper">
                                        <div className="fish-info">

                                            {/* Card top: quantity, name, skill badge + trash can */}
                                            <div className="fish-header">
                                                <div className="fish-name-group">

                                                    <div className="fish-quantity-modifier">
                                                        <svg className="quantity-subtract-icon" onClick={() => subtractOneFromFish(fish.id)} xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" height="20px" width="20px" fill="#e3e3e3"><path d="M7,13H17V11H7v2Zm5,9q-2.07,0-3.9-0.79q-1.82-0.79-3.17-2.14Q3.58,17.73 2.79,15.9T2,12Q2,9.92 2.79,8.1Q3.58,6.27 4.93,4.93Q6.28,3.57 8.1,2.79Q9.93,2 12,2t3.9,0.79t3.17,2.14q1.35,1.35 2.14,3.17Q22,9.92 22,12t-0.79,3.9t-2.14,3.17q-1.35,1.35-3.17,2.14T12,22Zm0-2q3.35,0 5.68-2.32T20,12T17.68,6.32T12,4T6.33,6.32T4,12t2.33,5.68T12,20Zm0-8Z"/></svg>
                                                        <input
                                                            className="fish-quantity-input"
                                                            type="number"
                                                            min="1"
                                                            value={fish.quantity}
                                                            onChange={(e) => setFishQuantity(fish.id, Math.min(999, Number(e.target.value)))}
                                                        />
                                                        <svg className="quantity-add-icon" onClick={() => addOneToFish(fish.id)} xmlns="http://www.w3.org/2000/svg" height="20px" viewBox="0 -960 960 960" width="20px" fill="#e3e3e3"><path d="M440-280h80v-160h160v-80H520v-160h-80v160H280v80h160v160Zm40 200q-83 0-156-31.5T197-197q-54-54-85.5-127T80-480q0-83 31.5-156T197-763q54-54 127-85.5T480-880q83 0 156 31.5T763-763q54 54 85.5 127T880-480q0 83-31.5 156T763-197q-54 54-127 85.5T480-80Zm0-80q134 0 227-93t93-227q0-134-93-227t-227-93q-134 0-227 93t-93 227q0 134 93 227t227 93Zm0-320Z"/></svg>
                                                    </div>

                                                    <h4>{fish.name}</h4>

                                                    <div className={`skill-level skill-${fish.skill_level.toLowerCase()}`}>
                                                        <h4>{fish.skill_level}</h4>
                                                        <svg xmlns="http://www.w3.org/2000/svg" height="18px" viewBox="0 -960 960 960" width="18px" fill="#e3e3e3"><path d="M440-280h80v-240h-80v240Zm68.5-331.5Q520-623 520-640t-11.5-28.5Q497-680 480-680t-28.5 11.5Q440-657 440-640t11.5 28.5Q463-600 480-600t28.5-11.5ZM480-80q-83 0-156-31.5T197-197q-54-54-85.5-127T80-480q0-83 31.5-156T197-763q54-54 127-85.5T480-880q83 0 156 31.5T763-763q54 54 85.5 127T880-480q0 83-31.5 156T763-197q-54 54-127 85.5T480-80Zm0-80q134 0 227-93t93-227q0-134-93-227t-227-93q-134 0-227 93t-93 227q0 134 93 227t227 93Zm0-320Z"/></svg>
                                                    </div>

                                                </div>

                                                <div className="remove-fish-icon-container" onClick={() => removeFish(fish.id)}>
                                                    <svg className="remove-fish-icon" xmlns="http://www.w3.org/2000/svg" height="20px" viewBox="0 -960 960 960" width="20px" fill="#e3e3e3"><path d="M280-120q-33 0-56.5-23.5T200-200v-520h-40v-80h200v-40h240v40h200v80h-40v520q0 33-23.5 56.5T680-120H280Zm400-600H280v520h400v-520ZM360-280h80v-360h-80v360Zm160 0h80v-360h-80v360ZM280-720v520-520Z"/></svg>
                                                </div>
                                            </div>

                                            {/* Card bottom: stat pills */}
                                            <div className="fish-stats">
                                                <span className="fish-stat">
                                                    <svg className="fish-stat-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" height="16px" width="16px" fill="#e3e3e3"><path d="M4,18q-0.82,0-1.41-0.59T2,16V8Q2,7.18 2.59,6.59T4,6H20q0.83,0 1.41,0.59Q22,7.18 22,8v8q0,0.82-0.59,1.41T20,18H4Zm0-2H20V8H17v4H15V8H13v4H11V8H9v4H7V8H4v8Zm3-4H9H7Zm4,0h2H11Zm4,0h2H15Zm-3,0Z"/></svg>
                                                    <span className="fish-stat-label">Adult Size:</span>
                                                    <span className="fish-stat-value">{fish.adult_size_inches} in.</span>
                                                </span>

                                                <span className="fish-stat">
                                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" height="16px" width="16px" fill="#e3e3e3"><path d="M8.46,20.54Q7,19.08 7,17q0-1.2 0.53-2.24T9,13V5Q9,3.75 9.88,2.88T12,2t2.13,0.88T15,5v8q0.95,0.72 1.48,1.76T17,17q0,2.07-1.46,3.54T12,22q-2.07,0-3.54-1.46ZM11,11h2V10H12V9h1V7H12V6h1V5q0-0.43-0.29-0.71T12,4T11.29,4.29T11,5v6Z"/></svg>
                                                    <span className="fish-stat-label">Temperature:</span>
                                                    <span className="fish-stat-value">{fish.min_temp}-{fish.max_temp}°F</span>
                                                </span>

                                                <span className="fish-stat">
                                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" height="16px" width="16px" fill="#e3e3e3"><path d="M9,21.95Q5.95,21.6 3.98,19.33T2,13.8q0-2.5 1.99-5.44Q5.98,5.43 10,2q4.03,3.43 6.01,6.36T18,13.8q0,0.05 0,0.1T18,14H16q0-0.05 0-0.1t0-0.1q0-1.82-1.51-4.13Q12.98,7.38 10,4.65Q7.03,7.38 5.51,9.67Q4,11.98 4,13.8q0,2.43 1.4,4.1Q6.8,19.58 9,19.93v2.02Zm1-9.68ZM11,22V16h3.5q0.6,0 1.05,0.45T16,17.5v1q0,0.6-0.45,1.05T14.5,20h-2v2H11Zm6,0V16h1.5v2h2V16H22v6H20.5V19.5h-2V22H17Zm-4.5-3.5h2v-1h-2v1Z"/></svg>
                                                    <span className="fish-stat-label">pH:</span>
                                                    <span className="fish-stat-value">{fish.min_ph}-{fish.max_ph}</span>
                                                </span>

                                                <span className="fish-stat">
                                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" height="16px" width="16px" fill="#e3e3e3"><path d="M15.5,11q0.63,0 1.06-0.44T17,9.5T16.56,8.44T15.5,8T14.44,8.44T14,9.5t0.44,1.06T15.5,11Zm-7,0q0.63,0 1.06-0.44T10,9.5T9.56,8.44T8.5,8T7.44,8.44T7,9.5t0.44,1.06T8.5,11Zm6.59,5.54Q16.48,15.58 17.1,14H6.9q0.63,1.57 2.01,2.54T12,17.5t3.09-0.96ZM12,22q-2.07,0-3.9-0.79q-1.82-0.79-3.17-2.14Q3.58,17.73 2.79,15.9T2,12Q2,9.92 2.79,8.1Q3.58,6.27 4.93,4.93Q6.28,3.57 8.1,2.79Q9.93,2 12,2q0.25,0 0.49,0.01t0.49,0.04q-0.15,0.5-0.21,0.99T12.73,4.02Q12.53,4 12.36,4T12,4Q8.68,4 6.34,6.34T4,12t2.34,5.66T12,20t5.66-2.34T20,12q0-0.53-0.07-1.04t-0.2-1.01q0.5-0.07 0.99-0.22t0.94-0.38q0.18,0.65 0.26,1.3T22,12q0,2.07-0.79,3.9t-2.14,3.17q-1.35,1.35-3.17,2.14T12,22Zm0-10Zm6.9-4L15.4,4.5q-0.32-0.33-0.46-0.7T14.8,3.05q0-0.8 0.57-1.42T16.85,1q0.7,0 1.1,0.32T18.9,2.2q0.5-0.5 0.91-0.85Q20.23,1 20.95,1q0.92,0 1.49,0.64T23,3.07q0,0.38-0.15,0.75T22.4,4.5L18.9,8Z"/></svg>
                                                    <span className="fish-stat-label">Temperament:</span>
                                                    <span className="fish-stat-value">{fish.temperament}</span>
                                                </span>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            ))}
                        </div>
                    </div>

                </div>

                {/* ============ RIGHT PANEL: results ============ */}
                <div className="results-panel">

                    {/* Stocking level + warnings + tank summary */}
                    <div className="stocking-section">
                        <div className="stocking-header">
                            <h3 className="stocking-section-title">Stocking Level:</h3>
                            <div className="stocking-value-container">
                                <span className="stocking-value shimmer-wave shimmer-wave-text shimmer-moderate">{Math.round(stockingPercentage)}%</span>
                            </div>
                        </div>

                        {/* Warnings (pink) and tips (gold) */}
                        <div className="stocking-level-message-container">
                            <div className="warnings">
                                {warnings.map((warning) => (
                                    <div className="warning-row" key={warning.text}>
                                        {warning.isWarning ? (
                                            <svg className="warning-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" height="24px" width="24px" fill="#e3e3e3"><path d="M1,21L12,2L23,21H1Zm3.45-2h15.1L12,6L4.45,19Zm8.26-1.29Q13,17.43 13,17t-0.29-0.71T12,16t-0.71,0.29T11,17t0.29,0.71T12,18t0.71-0.29ZM11,15h2V10H11v5Zm1-2.5Z"/></svg>
                                        ) : (
                                            <svg className="non-warning-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" height="24px" width="24px" fill="#e3e3e3"><path d="M10,18q-0.82,0-1.41-0.59T8,16V14.75q-1.42-0.98-2.21-2.5T5,9Q5,6.07 7.04,4.04T12,2t4.96,2.04T19,9q0,1.72-0.79,3.24T16,14.75V16q0,0.82-0.59,1.41T14,18H10Zm0-2h4V13.7l0.85-0.6q1.02-0.7 1.59-1.79T17,9q0-2.07-1.46-3.54T12,4Q9.93,4 8.46,5.46Q7,6.93 7,9q0,1.22 0.56,2.31T9.15,13.1L10,13.7V16Zm0,6q-0.42,0-0.71-0.29Q9,21.43 9,21V20h6v1q0,0.43-0.29,0.71T14,22H10ZM12,9Z"/></svg>
                                        )}
                                        <h4 className={warning.isWarning ? 'stocking-level-message' : 'stocking-level-message good-message'}>
                                            {warning.text}
                                        </h4>
                                    </div>
                                ))}
                            </div>
                        </div>

                        {/* Tank summary: temp, pH, water change */}
                        
                        <div className="your-fish-results">
                            {selectedFishList.length > 0 && (
                                <div className="temp-range-container">
                                    {selectedFishList.length > 0 && (
                                        <h4 className="temp-range-result">
                                            Recommended temperature:{' '}
                                            {tempRange.low > tempRange.high
                                                ? <span className="incompatible">incompatible</span>
                                                : <span className="temp-range">{tempRange.low}-{tempRange.high}°F</span>}
                                        </h4>
                                    )}
                                </div>
                            )}

                            {selectedFishList.length > 0 && (
                                <div className="ph-range-container">
                                    {selectedFishList.length > 0 && (
                                        <h4 className="ph-range-result">
                                            Recommended pH:{' '}
                                            {phRange.low > phRange.high
                                                ? <span className="incompatible">incompatible</span>
                                                : <span className="ph-range">{phRange.low}-{phRange.high}</span>}
                                        </h4>
                                    )}
                                </div>
                            )}

                            {selectedFishList.length > 0 && selectedTank && (
                                <div className="water-change-suggestion-container">
                                    {selectedFishList.length > 0 && (
                                        <h4 className="water-change-suggestion-result">Suggested water change schedule: <span className="water-change">{waterChange}</span></h4>
                                    )}
                                </div>
                            )}
                        </div>
                    </div>

                    {/* Compatibility */}
                    <div className="compatibility-section">
                        <div className="compatibility-header">
                            <h3 className="compatibility-section-title">Compatibility Score: </h3>
                            <div className="compatibility-value-container">
                                <span className="compatibility-value shimmer-wave shimmer-wave-text">85%</span>
                            </div>
                        </div>
                        {/* TODO: Gemini will suggest changes to the user's stocking here */}
                        <button className="stocking-advice-btn">Get Stocking Advice</button>
                    </div>

                </div>

            </div>
        </div>
    )
}
