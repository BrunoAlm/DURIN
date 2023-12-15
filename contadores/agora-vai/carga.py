from api.api.models import Contador, Impressora
from api.api.database import SessionLocal
import json

# Carregar os dados do arquivo JSON
with open('./impressoras.json', 'r', encoding='utf-8') as arquivo:
    dados = json.load(arquivo)

# Criar uma sessão do banco de dados
db = SessionLocal()



try:
    # Carga dos dados no banco de dados
    for tipo, impressoras in dados['impressoras'].items():
        for nome, detalhes in impressoras.items():
            # Crie um Contador associado à Impressora
            contador = Contador(
                contador_atual=0,  # Valor inicial do contador
            )

            # Crie a impressora
            impressora = Impressora(
                ip=detalhes['ip'],
                nome=nome,
                selb=detalhes['selb'],
                setor=detalhes['setor'],
                tipo=tipo,
                nivel_toner=0,  # Ajuste: Valor direto, não uma tupla
                modelo='Modelo Padrão',  # Ajuste: Valor direto, não uma tupla
                status='N/A',  # Ajuste: Valor direto, não uma tupla
                contadores=[contador]
            )

            # Adicione o Contador à sessão do banco de dados
            db.add(contador)

            # Adicione a impressora à sessão do banco de dados
            db.add(impressora)

    # Commit para salvar todas as instâncias no banco
    db.commit()
finally:
    db.close()  # Fechar a sessão do banco de dados após a carga de dados
