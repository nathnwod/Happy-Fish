import './aquarium-editor.css';
import React, { useState } from 'react';

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

export default function AquariumEditor() {
    const [tankSize, setTankSize] = useState("");
    const [fishName, setFishName] = useState("");
    const [quantity, setQuantity] = useState(1);

  return (
    <div className="aquarium-editor-page-wrapper">

        {/* User aquarium preview section */}
        <div className="aquarium-editor-main-wrapper">

            <div className="cancel-save-btn-wrapper">
                <button className="cancel-creation-btn ">Cancel <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#e3e3e3"><path d="m336-280 144-144 144 144 56-56-144-144 144-144-56-56-144 144-144-144-56 56 144 144-144 144 56 56ZM480-80q-83 0-156-31.5T197-197q-54-54-85.5-127T80-480q0-83 31.5-156T197-763q54-54 127-85.5T480-880q83 0 156 31.5T763-763q54 54 85.5 127T880-480q0 83-31.5 156T763-197q-54 54-127 85.5T480-80Zm0-80q134 0 227-93t93-227q0-134-93-227t-227-93q-134 0-227 93t-93 227q0 134 93 227t227 93Zm0-320Z"/></svg></button>
                <button className="save-creation-btn">Save <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#e3e3e3"><path d="M840-680v480q0 33-23.5 56.5T760-120H200q-33 0-56.5-23.5T120-200v-560q0-33 23.5-56.5T200-840h480l160 160Zm-80 34L646-760H200v560h560v-446ZM565-275q35-35 35-85t-35-85q-35-35-85-35t-85 35q-35 35-35 85t35 85q35 35 85 35t85-35ZM240-560h360v-160H240v160Zm-40-86v446-560 114Z"/></svg></button>
            </div>

            <div className="aquarium-editor-container">
                <div className="aquarium-title-container">
                    <h2 className="aquarium-title">New Aquarium <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#e3e3e3"><path d="M200-200h57l391-391-57-57-391 391v57Zm-80 80v-170l528-527q12-11 26.5-17t30.5-6q16 0 31 6t26 18l55 56q12 11 17.5 26t5.5 30q0 16-5.5 30.5T817-647L290-120H120Zm640-584-56-56 56 56Zm-141 85-28-29 57 57-29-28Z"/></svg></h2>
                </div>
            </div>
            
        </div>

        {/* Left section where users can input aquarium details */}
        <div className="aquarium-inputs-wrapper">

            <div className="aquarium-size-selector-container">
                <h3>Select Aquarium Size</h3>

                {/* tank-size search */}
                {/* <label htmlFor="tank-size-input">Select Aquarium Size</label> */}
                <input
                    id="tank-size-input"
                    list="tank-size-list"
                    value={tankSize}
                    onChange={(e) => setTankSize(e.target.value)}
                    placeholder="Search Sizes" 
                />
                <datalist id="tank-size-list">
                    {tankSizes.map((tankSize) => (
                        <option key={tankSize.id} value={tankSize.label} />
                    ))}
                </datalist>
            </div>

            <div className="fish-selector-container">
                <h3>Select Fish</h3>

                {/* fish search */}
                {/* <label htmlFor="tank-size-input">Select Aquarium Size</label> */}
                <input
                    id="fish-input"
                    list="fish-list"
                    value={fishName}
                    onChange={(e) => setFishName(e.target.value)}
                    placeholder="Search Fish" 
                />
                <datalist id="fish-list">
                    {fishData.map((fish) => (
                        <option key={fish.id} value={fish.name} />
                    ))}
                </datalist>
                
                <h3>Choose Quanitity</h3>
                <div className="qty-selector-container">
                    <input
                    id="quantity"
                    type="number"
                    inputMode="numeric"
                    min={1}
                    step={1}
                    value={quantity}
                    onChange={(e) => {
                        const v = e.target.value;
                        setQuantity(v === "" ? "" : Math.max(1, parseInt(v, 10) || 1));
                    }}
                    placeholder="Qty"
                    />

                </div>
                    <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#e3e3e3"><path d="M440-280h80v-160h160v-80H520v-160h-80v160H280v80h160v160Zm40 200q-83 0-156-31.5T197-197q-54-54-85.5-127T80-480q0-83 31.5-156T197-763q54-54 127-85.5T480-880q83 0 156 31.5T763-763q54 54 85.5 127T880-480q0 83-31.5 156T763-197q-54 54-127 85.5T480-80Zm0-80q134 0 227-93t93-227q0-134-93-227t-227-93q-134 0-227 93t-93 227q0 134 93 227t227 93Zm0-320Z"/></svg>
            
            </div>

            <div className="vegetation-level-selector-container">
                <h3>Select Vegetation Level</h3>
                <button className="vegetation-select-btn shimmer-wave shimmer-wave-text">Lightly Planted</button>
                <button className="vegetation-select-btn shimmer-wave shimmer-wave-text">Moderately Planted</button>
                <button className="vegetation-select-btn shimmer-wave shimmer-wave-text">Heavily Planted</button>
            </div>

        </div>

        <div className="aquarium-results-wrapper">

            <div className="stocking-level-container">
                <div className="stocking-level-wrapper">
                    <h3>Stocking Level: </h3> {/* {stockingLevel} */}
                    <div className="stocking-level-container shimmer-wave shimmer-wave-text">67%</div>
                </div>
                {/* here is where stocking level errors are going to pop-up */}
                <h4>Warning: stocking level too high!</h4>
            </div>

            <div className="compatability-score-container">
                <div className="compatability-score-wrapper">
                    <h3>Compatability Score: </h3> {/* {compatabilityScore} */}
                    <div className="compatability-score-container shimmer-wave shimmer-wave-text">85%</div>
                </div>
                {/* here is where gemini will suggest modifications to the users stocking choices */}
                <button>Get Stocking Advice</button>
            </div>

            <h3>Your Fish:</h3>
            <div className="fish-container">
                <div className="fish-info-wrapper">

                    <h4>3x Neon Tetra (Paracheirodon innesi)</h4>
                    <div className="skill-level-container">
                        <h4>Beginner</h4>
                        <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#e3e3e3"><path d="M440-280h80v-240h-80v240Zm68.5-331.5Q520-623 520-640t-11.5-28.5Q497-680 480-680t-28.5 11.5Q440-657 440-640t11.5 28.5Q463-600 480-600t28.5-11.5ZM480-80q-83 0-156-31.5T197-197q-54-54-85.5-127T80-480q0-83 31.5-156T197-763q54-54 127-85.5T480-880q83 0 156 31.5T763-763q54 54 85.5 127T880-480q0 83-31.5 156T763-197q-54 54-127 85.5T480-80Zm0-80q134 0 227-93t93-227q0-134-93-227t-227-93q-134 0-227 93t-93 227q0 134 93 227t227 93Zm0-320Z"/></svg>
                    </div>
                    
                 </div>
            </div>

        </div>
    </div>
  );
}
