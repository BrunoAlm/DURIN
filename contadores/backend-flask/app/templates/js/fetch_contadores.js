document.addEventListener('DOMContentLoaded', () => {
    fetch('http://localhost:5000/api/impressoras')
        .then(response => response.json())
        .then(data => {
            const impressorasZebraDiv = document.getElementById('impressoras-zebra');
            const impressorasMultifuncionalDiv = document.getElementById('impressoras-multifuncional');
            const impressoras = data;

            impressoras.forEach(impressora => {
                const cardDiv = document.createElement('div');
                cardDiv.classList.add('card', 'mb-3');
                cardDiv.style.width = '400px'; // Definindo o tamanho fixo de 400px de largura

                const cardBody = document.createElement('div');
                cardBody.classList.add('card-body');

                const cardTitle = document.createElement('h5');
                cardTitle.classList.add('card-title');
                cardTitle.textContent = `${impressora.nome}, IP: ${impressora.ip}`;

                const cardText = document.createElement('p');
                cardText.classList.add('card-text');
                cardText.textContent = `Selb: ${impressora.selb}, Setor: ${impressora.setor}`;

                // Verifica se há contadores e mostra apenas os dois últimos registros
                if (impressora.contadores.length > 0) {
                    const ultimoContador = impressora.contadores[impressora.contadores.length - 1];
                    const penultimoContador = impressora.contadores[impressora.contadores.length - 2] || {};

                    const contadorTexto = document.createElement('p');
                    contadorTexto.textContent = `Contador Atual: ${ultimoContador.contador_atual}, Data: ${ultimoContador.data_registro}`;
                    cardText.appendChild(contadorTexto);

                    const contadorAnteriorTexto = document.createElement('p');
                    contadorAnteriorTexto.textContent = `Contador Anterior: ${(penultimoContador.contador_atual !== undefined) ? penultimoContador.contador_atual : 0}, Data: ${penultimoContador.data_registro || 'N/A'}`;
                    cardText.appendChild(contadorAnteriorTexto);
                } else {
                    const semContadoresTexto = document.createElement('p');
                    semContadoresTexto.textContent = 'N/A';
                    cardText.appendChild(semContadoresTexto);
                }

                const btnHistorico = document.createElement('button');
                btnHistorico.classList.add('btn', 'btn-primary');
                btnHistorico.textContent = 'Histórico';
                btnHistorico.addEventListener('click', () => {
                    // Adicione aqui o código para visualizar o histórico da impressora
                    console.log('Visualizar histórico da impressora ID:', impressora.id);
                });

                cardBody.appendChild(cardTitle);
                cardBody.appendChild(cardText);
                cardBody.appendChild(btnHistorico);

                cardDiv.appendChild(cardBody);

                if (impressora.tipo === 'zebra') {
                    impressorasZebraDiv.appendChild(cardDiv);
                } else if (impressora.tipo === 'multifuncional') {
                    impressorasMultifuncionalDiv.appendChild(cardDiv);
                }
            });
        })
        .catch(error => {
            console.error('Erro ao buscar dados:', error);
        });
});
