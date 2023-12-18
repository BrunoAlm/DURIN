from fastapi import APIRouter
from .repositories import adicionar_contador, listar_impressoras, update_impressora
from typing import Optional
from pydantic import BaseModel

class ContadorInput(BaseModel):
    impressora_id: int
    contador_atual: int
    
class PrinterUpdate(BaseModel):
    impressora_id: int
    nome: Optional[str] = None
    ip: Optional[str] = None
    selb: Optional[str] = None
    setor: Optional[str] = None
    tipo: Optional[str] = None
    nivel_toner: Optional[int] = None
    modelo: Optional[str] = None
    status: Optional[str] = None
    
router = APIRouter()

@router.get("/api/impressoras")
async def list_printers():
    return listar_impressoras()

@router.post("/api/impressoras/contador")
async def add_contador(printer_data: ContadorInput):
    return adicionar_contador(printer_data.impressora_id, printer_data.contador_atual)

@router.put("/api/impressoras")
async def update_printers(printer_data: PrinterUpdate):
    return update_impressora(
        printer_data.impressora_id,
        printer_data.nome,
        printer_data.ip,
        printer_data.selb,
        printer_data.setor,
        printer_data.tipo,
        printer_data.nivel_toner,
        printer_data.modelo,
        printer_data.status
    )