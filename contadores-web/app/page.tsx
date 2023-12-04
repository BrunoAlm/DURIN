'use client';
import React, { useState } from 'react';
import ProgressUpdater from './ProgressUpdater';
export default function Home() {
  const [showProgress, setShowProgress] = useState(false);

  const handleUpdateCounters = () => {
    setShowProgress(true);
  };

  return (
    <main className="min-h-screen p-24">
      <h1 className="text-2xl p-24">Contadores Durín</h1>

      {/* Botão para atualizar contadores */}
      <button onClick={handleUpdateCounters} className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
        Atualizar contadores
      </button>

      {/* Exibe o componente de progresso quando o botão é clicado */}
      {showProgress && <ProgressUpdater />}
    </main>
  );
}
