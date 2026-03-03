import { useState } from "react";
import { useNavigate } from "react-router-dom";
import './aquariums.css';

export default function Aquariums() {
  const [tanks, setTanks] = useState([
    { id: crypto.randomUUID(), name: "Create New Tank" },
  ]);
  const navigate = useNavigate();

  function createTank(name) {
    setTanks((prev) => [...prev, {
      id: crypto.randomUUID(),
      name: name,
    }]);
  }

  function deleteTank(id) {
    setTanks((prev) => prev.filter((tank) => tank.id !== id));
  }

  return (
    <div className="aquariums-page">
      <div className="aquariums-container">
        <div className="aquariums-grid">
          {tanks.map((tank) => (
            <div key={tank.id} className="aquarium-card">
              <button className="add-tank-button" onClick={() => navigate("/aquarium-editor")}><svg xmlns="http://www.w3.org/2000/svg" height="75px" viewBox="0 -960 960 960" width="75px" fill="#e3e3e3"><path d="M440-440H200v-80h240v-240h80v240h240v80H520v240h-80v-240Z"/></svg></button>
              <h2>{tank.name}</h2>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
