import logo from './logo.svg';
import './App.css';

import React from 'react';
import { Canvas, Label } from 'reaflow';

const nodes = [
  {
    id: '1',
    text: '1'
  },
  {
    id: '2',
    text: '2',

  }
];

const edges = [
  {
    id: '1-2',
    from: '1',
    to: '2',
    text:'auaicn',
  }
];


export const MyDiagram = () => (
  <Canvas
    maxWidth={800}
    maxHeight={600}
    direction="RIGHT"
    nodes={nodes}
    edges={edges}
  />
);

function App() {


  return MyDiagram();
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  );
}

export default App;


