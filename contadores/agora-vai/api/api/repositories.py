from .models import Impressora, Contador
from .database import SessionLocal  # Importe sua sessão do banco de dados
from fastapi import HTTPException

# Função para adicionar um contador a uma impressora específica
def adicionar_contador(impressora_id: int, contador_atual: int):
    db = SessionLocal()
    try:
        # Verifica se a impressora existe
        impressora = db.query(Impressora).filter(Impressora.id == impressora_id).first()
        if not impressora:
            raise HTTPException(status_code=404, detail="Impressora não encontrada")

        # Cria um novo contador associado à impressora
        novo_contador = Contador(contador=contador_atual, impressora_id=impressora_id)

        # Adiciona o contador à impressora
        impressora.contadores.append(novo_contador)

        # Commit para salvar no banco
        db.commit()
        db.refresh(novo_contador)

        return novo_contador
    finally:
        db.close()
        
# Função que lista todas as impressoras no banco
def listar_impressoras():
    db = SessionLocal()  # Crie uma instância da sessão do banco de dados

    try:
        impressoras = db.query(Impressora).all()  # Use a sessão para consultar Impressora

        dados_impressoras = []
        for impressora in impressoras:
            contadores = db.query(Contador).filter_by(impressora_id=impressora.id).all()
            contadores_serializados = [
                {
                    'id': contador.id,
                    'impressora_id': contador.impressora_id,
                    'contador': contador.contador,
                    'data_registro': contador.data_registro.strftime('%Y-%m-%d %H:%M:%S')
                }
                for contador in contadores
            ]

            dados_impressora = {
                'id': impressora.id,
                'nome': impressora.nome,
                'ip': impressora.ip,
                'selb': impressora.selb,
                'setor': impressora.setor,
                'tipo': impressora.tipo,
                'nivel_toner': impressora.nivel_toner,
                'modelo': impressora.modelo,
                'status': impressora.status,
                'contadores': contadores_serializados
            }

            dados_impressoras.append(dados_impressora)

        return dados_impressoras

    finally:
        db.close()