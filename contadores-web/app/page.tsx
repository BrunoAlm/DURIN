'use client';
import React, { useState, useEffect } from 'react';
import io from 'socket.io-client';

const ProgressUpdater = () => {
  const [progress, setProgress] = useState(0);

  useEffect(() => {
    const socket = io('http://localhost:5000');

    socket.on('progresso_atualizacao', ({ progresso }) => {
      setProgress(progresso);

      if (progresso === 100) {
        setTimeout(() => {
          setProgress(0);
          window.dispatchEvent(new CustomEvent('progress-finished'));
        }, 2000);
      }
    });

    socket.emit('atualizar_contadores');

    return () => {
      socket.disconnect();
    };
  }, []);

  return (
    <div className="m-4">
      <p className='text-center'>Progresso: {progress}%</p>
    </div>
  );
};

interface Contador {
  id: number;
  contador_atual: number;
  data_registro: string;
  // Adicione outras propriedades conforme necessário
}

interface Impressora {
  id: number;
  nome: string;
  ip: string;
  contadores: Contador[]; // Agora definida como um array de Contador
  // Adicione outras propriedades conforme necessário
}

export default function Home() {
  const [showProgress, setShowProgress] = useState(false);
  const [impressorasData, setImpressorasData] = useState<Impressora[]>([]);

  const handleUpdateCounters = () => {
    setShowProgress(true);
  };

  useEffect(() => {
    const hideProgress = () => {
      setShowProgress(false);
    };

    window.addEventListener('progress-finished', hideProgress);

    return () => {
      window.removeEventListener('progress-finished', hideProgress);
    };
  }, []);

  useEffect(() => {
    fetch('http://localhost:5000/api/impressoras')
      .then((response) => response.json())
      .then((data) => {
        setImpressorasData(data);
      })
      .catch((error) => {
        console.error('Erro ao buscar dados:', error);
      });
  }, []);

  const formatDate = (dateString: string) => {
    const date = new Date(dateString);
    const formattedDate = `${date.getDate()}/${date.getMonth() + 1}/${date.getFullYear()} ${date.getHours()}:${date.getMinutes()}`;
    return formattedDate;
  };

  return (
    <main className="min-h-screen p-6 bg-slate-50">
      <h1 className="text-4xl pb-6 font-bold">Contadores Durín</h1>

      <button onClick={handleUpdateCounters} className="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded mb-4">
        Atualizar contadores
      </button>

      {showProgress && <ProgressUpdater />}

      
      {/* Exibir os dados das impressoras */}
      <div className="impressoras-data grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
        {impressorasData.map((impressora) => (
          <div key={impressora.id} className="bg-white shadow-md p-4 rounded-md">
            <h2 className="text-lg font-semibold">{impressora.nome}</h2>
            <p className="text-gray-500">{impressora.ip}</p>
            <h3 className="text-md font-semibold mt-3">Contadores:</h3>
            <ul>
              <li>
                <div>
                  {impressora.contadores && impressora.contadores.length > 0 ? (
                    <div>
                      <p>Atual: {impressora.contadores[impressora.contadores.length - 1].contador_atual}</p>
                      {impressora.contadores.length > 1 && (
                        <p>Anterior: {impressora.contadores[impressora.contadores.length - 2].contador_atual}</p>
                      )}
                      <p>Coletado em: {formatDate(impressora.contadores[impressora.contadores.length -1].data_registro)}</p>
                    </div>
                  ) : (
                    <p>Sem dados de contador</p>
                  )}
                </div>
                <div>
                  <p>Nível de toner: {}</p>
                </div>
              </li>
            </ul>
          </div>
        ))}
      </div>
    </main>
  );
}
