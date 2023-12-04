from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
from app import db

class Contador(db.Model):
    __tablename__ = 'contadores_historico'

    id = db.Column(db.Integer, primary_key=True)
    contador_atual = db.Column(db.Integer)
    data_registro = db.Column(db.DateTime)
    impressora_id = db.Column(db.Integer, db.ForeignKey('impressoras.id'))

    def __init__(self, contador_atual, data_registro=None, impressora_id=None):
        self.contador_atual = contador_atual
        if data_registro is None:
            self.data_registro = datetime.now()  # Utiliza a data e hora atual se não for fornecida
        else:
            self.data_registro = datetime.strptime(data_registro, '%Y-%m-%d %H:%M:%S')  # Converte a string para datetime
        self.impressora_id = impressora_id

    def serialize(self):
        return {
            'id': self.id,
            'contador_atual': self.contador_atual,
            'data_registro': self.data_registro.strftime('%Y-%m-%d %H:%M:%S'),  # Formata para string no formato desejado
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
    contadores = db.relationship('Contador', backref='impressora', lazy=True)

    def __init__(self, ip, nome, selb, setor, tipo, contadores):
        self.ip = ip
        self.nome = nome
        self.selb = selb
        self.setor = setor
        self.tipo = tipo
        self.contadores = contadores

    def serialize(self):
        return {
            'id': self.id,
            'ip': self.ip,
            'nome': self.nome,
            'selb': self.selb,
            'setor': self.setor,
            'tipo': self.tipo,
            'contadores': self.contadores
        }
