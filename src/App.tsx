import { useState } from 'react'
import { Routes, Route, Navigate } from "react-router-dom";
import './App.css'
import NavBar  from './nav-bar/nav-bar'
import Aquariums from './pages/aquariums'
import AquariumEditor from './pages/AquariumEditor/aquarium-editor';

function App() {

  return (
    <>
      <NavBar />

      <Routes>
          <Route path="/" element={<Navigate to="/home" replace />} />

        <Route path="/home" element={<Aquariums />} />
        <Route path="/aquarium-editor" element={<AquariumEditor />} />
      </Routes>

    </>
    
  )
}

export default App
