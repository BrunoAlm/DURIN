from sqlalchemy import Column, Integer, String, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base
from datetime import datetime

Base = declarative_base()

class Contador(Base):
    __tablename__ = 'contadores'

    id = Column(Integer, primary_key=True)
    contador = Column(String(15))
    data_registro = Column(DateTime)
    impressora_id = Column(Integer, ForeignKey('impressoras.id'))

    def __init__(self, contador, data_registro=None, impressora_id=None):
        self.contador = contador
        if data_registro is None:
            self.data_registro = datetime.now()
        else:
            self.data_registro = datetime.strptime(data_registro, '%Y-%m-%d %H:%M:%S')
        self.impressora_id = impressora_id

    def serialize(self):
        return {
            'id': self.id,
            'contador': self.contador,
            'data_registro': self.data_registro.strftime('%Y-%m-%d %H:%M:%S'),
            'impressora_id': self.impressora_id
        }

class Impressora(Base):
    __tablename__ = 'impressoras'

    id = Column(Integer, primary_key=True)
    ip = Column(String(15))
    nome = Column(String(15))
    selb = Column(String(20))
    setor = Column(String(20))
    tipo = Column(String(20))
    nivel_toner = Column(Integer)
    modelo = Column(String(20))
    status = Column(String(30))
    
    contadores = relationship('Contador', backref='impressora', lazy=True, cascade='all, delete-orphan', passive_deletes=True)

    def __init__(self, ip, nome, selb, setor, tipo, nivel_toner, modelo, status, contadores):
        self.ip = ip
        self.nome = nome
        self.selb = selb
        self.setor = setor
        self.tipo = tipo
        self.nivel_toner = nivel_toner
        self.modelo = modelo
        self.status = status
        self.contadores = contadores
    

    def serialize(self):
        return {
            'id': self.id,
            'ip': self.ip,
            'nome': self.nome,
            'selb': self.selb,
            'setor': self.setor,
            'tipo': self.tipo,
            'nivel_toner': self.nivel_toner,
            'modelo': self.modelo,
            'status': self.status,
            'contadores': self.contadores
        }
