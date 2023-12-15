from fastapi import APIRouter
from .repositories import adicionar_contador, listar_impressoras, update_impressora
from typing import Optional

router = APIRouter()

@router.get("/impressoras")
async def list_printers():
    return listar_impressoras()

@router.post("/impressoras/contador")
async def add_contador(impressora_id: int, contador_atual: int):
    return adicionar_contador(impressora_id, contador_atual)

@router.put("/impressoras")
async def update_printers(
    impressora_id: int,
    nome: Optional[str] = None,
    ip: Optional[str] = None,
    selb: Optional[str] = None,
    setor: Optional[str] = None,
    tipo: Optional[str] = None,
    nivel_toner: Optional[int] = None,
    modelo: Optional[str] = None,
    status: Optional[str] = None
    ) :
    return update_impressora(impressora_id, nome, ip, selb, setor, tipo, nivel_toner, modelo, status)