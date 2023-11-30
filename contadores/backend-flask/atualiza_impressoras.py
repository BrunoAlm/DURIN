from flask import Flask
from flask_sqlalchemy import SQLAlchemy
import json
from datetime import datetime
from app.models.models import Impressora, Contador

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///../app/db/contadores.db'
db = SQLAlchemy(app)



# Atualizar os registros existentes com os dados atualizados do JSON
with app.app_context():

    # Carregar os dados do arquivo JSON
    with open('./api/data/impressoras.json', 'r', encoding='utf-8') as arquivo:
        dados_atualizados = json.load(arquivo)
    
    # Buscar todos os registros de impressoras do banco de dados
    impressoras_banco = Impressora.query.all()
    
    for tipo, impressoras in dados_atualizados['impressoras'].items():
        for nome, detalhes in impressoras.items():
            ip = detalhes['ip']
            selb = detalhes['selb']
            setor = detalhes['setor']
            tipo_impressora = tipo

            # Verificar se a impressora já existe no banco de dados
            impressora_existente = next((imp for imp in impressoras_banco if imp.ip == ip), None)

            if impressora_existente:
                # Se existir, atualize os detalhes com os dados do arquivo JSON
                impressora_existente.selb = selb
                impressora_existente.setor = setor
                impressora_existente.tipo = tipo_impressora
            else:
                # Se não existir, crie uma nova instância de Impressora e Contador vazio
                nova_impressora = Impressora(ip=ip, selb=selb, setor=setor, tipo=tipo_impressora)
                db.session.add(nova_impressora)
                db.session.commit()  # Salve a impressora no banco

                # Agora podemos criar um contador vazio relacionado à nova impressora
                novo_contador = Contador(contador_atual=0, data_registro=datetime.now(), impressora_id=nova_impressora.id)
                db.session.add(novo_contador)
                db.session.commit()  # Salve o contador no banco

# Commit para salvar as atualizações no banco de dados
db.session.commit()
