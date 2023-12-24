from .models import Impressora, Contador
from .database import SessionLocal
from fastapi import HTTPException
from typing import Optional, List
from .services.get_multifuncional import get_info_multi, oidContadorMulti, oidNivelTonerMulti
from .services.get_zebra import get_info_zebra

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

# Rota pra atualizar os valores individuais da impressora
def atualizar_impressora(
    impressora_id: int,
    nome: Optional[str] = None,
    ip: Optional[str] = None,
    selb: Optional[str] = None,
    setor: Optional[str] = None,
    tipo: Optional[str] = None,
    nivel_toner: Optional[str] = None,
    modelo: Optional[str] = None,
    status: Optional[str] = None
    ) :
    db = SessionLocal()
    try:
        # Verifica se a impressora existe
        impressora = db.query(Impressora).filter(Impressora.id == impressora_id).first()
        if not impressora:
            raise HTTPException(status_code=404, detail="Impressora não encontrada")

        # Atualiza os campos fornecidos na requisição, se não forem nulos
        fields = ["nome", "ip", "selb", "setor", "tipo", "nivel_toner", "modelo", "status"]
        for field in fields:
            value = locals()[field]
            if value is not None:
                setattr(impressora, field, value)

        # Commit para salvar no banco
        db.commit()

        return {"message": "Impressora atualizada com sucesso", "impressora_id": impressora_id}
    finally:
        db.close()

# Atualiza os contadores em tempo real
def atualizar_contador(printers_id: dict):
    db = SessionLocal()
    try:
        for impressora_id in printers_id:
            print(impressora_id)
            impressora = db.query(Impressora).filter(Impressora.id == impressora_id).first()
            if not impressora:
                raise HTTPException(status_code=404, detail=f"ImpressoraId {impressora_id} não encontrada")

            if impressora.tipo == "multifuncional":
                contador_atual = get_info_multi(impressora.ip, oidContadorMulti)
                nivel_toner = get_info_multi(impressora.ip, oidNivelTonerMulti)
                impressora.contadores.append(Contador(contador=contador_atual))
                impressora.nivel_toner = nivel_toner

            elif impressora.tipo == "zebra":
                contador_atual = get_info_zebra(impressora.ip)
                impressora.contadores.append(Contador(contador=contador_atual))

        db.commit()
        return {'message': 'Impressoras atualizadas com sucesso!'}

    finally:
        db.close()