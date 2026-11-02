import './aquarium-editor.css';
import React, { useState, useEffect } from 'react';

const tankSizes = [
  { id: "10g", label: "10 Gallon", gallons: 10 },
  { id: "20g", label: "20 Gallon", gallons: 20 },
  { id: "55g", label: "55 Gallon", gallons: 55 },
];

const fishData = [
    { id: "betta", name: "Betta" },
    { id: "guppy", name: "Guppy" },
    { id: "corydoras", name: "Corydoras Catfish" },
];

const vegetationOptions = [
    {id: "none", label: "No Plants"},
    {id: "light", label: "Lightly Planted"},
    {id: "moderate", label: "Moderately Planted"},
    {id: "heavy", label: "Heavily Planted"}
]

type Fish = {
    id: number
    name: string
    scientific_name: string
    skill_level: string
}

type SelectedFish = {
  id: string
  name: string
  quantity: number
  skill_level: string
}

type Tank = {
    id: number
    label: string
    gallons: number
}

export default function AquariumEditor() {
    const [tankSize, setTankSize] = useState("");
    const [fishName, setFishName] = useState("");
    const [quantity, setQuantity] = useState(1)
    const [vegetationLevel, setVegetationLevel] = useState("")
    const [fishList, setFishList] = useState<Fish[]>([])
    const [tankSizesList, setTankSizesList] = useState<Tank[]>([]);
    const [selectedFishList, setSelectedFishList] = useState<SelectedFish[]>([]);
    

    useEffect(() => {
        fetch("http://127.0.0.1:8000/species")
            .then((res) => res.json())
            .then((data) => setFishList(data))
        fetch("http://127.0.0.1:8000/tank_sizes")
            .then((res) => res.json())
            .then((data) => setTankSizesList(data))
    }, [])

    

    function addOne(){
        setQuantity((prev) => prev + 1)
    }

    function subtractOne(){
        if(quantity > 1){
            setQuantity((prev) => prev - 1)
        }
    }

    function addFish(){
        const alreadyAdded = selectedFishList.some((fish) => fish.name === fishName)
        const matchedFish = fishList.find((fish) => fishName === `${fish.name} (${fish.scientific_name})`)

        if (matchedFish && !alreadyAdded) {
            setSelectedFishList((prev) => [...prev, {
            id: crypto.randomUUID(),
            name: fishName,
            quantity: quantity,
            skill_level: matchedFish.skill_level
        }]);
        }
        if (alreadyAdded) {
            setSelectedFishList((prev) => prev.map((fish) => {
                if (fish.name === fishName) {
                    return { ...fish, quantity: fish.quantity + quantity }
                }
                return fish
            }))
        }
        setFishName('');
        setQuantity(1);
    }

    function removeFish(id: string){
        setSelectedFishList((prev) => prev.filter((fish) => fish.id != id))
    }

  return (
    
    <div className="editor-page">

        {/* User aquarium preview section */}
        <div className="editor-column">

            <div className="editor-actions">
                <button className="cancel-btn">Cancel <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#e3e3e3"><path d="m336-280 144-144 144 144 56-56-144-144 144-144-56-56-144 144-144-144-56 56 144 144-144 144 56 56ZM480-80q-83 0-156-31.5T197-197q-54-54-85.5-127T80-480q0-83 31.5-156T197-763q54-54 127-85.5T480-880q83 0 156 31.5T763-763q54 54 85.5 127T880-480q0 83-31.5 156T763-197q-54 54-127 85.5T480-80Zm0-80q134 0 227-93t93-227q0-134-93-227t-227-93q-134 0-227 93t-93 227q0 134 93 227t227 93Zm0-320Z"/></svg></button>
                <button className="tank-name-btn">New Aquarium <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#e3e3e3"><path d="M200-200h57l391-391-57-57-391 391v57Zm-80 80v-170l528-527q12-11 26.5-17t30.5-6q16 0 31 6t26 18l55 56q12 11 17.5 26t5.5 30q0 16-5.5 30.5T817-647L290-120H120Zm640-584-56-56 56 56Zm-141 85-28-29 57 57-29-28Z"/></svg></button>
                <button className="save-btn">Save <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#e3e3e3"><path d="M840-680v480q0 33-23.5 56.5T760-120H200q-33 0-56.5-23.5T120-200v-560q0-33 23.5-56.5T200-840h480l160 160Zm-80 34L646-760H200v560h560v-446ZM565-275q35-35 35-85t-35-85q-35-35-85-35t-85 35q-35 35-35 85t35 85q35 35 85 35t85-35ZM240-560h360v-160H240v160Zm-40-86v446-560 114Z"/></svg></button>
            </div>

            <div className="tank-preview">
                {/* <div className="tank-name-btn">
                    <h2 className="tank-name">New Aquarium <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#e3e3e3"><path d="M200-200h57l391-391-57-57-391 391v57Zm-80 80v-170l528-527q12-11 26.5-17t30.5-6q16 0 31 6t26 18l55 56q12 11 17.5 26t5.5 30q0 16-5.5 30.5T817-647L290-120H120Zm640-584-56-56 56 56Zm-141 85-28-29 57 57-29-28Z"/></svg></h2>
                </div> */}
            </div>

        </div>

        <div className="editor-panels">
            {/* Left panel where users can input aquarium details */}
            <div className="inputs-panel">

                <div className="tank-size-section">
                    <h3 className='tank-size-section-title'>Select Aquarium Size</h3>
                    {/* tank-size search */}
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
                
                
                <div className='add-fish-main-section'>
                    <div className="fish-species-section">
                        <h3 className='fish-species-section-title'>Select Fish</h3>
                        {/* fish search */}
                        <input
                            id="fish-input"
                            list="fish-list"
                            value={fishName}
                            onChange={(e) => setFishName(e.target.value)}
                            placeholder="Search Fish"
                        />
                        <datalist id="fish-list">
                            {fishList.map((fish) => (
                                <option key={fish.id} value={`${fish.name} (${fish.scientific_name})`}/>
                            ))}
                        </datalist>
                    </div>
                    <div className='fish-quantity-section'>
                    
                        <h3 className='fish-quantity-section-title'>Choose Quantity</h3>
                        <div className="quantity-field">
                            <div className='quantity-row'>
                                <input
                                    id="quantity"
                                    value={quantity}
                                    readOnly
                                />
                                <svg className="quantity-subtract-icon" onClick={subtractOne} xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" height="24px" width="24px" fill="#e3e3e3"><path d="M7,13H17V11H7v2Zm5,9q-2.07,0-3.9-0.79q-1.82-0.79-3.17-2.14Q3.58,17.73 2.79,15.9T2,12Q2,9.92 2.79,8.1Q3.58,6.27 4.93,4.93Q6.28,3.57 8.1,2.79Q9.93,2 12,2t3.9,0.79t3.17,2.14q1.35,1.35 2.14,3.17Q22,9.92 22,12t-0.79,3.9t-2.14,3.17q-1.35,1.35-3.17,2.14T12,22Zm0-2q3.35,0 5.68-2.32T20,12T17.68,6.32T12,4T6.33,6.32T4,12t2.33,5.68T12,20Zm0-8Z"/></svg>
                                <svg className="quantity-add-icon" onClick={addOne} xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#e3e3e3"><path d="M440-280h80v-160h160v-80H520v-160h-80v160H280v80h160v160Zm40 200q-83 0-156-31.5T197-197q-54-54-85.5-127T80-480q0-83 31.5-156T197-763q54-54 127-85.5T480-880q83 0 156 31.5T763-763q54 54 85.5 127T880-480q0 83-31.5 156T763-197q-54 54-127 85.5T480-80Zm0-80q134 0 227-93t93-227q0-134-93-227t-227-93q-134 0-227 93t-93 227q0 134 93 227t227 93Zm0-320Z"/></svg>
                            </div>
                        </div>
                    </div>

                    <button className='add-fish-btn' onClick={addFish}>Add Fish</button>
                </div>

                <div className="vegetation-section">
                    <h3 className='vegetation-section-title'>Select Vegetation Level</h3>

                    <div className='vegetation-level-options'>
                    {vegetationOptions.map((option) => (
                        <button
                        key={option.id}
                        className={vegetationLevel === option.id ? "vegetation-btn selected" : "vegetation-btn"}
                        onClick={() => setVegetationLevel(option.id)}
                        >
                        <span className='shimmer-wave shimmer-wave-text'>{option.label}</span>
                        </button>
                    ))}
                    </div>

                </div>

            </div>

            {/* Right panel: results */}
            <div className="results-panel">

                <div className="stocking-section">
                    <div className="stocking-header">
                        <h3 className='stocking-section-title'>Stocking Level: </h3> {/* {stockingLevel} */}
                        <div className='stocking-value-container'>
                            <span className="stocking-value shimmer-wave shimmer-wave-text shimmer-moderate">67%</span>
                        </div>
                    </div>
                    {/* here is where stocking level errors are going to pop-up */}
                    <div className='stocking-level-message-container'>
                        <h4 className='stocking-level-message'>Warning: stocking level too high!</h4>
                    </div>
                </div>

                <div className="compatibility-section">
                    <div className="compatibility-header">
                        <h3 className='compatibility-section-title'>Compatibility Score: </h3>
                        <div className='compatibility-value-container'>
                            <span className="compatibility-value shimmer-wave shimmer-wave-text">85%</span>
                        </div>
                    </div>
                    {/* here is where gemini will suggest modifications to the users stocking choices */}
                    <button className='stocking-advice-btn'>Get Stocking Advice</button>
                </div>

                <div className='current-fish-selection-section'>
                    <h3 className='current-fish-selection-section-title'>Your Fish:</h3>
                    <div className="fish-list">
                        {selectedFishList.map((fish) => (
                            <div className="fish-item" key={fish.id}>
                                <div className='remove-fish-icon-container'>
                                    <svg className="remove-fish-icon" onClick={() => removeFish(fish.id)} xmlns="http://www.w3.org/2000/svg" height="20px" viewBox="0 -960 960 960" width="20px" fill="#e3e3e3"><path d="M280-120q-33 0-56.5-23.5T200-200v-520h-40v-80h200v-40h240v40h200v80h-40v520q0 33-23.5 56.5T680-120H280Zm400-600H280v520h400v-520ZM360-280h80v-360h-80v360Zm160 0h80v-360h-80v360ZM280-720v520-520Z"/></svg>
                                </div>
                                <h4>{fish.quantity}x {fish.name}</h4> 
                                <div className={`skill-level skill-${fish.skill_level.toLowerCase()}`}>
                                    <h4>{fish.skill_level}</h4>
                                    <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#e3e3e3"><path d="M440-280h80v-240h-80v240Zm68.5-331.5Q520-623 520-640t-11.5-28.5Q497-680 480-680t-28.5 11.5Q440-657 440-640t11.5 28.5Q463-600 480-600t28.5-11.5ZM480-80q-83 0-156-31.5T197-197q-54-54-85.5-127T80-480q0-83 31.5-156T197-763q54-54 127-85.5T480-880q83 0 156 31.5T763-763q54 54 85.5 127T880-480q0 83-31.5 156T763-197q-54 54-127 85.5T480-80Zm0-80q134 0 227-93t93-227q0-134-93-227t-227-93q-134 0-227 93t-93 227q0 134 93 227t227 93Zm0-320Z"/></svg>
                                </div>
                            </div>
                        ))}
                        
                            
                    </div>
                        
                </div>

    
                    
                {/* <pre>{JSON.stringify(selectedFishList, null, 2)}</pre> */}

            </div>
                        
        </div>
    </div>
    
  );
}