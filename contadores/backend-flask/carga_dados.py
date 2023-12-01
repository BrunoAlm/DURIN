from flask import Flask
from flask_sqlalchemy import SQLAlchemy
import json
from datetime import datetime

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///../app/db/contadores.db'
db = SQLAlchemy(app)


class Contador(db.Model):
    __tablename__ = 'contadores_historico'

    id = db.Column(db.Integer, primary_key=True)
    contador_atual = db.Column(db.Integer)
    data_registro = db.Column(db.DateTime)
    impressora_id = db.Column(db.Integer, db.ForeignKey('impressoras.id'))
    impressora = db.relationship('Impressora', backref='contadores')  # Define a relação com Impressora

    def __init__(self, contador_atual, data_registro, impressora_id):  # Adiciona impressora_id ao construtor
        self.contador_atual = contador_atual
        self.data_registro = data_registro
        self.impressora_id = impressora_id  # Define impressora_id

    def serialize(self):
        return {
            'id': self.id,
            'contador_atual': self.contador_atual,
            'data_registro': self.data_registro.strftime('%Y-%m-%d %H:%M:%S'),
            'impressora_id': self.impressora_id
        }

class Impressora(db.Model):
    __tablename__ = 'impressoras'

    id = db.Column(db.Integer, primary_key=True)
    ip = db.Column(db.String(15))
    nome = db.Column(db.String(15))
    selb = db.Column(db.String(20))
    setor = db.Column(db.String(50))
    tipo = db.Column(db.String(20))

    def __init__(self, ip, nome, selb, setor, tipo):
        self.ip = ip
        self.nome = nome
        self.selb = selb
        self.setor = setor
        self.tipo = tipo

    def serialize(self):
        return {
            'id': self.id,
            'nome': self.nome,
            'ip': self.ip,
            'selb': self.selb,
            'setor': self.setor,
            'tipo': self.tipo
        }


# Carregar os dados do arquivo JSON
with open('./api/data/impressoras.json', 'r', encoding='utf-8') as arquivo:
    dados = json.load(arquivo)
# Usando o contexto da aplicação Flask para interagir com o banco de dados
with app.app_context():
    db.create_all()
    # Carga dos dados no banco de dados
    for tipo, impressoras in dados['impressoras'].items():
        for nome, detalhes in impressoras.items():
            ip = detalhes['ip']
            selb = detalhes['selb']
            setor = detalhes['setor']
            tipo_impressora = tipo

            # Criar uma instância do modelo Impressora
            impressora = Impressora(ip=ip, nome=nome, selb=selb, setor=setor, tipo=tipo_impressora)

            # Salvar a instância no banco
            db.session.add(impressora)
            db.session.commit()  # Commit para salvar a instância no banco

            # Supondo que já tenha o ID da impressora salvo, podemos criar um contador fictício
            contador_atual = 0
            data_registro = datetime.now()

            # Criar uma instância do modelo Contador relacionando com a impressora
            contador = Contador(contador_atual=contador_atual, data_registro=data_registro, impressora_id=impressora.id)

            # Salvar a instância do contador no banco
            db.session.add(contador)
            db.session.commit()  # Commit para salvar a instância do contador no banco