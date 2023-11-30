from app import db
from datetime import datetime

class Contador(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(50))
    ip = db.Column(db.String(15))
    selb = db.Column(db.String(10))
    setor = db.Column(db.String(50))
    historico_contadores = db.Column(db.JSON)  # Campo de lista para armazenar histórico de contadores
    data_retirada = db.Column(db.DateTime, default=datetime.utcnow)  # Campo para a data de retirada

    def __repr__(self):
        return f"<Contador {self.nome}>"
