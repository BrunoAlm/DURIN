from .models import Impressora, Contador
from fastapi import APIRouter
from .database import SessionLocal  # Importe sua sessão do banco de dados

router = APIRouter()

@router.get("/impressoras")
async def list_printers():
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
        db.close()  # Certifique-se de fechar a sessão após a consulta
