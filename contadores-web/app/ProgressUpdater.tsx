import React, { useState, useEffect } from 'react';
import io from 'socket.io-client';

const ProgressUpdater = () => {
  const [progress, setProgress] = useState(0);

  useEffect(() => {
    const socket = io('http://localhost:5000'); // Altere para o seu endereço de servidor Flask

    socket.on('progresso_atualizacao', ({ progresso }) => {
      setProgress(progresso);
    });

    socket.emit('atualizar_contadores');

    return () => {
      socket.disconnect();
    };
  }, []);

  return (
    <div>
      <p>Progresso: {progress}%</p>
    </div>
  );
};

export default ProgressUpdater;
