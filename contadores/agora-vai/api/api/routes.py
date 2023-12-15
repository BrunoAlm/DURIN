from fastapi import APIRouter
from .repositories import adicionar_contador, listar_impressoras

router = APIRouter()

@router.get("/impressoras")
async def list_printers():
    return listar_impressoras()

@router.post("/impressoras/{impressora_id}/contador")
async def add_contador(impressora_id: int, contador_atual: int):
    return adicionar_contador(impressora_id, contador_atual)